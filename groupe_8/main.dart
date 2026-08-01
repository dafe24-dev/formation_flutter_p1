import 'package:flutter/material.dart'; 
void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {  
const MyApp({super.key});  

@override  
State<MyApp> createState() => _MyAppState(); 
} 
class _MyAppState extends State<MyApp> {
  bool isLoading = true;
  List<String> fruits = ['Pomme', 'Banane', 'Orange'];
  
@override  
void initState() {
  super.initState();
  demarrer();  
}
Future<void> demarrer() async {
  await Future.delayed(const Duration(seconds: 4));
  setState(() {
    isLoading = false;
  });  
}  
Future<void> rafraichir() async {  
  await Future.delayed(const Duration(seconds: 3));
  setState(() {
    fruits = ['Fraise', 'Mangue', 'Ananas', 'Kiwi'];    
  });  
}  

@override  
Widget build(BuildContext context) {    
  return MaterialApp(      
    home: Scaffold(        
      appBar: AppBar(title: Text('Spinner et Pull To Refresh')),        
      body: isLoading            
      ? Center(child: CircularProgressIndicator())            
      : RefreshIndicator(                
        onRefresh: rafraichir,                
        child: ListView.builder(                  
          physics: AlwaysScrollableScrollPhysics(),                  
          itemCount: fruits.length,                  
          itemBuilder: (context, index) {                    
            return ListTile(title: Text(fruits[index]));                  
          },                
        ),              
      ),      
    ),    
  );  
} 
}