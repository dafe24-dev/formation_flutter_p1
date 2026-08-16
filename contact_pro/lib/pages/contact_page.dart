import 'package:contact_pro/pages/detail_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_pro/pages/nouveau_contact_page.dart';

// --- MODÈLES DE DONNÉES ---
class Contact {
  final String id;
  final String name;
  final String phone;
  final String imageUrl;
  bool isFavorite;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.imageUrl,
    this.isFavorite = false,
  });
}

class ContactGroup {
  final String letter;
  final List<Contact> contacts;

  ContactGroup({required this.letter, required this.contacts});
}

// --- WIDGET PRINCIPAL ---
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  // Filtre sélectionné (0 = Tous, 1 = Favoris)
  int _selectedFilterIndex = 0;
  bool isLoading = false;

  // Données de démonstration basées sur votre maquette
  List<ContactGroup> _data = [
    // ContactGroup(
    //   letter: 'A',
    //   contacts: [
    //     Contact(
    //       name: 'Alice Moreau',
    //       phone: '06 23 45 67 89',
    //       imageUrl: 'https://i.pravatar.cc/150?img=1',
    //       isFavorite: true,
    //     ),
    //   ],
    // )
  ];
  List<ContactGroup> _allData = [];
  final TextEditingController _searchController = TextEditingController();

  // Alphabet pour l'index de droite
  final List<String> _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this._searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    // Étape 1 : récupérer l'utilisateur actuellement connecté
    final user = FirebaseAuth.instance.currentUser;

    // Si aucun utilisateur n'est connecté, on arrête la fonction
    if (user == null) return;
    setState(() {
      isLoading = true;
    });
    try {
      // Étape 2 : récupérer tous les contacts de cet utilisateur dans Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .get();

      // Étape 3 : créer une liste vide qui contiendra les objets Contact
      final List<Contact> contacts = [];

      // Étape 4 : parcourir tous les documents récupérés
      for (var doc in snapshot.docs) {
        // Récupérer les données du document
        final data = doc.data();

        // Ajouter un nouveau contact dans la liste
        contacts.add(
          Contact(
            id: doc.id,
            // Construire le nom complet (Nom + Prénom)
            name: '${data['prenom']} ${data['nom']}',

            // Numéro de téléphone (vide si absent)
            phone: data['telephone'] ?? '',

            // Les initiales du contact (ex : AD pour Ali Diallo)
            imageUrl:
                '${data['prenom'][0].toUpperCase()}${data['nom'][0].toUpperCase()}',

            // Contact favori (false par défaut)
            isFavorite: data['estFavorite'] ?? false,
          ),
        );
      }

      // Étape 5 : trier les contacts par ordre alphabétique (A → Z)
      contacts.sort((a, b) => a.name.compareTo(a.name));

      // Étape 6 : créer une Map pour regrouper les contacts par lettre
      // Exemple :
      // A → [Ali, Amadou]
      // B → [Binta]
      final Map<String, List<Contact>> grouped = {};

      // Étape 7 : parcourir tous les contacts
      for (final contact in contacts) {
        // Récupérer la première lettre du nom
        final lettre = contact.name[0].toUpperCase();

        // Si la lettre n'existe pas encore dans la Map, on crée une liste vide
        grouped.putIfAbsent(lettre, () => []);

        // Ajouter le contact dans le groupe correspondant
        grouped[lettre]!.add(contact);
      }

      // Étape 8 : récupérer toutes les lettres (A, B, C...)
      final lettres = grouped.keys.toList();

      // Trier les lettres par ordre alphabétique
      lettres.sort();

      // Étape 9 : transformer la Map en une liste de ContactGroup
      final List<ContactGroup> groupes = lettres.map((lettre) {
        return ContactGroup(letter: lettre, contacts: grouped[lettre]!);
      }).toList();

      // Étape 10 : vérifier que le widget est toujours affiché
      if (!mounted) return;

      // Étape 11 : mettre à jour l'interface avec les nouveaux groupes
      setState(() {
        _allData = groupes; // liste complète
        _data = groupes; // liste affichée
      });
    } catch (e) {
      // Étape 12 : afficher un message d'erreur si une exception se produit
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur est survenue. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Ce bloc est exécuté dans tous les cas
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void searchContacts(String query) {
    // Si le champ est vide, on affiche tous les contacts
    if (query.isEmpty) {
      setState(() {
        _data = _allData;
      });
      return;
    }

    // Convertir la recherche en minuscules
    query = query.toLowerCase();

    List<ContactGroup> filteredGroups = [];

    // Parcourir tous les groupes
    for (final group in _allData) {
      // Garder uniquement les contacts qui correspondent
      final filteredContacts = group.contacts.where((contact) {
        return contact.name.toLowerCase().contains(query) ||
            contact.phone.toLowerCase().contains(query);
      }).toList();

      // Ajouter le groupe seulement s'il contient des contacts
      if (filteredContacts.isNotEmpty) {
        filteredGroups.add(
          ContactGroup(letter: group.letter, contacts: filteredContacts),
        );
      }
    }

    // Mettre à jour la liste affichée
    setState(() {
      _data = filteredGroups;
    });
  }

  Future<void> toggleFavorite(Contact contact) async {
    try {
      // Nouvelle valeur (inverse de l'ancienne)
      final newValue = !contact.isFavorite;

      // Mise à jour dans Firestore
      await FirebaseFirestore.instance
          .collection('contacts')
          .doc(contact.id)
          .update({'estFavorite': newValue});

      // Mise à jour locale de l'interface
      if (!mounted) return;

      setState(() {
        contact.isFavorite = newValue;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la mise à jour du favori'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Couleur principale (violet) et fond doux
    const primaryColor = Color(0xFF5B41F4);
    const backgroundColor = Color(0xFFF9FAFE);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        shape: CircleBorder(),
        backgroundColor: Color(0xFF4C22FF),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: ((context) => NouveauContact())),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: backgroundColor,
              child: Column(
                children: [
                  // 1. BARRE DE RECHERCHE
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4FA),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher un contact',
                          hintStyle: TextStyle(
                            color: Color(0xFF9E9EAF),
                            fontSize: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF9E9EAF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: searchContacts,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 2. BOUTONS DE FILTRES (Tous, Favoris, Trier)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        _buildFilterChip(
                          label: 'Tous',
                          isSelected: _selectedFilterIndex == 0,
                          onTap: () => setState(() => _selectedFilterIndex = 0),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          label: 'Favoris',
                          isSelected: _selectedFilterIndex == 1,
                          onTap: () => setState(() => _selectedFilterIndex = 1),
                        ),
                        const Spacer(),
                        // Bouton Trier
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F4FA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.swap_vert,
                            size: 18,
                            color: Color(0xFF1E204C),
                          ),
                          label: const Text(
                            'Trier',
                            style: TextStyle(
                              color: Color(0xFF1E204C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 3. LISTE DES CONTACTS + INDEX ALPHABÉTIQUE
                  Expanded(
                    child: Row(
                      children: [
                        // A. La liste déroulante des contacts
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 10,
                              bottom: 20,
                            ),
                            itemCount: _data.length,
                            itemBuilder: (context, groupIndex) {
                              final group = _data[groupIndex];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // En-tête de lettre (A, B, D, etc.)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 8.0,
                                      left: 4.0,
                                    ),
                                    child: Text(
                                      group.letter,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E204C),
                                      ),
                                    ),
                                  ),

                                  // Carte blanche arrondie enveloppant le ou les contacts
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.02),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: group.contacts.asMap().entries.map((
                                        entry,
                                      ) {
                                        final int index = entry.key;
                                        final Contact contact = entry.value;
                                        final bool isLast =
                                            index == group.contacts.length - 1;

                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (buildContext) {
                                                      return ContactDetailsPage(
                                                        contactId: contact.id,
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                              child: _buildContactItem(contact),
                                            ),
                                            if (!isLast)
                                              const Divider(
                                                height: 1,
                                                indent: 75,
                                                endIndent: 16,
                                                color: Color(0xFFF0F0F0),
                                              ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // B. Index alphabétique latéral (A-Z)
                        SizedBox(
                          width: 24,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _alphabet.map((letter) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 1.5,
                                  ),
                                  child: Text(
                                    letter,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8E8EA9),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // --- WIDGET COMPOSANT : Puce de Filtre (Tous / Favoris) ---
  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    const primaryColor = Color(0xFF5B41F4);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : const Color(0xFFF2F4FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1E204C),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // --- WIDGET COMPOSANT : Élément Contact ---
  Widget _buildContactItem(Contact contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(radius: 26, child: Text(contact.imageUrl)),
        title: Text(
          contact.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1E204C),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            contact.phone,
            style: const TextStyle(color: Color(0xFF8E8EA9), fontSize: 14),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            contact.isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
            color: contact.isFavorite ? Colors.amber : const Color(0xFF9E9EAF),
            size: 28,
          ),
          onPressed: () {
            setState(() {
              // contact.isFavorite = !contact.isFavorite;
              toggleFavorite(contact);
            });
          },
        ),
      ),
    );
  }
}
