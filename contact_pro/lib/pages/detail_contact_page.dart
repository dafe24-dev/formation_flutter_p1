import 'package:contact_pro/pages/modifier_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataColors {
  static const blue = Color(0xFF3526F5);
  static const ink = Color(0xFF0D143B);
  static const muted = Color(0xFF687096);
}

class ContactDetailsPage extends StatefulWidget {
  final String contactId;
  const ContactDetailsPage({super.key, required this.contactId});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  Map<String, dynamic>? contact;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getContact();
  }

  Future<void> getContact() async {
    setState(() {
      isLoading = true;
    });
    try {
      //Étape 1: Récupérer le document correspondant à l'ID
      final doc = await FirebaseFirestore.instance
          .collection('contacts')
          .doc(widget.contactId)
          .get();

      // Vérifier si le document existe
      if (doc.exists) {
        // Stocker les données du contact dans une variable locale
        final data = doc.data()!;
        // Étape 2 : récupérer la catégorie du contact
        String categorieLibelle = 'Aucune catégorie';

        final String? categorieId = data['categorieId'];

        if (categorieId != null && categorieId.isNotEmpty) {
          final categorieDoc = await FirebaseFirestore.instance
              .collection('categories')
              .doc(categorieId)
              .get();

          if (categorieDoc.exists) {
            categorieLibelle =
                categorieDoc.data()?['libelle'] ?? 'Aucune catégorie';
          }
          // Étape 3 : mettre à jour l'interface UNE SEULE FOIS
          if (!mounted) return;

          setState(() {
            contact = data;
            contact!['categorieLibelle'] = categorieLibelle;
          });
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      const SnackBar(
        content: Text('Une erreur est survenue. Veuillez réessayer.'),
        backgroundColor: Colors.red,
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 14, 28, 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: DataColors.blue,
                            size: 32,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) {
                                  return ModifierFormulaire(contactId:widget.contactId);
                                },
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                            color: DataColors.blue,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(28, 0, 28, 22),
                      child: Column(
                        children: [
                          const SizedBox(height: 2),
                          Stack(
                            clipBehavior: Clip.none,
                            children: const [
                              CircleAvatar(
                                radius: 88,
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=85',
                                ),
                              ),
                              Positioned(
                                right: -2,
                                bottom: 1,
                                child: CircleAvatar(
                                  radius: 27,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 23,
                                    backgroundColor: Color(0xFFFFAE14),
                                    child: Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 29,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 23),
                          Text(
                            '${contact?["nom"].toUpperCase()} ${contact?["prenom"].toUpperCase()}',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w800,
                              color: DataColors.ink,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${contact?["email"]}',
                            style: TextStyle(
                              fontSize: 20,
                              color: DataColors.muted,
                            ),
                          ),
                          const SizedBox(height: 36),
                          const _QuickActions(),
                          const SizedBox(height: 22),
                          _DetailsCard(contact: contact),
                          const SizedBox(height: 22),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) {
                                      return ModifierFormulaire(contactId:widget.contactId);
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DataColors.blue,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Modifier le contact',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const _BottomNavigation(),
                ],
              ),
            ),
          );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    const actions = [
      (Icons.call_rounded, 'Appeler'),
      (Icons.chat_bubble_outline_rounded, 'SMS'),
      (Icons.mail_outline_rounded, 'Email'),
      (Icons.more_horiz_rounded, 'Plus'),
    ];
    return Container(
      height: 134,
      decoration: _cardDecoration(20),
      child: Row(
        children: List.generate(actions.length, (index) {
          final action = actions[index];
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(action.$1, size: 37, color: DataColors.blue),
                        const SizedBox(height: 12),
                        Text(
                          action.$2,
                          style: const TextStyle(
                            fontSize: 16,
                            color: DataColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (index < actions.length - 1)
                  Container(
                    width: 1,
                    height: 62,
                    color: const Color(0xFFEBECF4),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  Map<String, dynamic>? contact;
  _DetailsCard({this.contact});

  @override
  Widget build(BuildContext context) {
    String ets = 'Aucune entreprise';

    if (contact?['entreprise'] != null &&
        contact!['entreprise'].toString().trim().isNotEmpty) {
      ets = contact!['entreprise'];
    }

    List rows = [
      (Icons.call_outlined, 'Téléphone', "${contact?['telephone']}", true),
      (Icons.mail_outline_rounded, 'Email', "${contact?['email']}", true),
      (Icons.business_center_outlined, 'Entreprise', ets, false),
      (
        Icons.sell_outlined,
        'Catégorie',
        "${contact?['categorieLibelle']}",
        false,
      ),
      // (Icons.cake_outlined, 'Anniversaire', '12 septembre 1992', false),
      // (Icons.location_on_outlined, 'Adresse', '15 rue de la Paix, 75001 Paris', false),
      // (Icons.description_outlined, 'Notes', 'Cliente importante. Préfère être\ncontactée par email.', false),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 21),
      decoration: _cardDecoration(21),
      child: Column(
        children: rows
            .map(
              (row) => _DetailRow(
                icon: row.$1,
                label: row.$2,
                value: row.$3,
                trailing: row.$4 ? row.$1 : null,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.trailing,
  });
  final IconData icon;
  final String label;
  final String value;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 66,
            height: 66,
            decoration: const BoxDecoration(
              color: Color(0xFFF2F1FF),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: DataColors.blue, size: 31),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: DataColors.muted),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.22,
                    fontWeight: FontWeight.w600,
                    color: DataColors.ink,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null)
            Icon(trailing, color: DataColors.blue, size: 30),
        ],
      ),
    );
  }
}

// class _BottomNavigation extends StatelessWidget {
//   const _BottomNavigation();

//   @override
//   Widget build(BuildContext context) {
//     const items = [
//       (Icons.home_outlined, 'Accueil', false),
//       (Icons.person_rounded, 'Contacts', true),
//       (Icons.favorite_border_rounded, 'Favoris', false),
//       (Icons.grid_view_rounded, 'Catégories', false),
//     ];
//     return Container(
//       height: 124,
//       padding: const EdgeInsets.fromLTRB(28, 12, 28, 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//         boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 18, offset: const Offset(0, -3))],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           _NavItem(icon: items[0].$1, label: items[0].$2, selected: false),
//           _NavItem(icon: items[1].$1, label: items[1].$2, selected: true),
//           Transform.translate(
//             offset: const Offset(0, -25),
//             child: Container(
//               height: 88, width: 88,
//               decoration: const BoxDecoration(color: DataColors.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x553526F5), blurRadius: 15, offset: Offset(0, 8))]),
//               child: const Icon(Icons.add, color: Colors.white, size: 47),
//             ),
//           ),
//           _NavItem(icon: items[2].$1, label: items[2].$2, selected: false),
//           _NavItem(icon: items[3].$1, label: items[3].$2, selected: false),
//         ],
//       ),
//     );
//   }
// }

// class _NavItem extends StatelessWidget {
//   const _NavItem({required this.icon, required this.label, required this.selected});
//   final IconData icon;
//   final String label;
//   final bool selected;
//   @override
//   Widget build(BuildContext context) {
//     final color = selected ? DataColors.blue : DataColors.muted;
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: color, size: 33),
//         const SizedBox(height: 7),
//         Text(label, style: TextStyle(color: color, fontSize: 14, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
//       ],
//     );
//   }
// }

BoxDecoration _cardDecoration(double radius) => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(radius),
  border: Border.all(color: const Color(0xFFF1F1F7)),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(.035),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ],
);
