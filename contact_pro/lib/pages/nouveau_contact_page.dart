import 'package:contact_pro/pages/barre_navigation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NouveauContact extends StatefulWidget {
  const NouveauContact({super.key});

  @override
  State<NouveauContact> createState() => _NouveauContactState();
}

class _NouveauContactState extends State<NouveauContact> {
  List<Map<String, dynamic>> categories = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _entrepriseController = TextEditingController();
  String? selectedCategorieId;
  String? selectedSexe;

  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _prenomController.dispose();
    _nomController.dispose();
    _telController.dispose();
    _emailController.dispose();
    // _categorieController.dispose();
    _entrepriseController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future<void> getCategories() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('userId', isEqualTo: user.uid)
        .get();
    List<Map<String, dynamic>> temp = [];

    for (var doc in snapshot.docs) {
      temp.add({'id': doc.id, 'libelle': doc['libelle']});
    }

    setState(() {
      categories = temp;
    });
  }

  Future<void> saveContact() async {
    if (!_formKey.currentState!.validate()) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('contacts').add({
        'prenom': _prenomController.text.trim(),
        'nom': _nomController.text.trim(),
        'telephone': _telController.text.trim(),
        'email': _emailController.text.trim(),
        'entreprise': _entrepriseController.text.trim(),
        'categorieId': selectedCategorieId,
        'sexe': selectedSexe,
        'estFavorite': false,
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact enregistré avec succès')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Une erreur est survenue. Veuillez réessayer.')));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        // elevation: 42,
        title: Text(
          'Nouveau contact',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => BarreNavigation())),
            );
          },
          icon: Icon(Icons.close, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: isLoading ? null : saveContact,
            icon: isLoading
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                  )
                : Icon(Icons.check, color: Colors.deepPurpleAccent),
          ),
          SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, color: Colors.grey, size: 60),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Prénom", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _prenomController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Le prénom est obligatoire';
                                }

                                if (value.trim().length < 2) {
                                  return 'Le prénom est trop court';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nom", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _nomController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Le nom est obligatoire';
                                }

                                if (value.trim().length < 2) {
                                  return 'Le nom est trop court';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Téléphone", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _telController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Le téléphone est obligatoire';
                                }

                                if (!RegExp(r'^[0-9]{8,15}$').hasMatch(value)) {
                                  return 'Numéro invalide';
                                }

                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'L’email est obligatoire';
                                }

                                if (!RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                ).hasMatch(value)) {
                                  return 'Email invalide';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.email_outlined,
                        color: Colors.deepPurpleAccent,
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.label_outline, color: Colors.deepPurpleAccent),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Catégorie", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            DropdownButtonFormField<String>(
                              initialValue: selectedCategorieId,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              hint: const Text('Choisir une catégorie'),
                              items: [
                                for (var cat in categories)
                                  DropdownMenuItem<String>(
                                    value: cat['id'],
                                    child: Text(cat['libelle']),
                                  ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedCategorieId = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Veuillez choisir une catégorie';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.expand_more, color: Colors.deepPurpleAccent),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.work_outline, color: Colors.deepPurpleAccent),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Entreprise", style: TextStyle(fontSize: 12)),
                            SizedBox(height: 4),
                            TextFormField(
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller: _entrepriseController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                color: Colors.white,
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.wc, color: Colors.deepPurpleAccent),
                          SizedBox(width: 10),
                          Text(
                            'Sexe',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      RadioGroup<String>(
                        groupValue: selectedSexe,
                        onChanged: (value) {
                          setState(() {
                            selectedSexe = value;
                          });
                        },
                        child: Column(
                          children: const [
                            RadioListTile<String>(
                              value: 'Masculin',
                              title: Text('Masculin'),
                            ),
                            RadioListTile<String>(
                              value: 'Féminin',
                              title: Text('Féminin'),
                            ),
                          ],
                        ),
                      ),

                      if (selectedSexe == null)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Veuillez choisir le sexe',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Plus d'informations",
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.expand_more),
                    color: Colors.deepPurpleAccent,
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
