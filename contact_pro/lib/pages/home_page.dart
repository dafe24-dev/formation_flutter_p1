import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name =  "";
  List<Map<String, dynamic>> recentContacts = [];
  int totalContacts = 0;
  int totalCategories = 0;
  int totalFavoris = 0;
  int ajoutsRecents = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> getRecentContacts() async {
    // Récupérer l'utilisateur connecté
    final user = FirebaseAuth.instance.currentUser;

    // Si aucun utilisateur n'est connecté
    if (user == null) return;

    try {
      // Récupérer les 3 contacts les plus récents
      final snapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .orderBy(
            'createdAt',
            descending: true,
          ) // Du plus récent au plus ancien
          .limit(3) // Limiter à 3 contacts
          .get();

      // Créer une liste vide qui contiendra les contacts récents
      List<Map<String, dynamic>> contacts = [];

      // Parcourir tous les documents récupérés depuis Firestore
      for (var doc in snapshot.docs) {
        // Récupérer les données du document
        final data = doc.data();

        // Ajouter un nouveau contact dans la liste
        contacts.add({
          'id': doc.id,
          'nom': '${data['prenom']} ${data['nom']}',
          'telephone': data['telephone'] ?? '',
        });
      }

      // Retourner la liste des contacts
      setState(() {
        recentContacts = contacts;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur est survenue. Veuillez réessayer.')),
      );
    }
  }

  Future<void> getStats() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Nombre total de contacts
      final contactsSnapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .get();

      // 2. Nombre total de catégories
      final categoriesSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .where('userId', isEqualTo: user.uid)
          .get();

      // 3. Nombre de favoris
      final favorisSnapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .where('estFavorite', isEqualTo: true)
          .get();

      // 4. Nombre des contacts ajoutés aujourd’hui
      final aujourdHui = DateTime.now();
      final debutJour = DateTime(
        aujourdHui.year,
        aujourdHui.month,
        aujourdHui.day,
      );

      final recentsSnapshot = await FirebaseFirestore.instance
          .collection('contacts')
          .where('userId', isEqualTo: user.uid)
          .where(
            'createdAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(debutJour),
          )
          .get();

      if (!mounted) return;

      setState(() {
        totalContacts = contactsSnapshot.docs.length;
        totalCategories = categoriesSnapshot.docs.length;
        totalFavoris = favorisSnapshot.docs.length;
        ajoutsRecents = recentsSnapshot.docs.length;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors du chargement des statistiques'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  
  Future<void> getUser() async{
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null){
       final doc = await FirebaseFirestore.instance
        .collection('utilisateur')
        .doc(user.uid)
        .get();
        if(doc.exists){
          setState(() {
            name = doc.data()?['nom'];
          });
        }
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👉 Texte de bienvenue
              Text(
                'Bonjour, $name 👋',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Voici ce qui se passe aujourd’hui',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 53, 52, 52),
                ),
              ),
              const SizedBox(height: 20),

              // 👉 CONTENEUR GLOBAL DE LA GRILLE
              // Mets un Container ou SizedBox autour pour contrôler la hauteur/largeur de toute la grill
              GridView.count(
                crossAxisCount:
                    2, // 👉 Nombre de colonnes (2 colonnes → 2 lignes avec 4 éléments)
                crossAxisSpacing:
                    10, // 👉 Espacement horizontal entre les rectangles
                mainAxisSpacing:
                    10, // 👉 Espacement vertical entre les rectangles
                shrinkWrap: true, // 👉 Pour que ça s'adapte dans un scroll
                physics:
                    const NeverScrollableScrollPhysics(), // 👉 Évite un double scroll
                childAspectRatio:
                    2, // 🔥 rapport largeur/hauteur (2.5 = rectangle horizontal)
                children:  [
                  // 👉 Chaque élément est un conteneur individuel (StatTile)
                  StatTile(
                    title: "Contacts",
                    number: "$totalContacts",
                    color: Colors.deepPurple,
                    icon: Icons.person,
                  ),
                  StatTile(
                    title: "Catégories",
                    number: "$totalCategories",
                    color: Colors.green,
                    icon: Icons.list,
                  ),
                  StatTile(
                    title: "Favoris",
                    number: "$totalFavoris",
                    color: Colors.pink,
                    icon: Icons.favorite,
                  ),
                  StatTile(
                    title: "Ajouts récents",
                    number: "$ajoutsRecents",
                    color: Colors.blue,
                    icon: Icons.access_time,
                  ),
                ],
              ),
              // 👉 Section "Contacts récents"
              const SizedBox(height: 20), // 👉 Espacement vertical
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // 👉 titre à gauche, lien à droite
                children: const [
                  Text(
                    "Contacts récents",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight
                          .bold, // 👉 tu peux enlever le gras si tu veux
                    ),
                  ),
                  Text(
                    "Voir tout",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue, // 👉 couleur du lien
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // 👉 Encadré avec bordure arrondie
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ), // 👉 bordure grise
                  borderRadius: BorderRadius.circular(12), // 👉 coins arrondis
                ),
                child: Column(
                  children: [
                    // Parcourir la liste des contacts
                    for (int i = 0; i < recentContacts.length; i++) ...[
                      ContactTile(
                        name: recentContacts[i]['nom'],
                        phone: recentContacts[i]['telephone'],
                      ),

                      // Afficher un Divider sauf après le dernier contact
                      if (i != recentContacts.length - 1)
                        const Divider(height: 1, color: Colors.grey),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16), // marges internes
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 51, 255),
                      Color.fromARGB(255, 17, 0, 255),
                    ],
                    begin: Alignment.topLeft, // 👉 départ du dégradé
                    end: Alignment.bottomRight, // 👉 fin du dégradé
                  ),
                  borderRadius: BorderRadius.circular(12), // coins arrondis
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 👉 Texte à gauche
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Ajoutez vos contacts \nplus facilement",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold, // titre en gras
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Organisez, retrouvez et contactez \nvos proches en toute simplicité.",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white70, // sous-titre plus clair
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 👉 Image à droite (depuis ton lien)
                    Image.network(
                      "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/38/2c/d6/382cd66e-d7cb-62e0-bce1-a63774afb893/AppIcon-0-0-1x_U007emarketing-0-10-0-0-85-220.png/400x400ia-75.webp",
                      width: 120,
                      height: 120,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );  
    }
}

// WIDGET INDIVIDUEL POUR CHAQUE RECTANGLE
class StatTile extends StatelessWidget {
  final String title; //  Le texte du titre (ex: "Contacts")
  final String number; //  Le chiffre à afficher (ex: "248")
  final Color color; //  La couleur de fond de l'icône
  final IconData icon; //  L'icône à afficher

  const StatTile({
    super.key,
    required this.title,
    required this.number,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // 👉\ Ombre du rectangle
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ), // 👉 Coins arrondis
      color: Colors.white, // 👉 Couleur de fond du rectangle
      // CONTENEUR INDIVIDUEL DE CHAQUE RECTANGLE
      child: Container(
        height: 60, //  Hauteur du rectangle individuel (modifie cette valeur)
        padding: const EdgeInsets.all(6), //  Marges internes
        child: ListTile(
          contentPadding: EdgeInsets.all(
            3,
          ), // enlève le padding par défaut du ListTile
          // Icône à gauche
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color, //  Couleur de fond de l'icône
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white), //  Icône en blanc
          ),

          // Titre en texte normal
          title: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13, //  Taille du titre
              fontWeight: FontWeight.normal, // Pas en gras
            ),
          ),

          // Chiffre en gras et plus grand
          subtitle: Text(
            number,
            style: const TextStyle(
              fontSize: 22, // 👉 Taille du chiffre
              fontWeight: FontWeight.bold, // 👉 En gras
            ),
          ),
        ),
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String name;
  final String phone;

  const ContactTile({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ), // 👉 padding interne
      child: ListTile(
        contentPadding: EdgeInsets.zero, // 👉 enlève le padding par défaut
        leading: CircleAvatar(
          backgroundColor: Colors.transparent, // 👉 pas de fond
          child: Icon(
            Icons.person,
            color: Colors.deepPurple,
            size: 40,
          ), // 👉 icône de personne
          radius: 20,
          // 👉 bordure violette autour
          foregroundColor: Colors.deepPurple,
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // 👉 nom en gras
          ),
        ),
        subtitle: Text(
          phone,
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 61, 60, 60),
          ),
        ),
        trailing: const Icon(Icons.phone, color: Colors.deepPurple),
      ),
    );
  }
}
