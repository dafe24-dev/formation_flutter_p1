import 'package:flutter/material.dart';

class ContactDetailsPage extends StatelessWidget {
  const ContactDetailsPage({super.key});

  static const blue = Color(0xFF3526F5);
  static const ink = Color(0xFF0D143B);
  static const muted = Color(0xFF687096);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    icon: const Icon(Icons.arrow_back, color: blue, size: 34),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined, color: blue, size: 31),
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
                              child: Icon(Icons.star_rounded, color: Colors.white, size: 29),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 23),
                    const Text(
                      'Emma Dupont',
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800, color: ink),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Designer UI/UX chez Creativ’",
                      style: TextStyle(fontSize: 20, color: muted),
                    ),
                    const SizedBox(height: 36),
                    const _QuickActions(),
                    const SizedBox(height: 22),
                    const _DetailsCard(),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text('Modifier le contact', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const _BottomNavigation(),
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
                        Icon(action.$1, size: 37, color: ContactDetailsPage.blue),
                        const SizedBox(height: 12),
                        Text(action.$2, style: const TextStyle(fontSize: 16, color: ContactDetailsPage.ink)),
                      ],
                    ),
                  ),
                ),
                if (index < actions.length - 1)
                  Container(width: 1, height: 62, color: const Color(0xFFEBECF4)),
              ],
            )
          
        
          );
        }
        ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard();

  @override
  Widget build(BuildContext context) {
    const rows = [
      (Icons.call_outlined, 'Téléphone', '06 12 34 56 78', true),
      (Icons.mail_outline_rounded, 'Email', 'emma.dupont@email.com', true),
      (Icons.business_center_outlined, 'Entreprise', "Creativ’ Agency", false),
      (Icons.sell_outlined, 'Catégorie', 'Travail', false),
      (Icons.cake_outlined, 'Anniversaire', '12 septembre 1992', false),
      (Icons.location_on_outlined, 'Adresse', '15 rue de la Paix, 75001 Paris', false),
      (Icons.description_outlined, 'Notes', 'Cliente importante. Préfère être\ncontactée par email.', false),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 21),
      decoration: _cardDecoration(21),
      child: Column(
        children: rows.map((row) => _DetailRow(
          icon: row.$1, label: row.$2, value: row.$3, trailing: row.$4 ? row.$1 : null,
        )).toList(),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value, this.trailing});
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
            decoration: const BoxDecoration(color: Color(0xFFF2F1FF), shape: BoxShape.circle),
            child: Icon(icon, color: ContactDetailsPage.blue, size: 31),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 16, color: ContactDetailsPage.muted)),
                const SizedBox(height: 6),
                Text(value, style: const TextStyle(fontSize: 17, height: 1.22, fontWeight: FontWeight.w600, color: ContactDetailsPage.ink)),
              ],
            ),
          ),
          if (trailing != null) Icon(trailing, color: ContactDetailsPage.blue, size: 30),
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Accueil', false),
      (Icons.person_rounded, 'Contacts', true),
      (Icons.favorite_border_rounded, 'Favoris', false),
      (Icons.grid_view_rounded, 'Catégories', false),
    ];
    return Container(
      height: 124,
      padding: const EdgeInsets.fromLTRB(28, 12, 28, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 18, offset: const Offset(0, -3))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _NavItem(icon: items[0].$1, label: items[0].$2, selected: false),
          _NavItem(icon: items[1].$1, label: items[1].$2, selected: true),
          Transform.translate(
            offset: const Offset(0, -25),
            child: Container(
              height: 88, width: 88,
              decoration: const BoxDecoration(color: ContactDetailsPage.blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x553526F5), blurRadius: 15, offset: Offset(0, 8))]),
              child: const Icon(Icons.add, color: Colors.white, size: 47),
            ),
          ),
          _NavItem(icon: items[2].$1, label: items[2].$2, selected: false),
          _NavItem(icon: items[3].$1, label: items[3].$2, selected: false),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.label, required this.selected});
  final IconData icon;
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    final color = selected ? ContactDetailsPage.blue : ContactDetailsPage.muted;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 33),
        const SizedBox(height: 7),
        Text(label, style: TextStyle(color: color, fontSize: 14, fontWeight: selected ? FontWeight.w700 : FontWeight.w500)),
      ],
    );
  }
}

BoxDecoration _cardDecoration(double radius) => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(radius),
  border: Border.all(color: const Color(0xFFF1F1F7)),
  boxShadow: [BoxShadow(color: Colors.black.withOpacity(.035), blurRadius: 12, offset: const Offset(0, 4))],
);


