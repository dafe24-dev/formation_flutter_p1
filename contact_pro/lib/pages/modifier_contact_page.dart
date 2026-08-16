import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModifierFormulaire extends StatefulWidget {
  final String contactId;
  const ModifierFormulaire({super.key, required this.contactId});

  @override
  State<ModifierFormulaire> createState() => _ModifierFormulaireState();
}

class _ModifierFormulaireState extends State<ModifierFormulaire> {
  // Création de la clé globale pour identifier le form
  final _formKey = GlobalKey<FormState>();

  final prenomCtrl = TextEditingController();
  final nomCtrl = TextEditingController();
  final telCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final entrepriseCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  String? selectedSexe;
  String? selectedCategorieId;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = false;

  // String type = 'Travail';
  // final listeTypes = ['Travail', 'Personnel', 'Famille', 'Autre'];
  final couleur = Color(0xFF4B3DF5);

  // void choisirDate() async {
  //   DateTime? date = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime(1990, 7, 15),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //   );
  //   if (date != null) {
  //     setState(() {
  //       dateCtrl.text = "${date.day}/${date.month}/${date.year}";
  //     });
  //   }
  // }

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

  Future<void> getContact() async {
    final doc = await FirebaseFirestore.instance
        .collection('contacts')
        .doc(widget.contactId)
        .get();

    if (!doc.exists) return;

    final data = doc.data()!;

    prenomCtrl.text = data['prenom'] ?? '';
    nomCtrl.text = data['nom'] ?? '';
    telCtrl.text = data['telephone'] ?? '';
    emailCtrl.text = data['email'] ?? '';
    entrepriseCtrl.text = data['entreprise'] ?? '';

    selectedSexe = data['sexe'];
    selectedCategorieId = data['categorieId'];
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    try {
      await getCategories();
      await getContact();
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> updateContact() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedSexe == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Veuillez choisir le sexe')));
      return;
    }

    if (selectedCategorieId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez choisir une catégorie')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('contacts')
          .doc(widget.contactId)
          .update({
            'prenom': prenomCtrl.text.trim(),
            'nom': nomCtrl.text.trim(),
            'telephone': telCtrl.text.trim(),
            'email': emailCtrl.text.trim(),
            'entreprise': entrepriseCtrl.text.trim(),
            'sexe': selectedSexe,
            'estFavorite': false,
            'categorieId': selectedCategorieId,
          });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact modifié avec succès')),
      );

      Navigator.pop(context, true);
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
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: couleur),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            Text(
                              "Modifier le contact",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Enregistrer dans Contacts",
                                  style: TextStyle(
                                    color: couleur,
                                    fontSize: 16,
                                  ),
                                ),
                                Icon(Icons.keyboard_arrow_down, color: couleur),
                              ],
                            ),
                            SizedBox(height: 40),

                            TextFormField(
                              controller: prenomCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: "Prénom",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.length < 2) {
                                  return "Veuillez saisir votre prénom";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              controller: nomCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: "Nom",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.length < 2) {
                                  return "Veuillez saisir votre nom";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              controller: telCtrl,
                              keyboardType: TextInputType.phone,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: "Téléphone",
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && value.length < 8) {
                                  return "Numéro de téléphone invalide";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              controller: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value != null && !value.contains('@')) {
                                  return "Adresse email invalide";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 30),

                            TextFormField(
                              controller: entrepriseCtrl,
                              decoration: InputDecoration(
                                labelText: "Entreprise",
                                prefixIcon: Icon(Icons.work),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      entrepriseCtrl.clear();
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            DropdownButtonFormField<String>(
                              initialValue: selectedCategorieId,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.label),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: [
                                for (var cat in categories)
                                  DropdownMenuItem<String>(
                                    value: cat['id'],
                                    child: Text(cat['libelle']),
                                  ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  selectedCategorieId = val!;
                                });
                              },
                            ),
                            SizedBox(height: 30),

                            // TextFormField(
                            //   controller: dateCtrl,
                            //   decoration: InputDecoration(
                            //     labelText: "Date de naissance (facultatif)",
                            //     labelStyle: TextStyle(color: couleur),
                            //     prefixIcon: Icon(Icons.calendar_today),
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //     ),
                            //     suffixIcon: IconButton(
                            //       icon: Icon(Icons.calendar_month),
                            //       onPressed: choisirDate,
                            //     ),
                            //   ),
                            // ),
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
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            SizedBox(height: 28),

                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: couleur,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    updateContact();
                                  }
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "Enregistrer",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
