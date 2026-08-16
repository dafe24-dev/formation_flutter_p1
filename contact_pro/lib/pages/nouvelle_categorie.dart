import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NouvelleCategorie extends StatefulWidget {
  const NouvelleCategorie({super.key});

  @override
  State<NouvelleCategorie> createState() => _NouvelleCategorieState();
}

class _NouvelleCategorieState extends State<NouvelleCategorie> {
  final TextEditingController controller = TextEditingController();

  final List<Map<String, dynamic>> icons = [
    {'name': 'school', 'icon': Icons.school},
    {'name': 'groups', 'icon': Icons.groups},
    {'name': 'person', 'icon': Icons.person},
    {'name': 'star', 'icon': Icons.star},
    {'name': 'work', 'icon': Icons.work},
  ];

  int selectedIndex = 0;

  Future<void> saveCategory(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
 
    if (user == null || controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('categories').add({
        'libelle': controller.text,
        'icon': icons[selectedIndex]['name'],
        'userId': user.uid,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Catégorie enregistrée avec succès')),
      );
      
      if (!mounted) return;
   
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Une erreur est survenue. Veuillez réessayer.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(child: SizedBox(width: 40,child: Divider(),),),
          const SizedBox(height: 16),
          
          const Text('Nouvelle catégorie', style: TextStyle(fontSize: 18)),

          const SizedBox(height: 16),

          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Libellé',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: selectedIndex == index
                          ? Colors.blue
                          : Colors.grey.shade300,
                      child: Icon(icons[index]['icon'] as IconData, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => saveCategory(context),
              child: const Text('Enregistrer'),
            ),
          ),
        ],
      ),
    );
  }
}
