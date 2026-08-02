import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            // 👉 Ajout de l’AppBar ici
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Action du menu
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black, size: 30),
            onPressed: () {
              // Action du profil
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👉 Texte de bienvenue
              const Text(
                'Bonjour, Emma 👋',
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
                  crossAxisCount: 2, // 👉 Nombre de colonnes (2 colonnes → 2 lignes avec 4 éléments)
                  crossAxisSpacing: 10, // 👉 Espacement horizontal entre les rectangles
                  mainAxisSpacing: 10,  // 👉 Espacement vertical entre les rectangles
                  shrinkWrap: true, // 👉 Pour que ça s'adapte dans un scroll
                  physics: const NeverScrollableScrollPhysics(), // 👉 Évite un double scroll
                  childAspectRatio: 2, // 🔥 rapport largeur/hauteur (2.5 = rectangle horizontal)
                  children: const [
                    // 👉 Chaque élément est un conteneur individuel (StatTile)
                    StatTile(title: "Contacts", number: "248", color: Colors.deepPurple, icon: Icons.person),
                    StatTile(title: "Catégories", number: "12", color: Colors.green, icon: Icons.list),
                    StatTile(title: "Favoris", number: "36", color: Colors.pink, icon: Icons.favorite),
                    StatTile(title: "Ajouts récents", number: "18", color: Colors.blue, icon: Icons.access_time),
                  ],
                ),
                // 👉 Section "Contacts récents"
                const SizedBox(height: 20), // 👉 Espacement vertical
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👉 titre à gauche, lien à droite
  children: const [
    Text(
      "Contacts récents",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold, // 👉 tu peux enlever le gras si tu veux
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
        border: Border.all(color: Colors.grey.shade300), // 👉 bordure grise
        borderRadius: BorderRadius.circular(12), // 👉 coins arrondis
      ),
      child: Column(
        children: const [
          ContactTile(name: "Lucas Bernard", phone: "06 98 76 54 32"),
          Divider(height: 1, color: Colors.grey), // 👉 trait de séparation
          ContactTile(name: "Sophie Martin", phone: "06 45 67 89 01"),
          Divider(height: 1, color: Colors.grey),
          ContactTile(name: "David Leroy", phone: "07 88 99 00 11"),
        ],
      ),
    ),
    const SizedBox(height: 20),
    Container(
  padding: const EdgeInsets.all(16), // marges internes
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [
       Color.fromARGB(255, 0, 51, 255), Color.fromARGB(255, 17, 0, 255)
      ],
      begin: Alignment.topLeft,   // 👉 départ du dégradé
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
)

             ],
          ),
        ),
      ),
    );
  }
}


// WIDGET INDIVIDUEL POUR CHAQUE RECTANGLE
class StatTile extends StatelessWidget {
  final String title;   //  Le texte du titre (ex: "Contacts")
  final String number;  //  Le chiffre à afficher (ex: "248")
  final Color color;    //  La couleur de fond de l'icône
  final IconData icon;  //  L'icône à afficher

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // 👉 Coins arrondis
      color: Colors.white, // 👉 Couleur de fond du rectangle

      // CONTENEUR INDIVIDUEL DE CHAQUE RECTANGLE
      child: Container(
      
        height: 60, //  Hauteur du rectangle individuel (modifie cette valeur)
        padding: const EdgeInsets.all(6), //  Marges internes
        child: ListTile(
          contentPadding: EdgeInsets.all(3), // enlève le padding par défaut du ListTile
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

  const ContactTile({
    super.key,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical:12), // 👉 padding interne
      child: ListTile(
        contentPadding: EdgeInsets.zero, // 👉 enlève le padding par défaut
        leading: CircleAvatar(
          backgroundColor: Colors.transparent, // 👉 pas de fond
          child: Icon(Icons.person, color: Colors.deepPurple, size: 40), // 👉 icône de personne
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
