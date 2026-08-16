import 'package:contact_pro/pages/categorie_page.dart';
import 'package:contact_pro/pages/contact_page.dart';
import 'package:contact_pro/pages/favoris_page.dart';
import 'package:contact_pro/pages/home_page.dart';
import 'package:contact_pro/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BarreNavigation extends StatefulWidget {
  const BarreNavigation({Key? key}) : super(key: key);

  @override
  State<BarreNavigation> createState() => _CustomBottomNavBarScreenState();
}

class _CustomBottomNavBarScreenState extends State<BarreNavigation> {
  int _selectedIndex = 0; // "Contacts" est sélectionné sur l'image
  final List _pages = [
    HomePage(),
    ContactPage(),
    FavorisPage(),
    PageCategories(),
  ];
  String email = '';
  String nom = 'Utilisateur';
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (!mounted) return;

    setState(() {
      email = user.email ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5B3EFF); // Violet / Bleu
    const Color unselectedColor = Color(0xFF707070);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            // =========================
            // En-tête du drawer
            // =========================
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
              ),
              accountName: Text(nom),
              accountEmail: Text(email),
              decoration: const BoxDecoration(color: Colors.deepPurple),
            ),

            // =========================
            // Accueil
            // =========================
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),

            // =========================
            // Contacts
            // =========================
            ListTile(
              leading: const Icon(Icons.contacts_outlined),
              title: const Text('Tous les contacts'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),

            // =========================
            // Favoris
            // =========================
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoris'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),

            // =========================
            // Catégories
            // =========================
            ListTile(
              leading: const Icon(Icons.folder_outlined),
              title: const Text('Catégories'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),

            const Divider(),

            // =========================
            // À propos
            // =========================
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('À propos'),
              onTap: () {
                Navigator.pop(context);

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('À propos de Contact Pro'),
                      content: const Text(
                        'Contact Pro est une application de gestion de contacts '
                        'développée avec Flutter et Firebase. Elle permet '
                        'd’ajouter, modifier, supprimer, rechercher et organiser '
                        'les contacts par catégories, tout en gérant les favoris '
                        'et les informations personnelles de chaque utilisateur.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fermer'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            const Spacer(),

            // =========================
            // Déconnexion
            // =========================
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Se déconnecter',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () async {
                Navigator.pop(context);

                await FirebaseAuth.instance.signOut();

                // if (!context.mounted) return;

                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (_) => const LoginPage()),
                // );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_getTitle()),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Bords très arrrondis
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          // shape:
          // const CircularNotchedRectangle(), // Si vous souhaitez une encoche sous le bouton (optionnel)
          // notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Onglet 1: Accueil
                _buildNavItem(
                  icon: Icons.home,
                  label: 'Accueil',
                  index: 0,
                  primaryColor: primaryColor,
                  unselectedColor: unselectedColor,
                ),
                // Onglet 2: Contacts
                _buildNavItem(
                  icon: Icons.person_rounded,
                  label: 'Contacts',
                  index: 1,
                  primaryColor: primaryColor,
                  unselectedColor: unselectedColor,
                ),

                // Espace réservé pour le FloatingActionButton central
                // const SizedBox(width: 64),

                // Onglet 3: Favoris
                _buildNavItem(
                  icon: Icons.favorite,
                  label: 'Favoris',
                  index: 2,
                  primaryColor: primaryColor,
                  unselectedColor: unselectedColor,
                ),
                // Onglet 4: Catégories
                _buildNavItem(
                  icon: Icons.grid_view_rounded,
                  label: 'Catégories',
                  index: 3,
                  primaryColor: primaryColor,
                  unselectedColor: unselectedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget personnalisé pour chaque item de navigation
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color primaryColor,
    required Color unselectedColor,
  }) {
    final bool isSelected = _selectedIndex == index;
    final Color color = isSelected ? primaryColor : unselectedColor;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Accueil';
      case 1:
        return 'Contacts';
      case 2:
        return 'Favoris';
      case 3:
        return 'Catégories';
      default:
        return '';
    }
  }
}
