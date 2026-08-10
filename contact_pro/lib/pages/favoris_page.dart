import 'package:flutter/material.dart';

class FavorisPage extends StatefulWidget {
  const FavorisPage({super.key});

  @override
  State<FavorisPage> createState() => _FavorisPageState();
}

class _FavorisPageState extends State<FavorisPage> {
  int _selectedIndex = 2; // Favoris sélectionné

  final List<Map<String, dynamic>> contacts = [
    {'nom': 'Emma Dupont', 'couleur': Colors.pink.shade100, 'icone': '👩'},
    {'nom': 'Lucas Bernard', 'couleur': Colors.blue.shade100, 'icone': '🧑'},
    {'nom': 'Sophie Martin', 'couleur': Colors.purple.shade100, 'icone': '👩'},
    {'nom': 'David Leroy', 'couleur': Colors.orange.shade100, 'icone': '🧑'},
    {'nom': 'Alice Moreau', 'couleur': Colors.teal.shade100, 'icone': '👩'},
    {'nom': 'Bastien Dubois', 'couleur': Colors.green.shade100, 'icone': '🧑'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Favoris',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),

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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${contact['nom']} sélectionné'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundColor: contact['couleur'] as Color,
                              child: Text(
                                contact['icone'] as String,
                                style: const TextStyle(fontSize: 32),
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
                     Icon( Icons.contact_page_outlined,
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
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home, 'Accueil', 0),
              _navItem(Icons.contacts, 'Contacts', 1),
              const SizedBox(width: 48), // espace pour le bouton central
              _navItem(Icons.favorite, 'Favoris', 3, activeColor: Colors.blue),
              _navItem(Icons.grid_view, 'Catégories', 4),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _navItem(IconData icon, String label, int index, {Color? activeColor}) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? (activeColor ?? Colors.blue) : Colors.grey;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }
}