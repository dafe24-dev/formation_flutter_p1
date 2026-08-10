import 'package:flutter/material.dart';

// --- MODÈLES DE DONNÉES ---
class Contact {
  final String name;
  final String phone;
  final String imageUrl;
  bool isFavorite;

  Contact({
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

  // Données de démonstration basées sur votre maquette
  final List<ContactGroup> _data = [
    ContactGroup(
      letter: 'A',
      contacts: [
        Contact(
          name: 'Alice Moreau',
          phone: '06 23 45 67 89',
          imageUrl: 'https://i.pravatar.cc/150?img=1',
          isFavorite: true,
        ),
      ],
    ),
    ContactGroup(
      letter: 'B',
      contacts: [
        Contact(
          name: 'Bastien Dubois',
          phone: '07 65 43 21 09',
          imageUrl: 'https://i.pravatar.cc/150?img=12',
        ),
        Contact(
          name: 'Claire Bernard',
          phone: '06 34 56 78 90',
          imageUrl: 'https://i.pravatar.cc/150?img=5',
        ),
      ],
    ),
    ContactGroup(
      letter: 'D',
      contacts: [
        Contact(
          name: 'David Leroy',
          phone: '07 88 99 00 11',
          imageUrl: 'https://i.pravatar.cc/150?img=60',
        ),
      ],
    ),
    ContactGroup(
      letter: 'E',
      contacts: [
        Contact(
          name: 'Emma Dupont',
          phone: '06 12 34 56 78',
          imageUrl: 'https://i.pravatar.cc/150?img=9',
          isFavorite: true,
        ),
      ],
    ),
  ];

  // Alphabet pour l'index de droite
  final List<String> _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

  @override
  Widget build(BuildContext context) {
    // Couleur principale (violet) et fond doux
    const primaryColor = Color(0xFF5B41F4);
    const backgroundColor = Color(0xFFF9FAFE);

    return Scaffold(
      appBar: AppBar(title: Text('Contacts'), actions: [IconButton(onPressed: (){}, icon: Icon(Icons.search))],),
      body: Container(
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
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un contact',
                      hintStyle: TextStyle(
                        color: Color(0xFF9E9EAF),
                        fontSize: 15,
                      ),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF9E9EAF)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
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
                                        _buildContactItem(contact),
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
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(contact.imageUrl),
        ),
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
              contact.isFavorite = !contact.isFavorite;
            });
          },
        ),
      ),
    );
  }
}
