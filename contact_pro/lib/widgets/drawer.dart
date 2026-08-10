import 'package:contact_pro/pages/modifier_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:contact_pro/pages/categorie_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
  child: ListView(
    children: [

      DrawerHeader(
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("profil.jpeg",
                  
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Emma Dupont",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Voir mon profil",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      ListTile(
        leading: Icon(
          Icons.home_outlined,
          color: selectedIndex == 0 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Accueil"),
        selected: selectedIndex == 0,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 0;
          });
          Navigator.push(context, MaterialPageRoute(builder: (_)=>ModifierFormulaire()));
        },
      ),

      ListTile(
        leading: Icon(
          Icons.groups_outlined,
          color: selectedIndex == 1 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Tous les contacts"),
        selected: selectedIndex == 1,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 1;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.favorite_border,
          color: selectedIndex == 2 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Favoris"),
        selected: selectedIndex == 2,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 2;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.folder_outlined,
          color: selectedIndex == 3 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Catégories"),
        selected: selectedIndex == 3,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 3;
          });
                      Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PageCategories(),
              ),
            );
        },
      ),

      ListTile(
        leading: Icon(
          Icons.group_outlined,
          color: selectedIndex == 4 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Groupes"),
        selected: selectedIndex == 4,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 4;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.bar_chart_outlined,
          color: selectedIndex == 5 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Statistiques"),
        selected: selectedIndex == 5,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 5;
          });
        },
      ),

      Divider(),

      ListTile(
        leading: Icon(
          Icons.settings_outlined,
          color: selectedIndex == 6 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Paramètres"),
        selected: selectedIndex == 6,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 6;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.shield_outlined,
          color: selectedIndex == 7 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Confidentialité"),
        selected: selectedIndex == 7,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 7;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.notifications_none,
          color: selectedIndex == 8 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Notifications"),
        selected: selectedIndex == 8,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 8;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.help_outline,
          color: selectedIndex == 9 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("Aide et support"),
        selected: selectedIndex == 9,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 9;
          });
        },
      ),

      ListTile(
        leading: Icon(
          Icons.info_outline,
          color: selectedIndex == 10 ? Colors.deepPurple : Colors.grey,
        ),
        title: Text("À propos"),
        selected: selectedIndex == 10,
        selectedTileColor: Colors.deepPurple.shade50,
        onTap: () {
          setState(() {
            selectedIndex = 10;
          });
        },
      ),
  SizedBox(height: 45,),

      ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: Text(
          "Se déconnecter",
          style: TextStyle(color: Colors.red),
        ),
        onTap: () {},
      ),
    ],
  ),
);
  }
}