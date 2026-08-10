import 'package:flutter/material.dart';

class ModifierFormulaire extends StatefulWidget {
  const ModifierFormulaire({super.key});

  @override
  State<ModifierFormulaire> createState() => _ModifierFormulaireState();
}

class _ModifierFormulaireState extends State<ModifierFormulaire> {
  // Création de la clé globale pour identifier le form
  final _formKey = GlobalKey<FormState>();

  final prenomCtrl = TextEditingController(text: 'Emma');
  final nomCtrl = TextEditingController(text: 'Dupont');
  final telCtrl = TextEditingController(text: '06 12 34 56 78');
  final emailCtrl = TextEditingController(text: 'emma.dupont@email.com');
  final entrepriseCtrl = TextEditingController(text: "Creativ' Agency");
  final dateCtrl = TextEditingController(text: '15 juillet 1990');

  String type = 'Travail';
  final listeTypes = ['Travail', 'Personnel', 'Famille', 'Autre'];
  final couleur = Color(0xFF4B3DF5);

  void choisirDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 7, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        dateCtrl.text = "${date.day}/${date.month}/${date.year}";
      });
    }
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
                onPressed: () {},
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
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
                      SizedBox(height: 8),

                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enregistrer dans Contacts",
                            style: TextStyle(color: couleur, fontSize: 16),
                          ),
                          Icon(Icons.keyboard_arrow_down, color: couleur),
                        ],
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        controller: prenomCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(height: 20),

                      TextFormField(
                        controller: nomCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(height: 20),

                      TextFormField(
                        controller: telCtrl,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(height: 20),

                      TextFormField(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      SizedBox(height: 20),

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
                      SizedBox(height: 20),

                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.label),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: listeTypes
                            .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)),
                            )
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            type = val!;
                          });
                        },
                      ),
                      SizedBox(height: 20),

                      TextFormField(
                        controller: dateCtrl,
                        decoration: InputDecoration(
                          labelText: "Date de naissance (facultatif)",
                          labelStyle: TextStyle(color: couleur),
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_month),
                            onPressed: choisirDate,
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
                              print(
                                "Enregistrement dans une base de données!!",
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Contact enregistré !")),
                              );
                            }
                          },
                          child: Text(
                            "Enregistrer",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Vous avez déjà un compte ? ",
                            style: TextStyle(color: Colors.black54),
                            children: [
                              TextSpan(
                                text: "Se connecter",
                                style: TextStyle(
                                  color: couleur,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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