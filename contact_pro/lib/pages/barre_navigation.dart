// import 'package:contact_pro/pages/detail_contact_page.dart';
import 'package:contact_pro/pages/categorie_page.dart';
import 'package:contact_pro/pages/contact_page.dart';
import 'package:contact_pro/pages/favoris_page.dart';
import 'package:contact_pro/pages/home_page.dart';
import 'package:contact_pro/pages/nouveau_contact_page.dart';
// import 'package:contact_pro/widgets/barreNav.dart';
import 'package:contact_pro/widgets/drawer.dart';
import 'package:flutter/material.dart';

class BarreNavigation extends StatefulWidget {
  const BarreNavigation({Key? key}) : super(key: key);

  @override
  State<BarreNavigation> createState() => _CustomBottomNavBarScreenState();
}

class _CustomBottomNavBarScreenState extends State<BarreNavigation> {
  int _selectedIndex = 0; // "Contacts" est sélectionné sur l'image
  final List _pages = [HomePage(), ContactPage(), FavorisPage(), PageCategories()];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF5B3EFF); // Violet / Bleu
    const Color unselectedColor = Color(0xFF707070);

    return Scaffold(
      drawer: MyDrawer(),
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 100),
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF6B4EFF), Color(0xFF4C22FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FloatingActionButton(
          elevation: 0.1,
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => NouveauContact())),
            );
          },
          child: const Icon(Icons.add, size: 35, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          shape:
              const CircularNotchedRectangle(), // Si vous souhaitez une encoche sous le bouton (optionnel)
          notchMargin: 8.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Onglet 1: Accueil
                _buildNavItem(
                  icon: Icons.home_outlined,
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
                const SizedBox(width: 64),

                // Onglet 3: Favoris
                _buildNavItem(
                  icon: Icons.favorite_border_rounded,
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
}
