import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget()),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ScrollController controller = ScrollController();

  String titre = "Contacts";
  Color couleurAppBar = Colors.white;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        if (controller.offset == 0) {
          titre = "Contacts";
          couleurAppBar = Colors.white;
        } else {
          int index = (controller.offset / 56).floor() + 1;

          if (index < 1) index = 1;
          if (index > 30) index = 30;

          titre = "Contact $index";
          couleurAppBar = Colors.orange;
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: couleurAppBar,
            foregroundColor: Colors.black,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                titre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text("Contact ${index + 1}"),
              );
            }, childCount: 30),
          ),
        ],
      ),
    );
  }
}
