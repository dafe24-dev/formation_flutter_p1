import 'package:flutter/material.dart';

class TabMenu extends StatelessWidget {
  const TabMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // nombre d'onglets
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabMenu'),
          elevation: 5,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Accueil'),
              Tab(text: 'Recherche'),
              Tab(text: 'Profil'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Vue Accueil')),
            Center(child: Text('Vue Recherche')),
            Center(child: Text('Vue Profil')),
          ],
        ),
      ),
    );
  }
}
