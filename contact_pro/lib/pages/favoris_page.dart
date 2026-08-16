import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  // int _selectedIndex = 2; // Favoris sélectionné

  List<Map<String, dynamic>> contacts = [
    // {'nom': 'Emma Dupont', 'couleur': Colors.pink.shade100, 'icone': '👩'},
    // {'nom': 'Lucas Bernard', 'couleur': Colors.blue.shade100, 'icone': '🧑'},
    // {'nom': 'Sophie Martin', 'couleur': Colors.purple.shade100, 'icone': '👩'},
    // {'nom': 'David Leroy', 'couleur': Colors.orange.shade100, 'icone': '🧑'},
    // {'nom': 'Alice Moreau', 'couleur': Colors.teal.shade100, 'icone': '👩'},
    // {'nom': 'Bastien Dubois', 'couleur': Colors.green.shade100, 'icone': '🧑'},
  ];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getFavoris();
  }

  Future<void> getFavoris() async {
    // Étape 1 : récupérer l'utilisateur connecté
    final user = FirebaseAuth.instance.currentUser;

    // Si aucun utilisateur n'est connecté, on arrête la fonction
    if (user == null) return;

    // Étape 2 : afficher le loader
    setState(() {
      isLoading = true;
    });

    try {
      // Étape 3 : récupérer uniquement les contacts favoris
      final snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .where('estFavorite', isEqualTo: true)
          .get();

      // Étape 4 : créer une liste vide
      List<Map<String, dynamic>> favoris = [];

      // Étape 5 : parcourir tous les documents
      for (var doc in snapshot.docs) {
        final data = doc.data();

        favoris.add({
          'id': doc.id,
          'nom': '${data['prenom']} ${data['nom']}',
          'telephone': data['telephone'] ?? '',
          'sexe': data['sexe'] ?? '',
          'couleur': data['sexe'] == 'Féminin'
              ? Colors.pink.shade100
              : Colors.blue.shade100,
          'icone': data['sexe'] == 'Féminin' ? Icons.woman : Icons.man,
          'estFavorite': data['estFavorite'] ?? false,
        });
      }

      // Étape 6 : trier les favoris par ordre alphabétique
      favoris.sort((a, b) => a['nom'].compareTo(b['nom']));

      // Étape 7 : mettre à jour l'interface
      if (!mounted) return;

      setState(() {
        contacts = favoris;
      });
    } catch (e) {
      // Étape 8 : afficher un message d'erreur
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors du chargement des favoris'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Étape 9 : masquer le loader
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  /// Fonction qui ouvre l'application Téléphone
  /// avec le numéro du contact.
  Future<void> appelerContact(String numero) async {
    // Étape 1 : créer une URI (adresse) de type téléphone.
    //
    // scheme: 'tel' indique que nous voulons ouvrir
    // l'application Téléphone.
    //
    // path contient le numéro à appeler.
    //
    // Exemple :
    // tel:70000000
    final Uri uri = Uri(scheme: 'tel', path: numero);

    // Étape 2 : vérifier si le téléphone peut ouvrir cette URI.
    try {
      // Étape 3 : ouvrir l'application Téléphone.
      //
      // Le numéro sera automatiquement placé
      // dans l'écran d'appel.
      await launchUrl(uri);
    } catch (e) {
      // Étape 4 : afficher une erreur si l'application
      // Téléphone ne peut pas être ouverte.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Impossible d’ouvrir l’application Téléphone')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 0.78,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16,
                      children: contacts.map((contact) {
                        return GestureDetector(
                          onTap: () {
                            appelerContact(contact['telephone']);
                          },
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    backgroundColor:
                                        contact['couleur'] as Color,
                                    child: Icon(
                                      contact['icone'] as IconData,
                                      size: 32,
                                    ),
                                  ),
                                  Positioned(
                                    top: -2,
                                    right: -2,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                contact['nom'] as String,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6C63FF), Color(0xFF5A4FE0)],
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Vos contacts favoris',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Accédez rapidement à vos contacts les plus importants.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.contact_page_outlined,
                            color: Colors.white.withOpacity(0.9),
                            size: 40,
                          ),
                          // Image.asset(

                          //   'assets/images/contact_icon.png',
                          //   width: 40,
                          //   height: 40,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8,
      //   child: SizedBox(
      //     height: 60,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         _navItem(Icons.home, 'Accueil', 0),
      //         _navItem(Icons.contacts, 'Contacts', 1),
      //         const SizedBox(width: 48), // espace pour le bouton central
      //         _navItem(Icons.favorite, 'Favoris', 3, activeColor: Colors.blue),
      //         _navItem(Icons.grid_view, 'Catégories', 4),
      //       ],
      //     ),
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   onPressed: () {},
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    
  }

  // Widget _navItem(IconData icon, String label, int index, {Color? activeColor}) {
  //   final bool isSelected = _selectedIndex == index;
  //   final Color color = isSelected ? (activeColor ?? Colors.blue) : Colors.grey;
  //   return GestureDetector(
  //     onTap: () => setState(() => _selectedIndex = index),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(icon, color: color, size: 24),
  //         const SizedBox(height: 2),
  //         Text(label, style: TextStyle(color: color, fontSize: 11)),
  //       ],
  //     ),
  //   );
  // }
}
