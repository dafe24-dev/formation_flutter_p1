import 'package:contact_pro/pages/barre_navigation.dart';
import 'package:flutter/material.dart';

class NouveauContact extends StatefulWidget {
  const NouveauContact({super.key});

  @override
  State<NouveauContact> createState() => _NouveauContactState();
}

class _NouveauContactState extends State<NouveauContact> {

  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _categorieController = TextEditingController();
  final TextEditingController _entrepriseController = TextEditingController();

  @override
  void dispose() {
    _prenomController.dispose();
    _nomController.dispose();
    _telController.dispose();
    _emailController.dispose();
    _categorieController.dispose();
    _entrepriseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 12,
        title: Text(
          'Nouveau contact', 
          style: TextStyle(
            color: Colors.black, fontSize: 18, 
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: ((context) => BarreNavigation())),
            );
          }, 
          icon: Icon(
            Icons.close,
            color: Colors.black,
          )
        ),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.check, 
              color: Colors.deepPurpleAccent,
            )
          ),
          SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, color: Colors.grey, size: 60,),
              ),
            ),
            
            Card(
              elevation: 1,
              color: Colors.white,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline, color: Colors.deepPurpleAccent),
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
              elevation: 1,
              color: Colors.white,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outline, color: Colors.deepPurpleAccent),
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
              elevation: 1,
              color: Colors.white,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_outlined, color: Colors.deepPurpleAccent),
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.phone_outlined, color: Colors.deepPurpleAccent),
                  ],
                ),
              ),
            ),
            
            Card(
              elevation: 1,
              color: Colors.white,
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.email_outlined, color: Colors.deepPurpleAccent),
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
                    Icon(Icons.email_outlined, color: Colors.deepPurpleAccent),
                  ],
                ),
              ),
            ),
            
            Card(
              elevation: 1,
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
                          TextFormField(
                            style: TextStyle(
                              fontSize: 15, 
                              fontWeight: FontWeight.bold,
                            ),
                            controller: _categorieController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                            ),
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
              elevation: 1,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Plus d'informations",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.w600
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
    );
  }
}

