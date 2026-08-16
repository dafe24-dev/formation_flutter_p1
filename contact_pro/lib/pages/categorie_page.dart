import 'package:contact_pro/pages/nouvelle_categorie.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageCategories extends StatefulWidget {
  const PageCategories({super.key});

  @override
  State<PageCategories> createState() => _PageCategoriesState();
}

class _PageCategoriesState extends State<PageCategories> {
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('userId', isEqualTo: user.uid)
        .get();

    setState(() {
      categories = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  IconData getIcon(String name) {
    switch (name) {
      case 'school':
        return Icons.school;
      case 'groups':
        return Icons.groups;
      case 'person':
        return Icons.person;
      case 'star':
        return Icons.star;
      case 'work':
        return Icons.work;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(), 
        backgroundColor: Color(0xFF4C22FF),
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => NouvelleCategorie(),
          );
          getCategories();
        },
        child: Icon(
          Icons.add,
          color:  Colors.white,
        ),
      ),
      body: Column(
        children: [         
          SizedBox(height: 15),
          //catégories carte
          //1
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 5, left: 5, bottom: 15),
                  child: Card(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    elevation: 1,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                    color: Color.fromARGB(83, 244, 91, 142),
                                  ),
                                  child: Icon(
                                    getIcon(categories[index]['icon']),
                                    color: Colors.pink,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories[index]['libelle'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      // Text(
                                      //   "28 contacts",
                                      //   style: TextStyle(
                                      //     color: Colors.grey,
                                      //     fontSize: 14,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
