import 'package:cw02/DetailsScreen.dart';
import 'package:flutter/material.dart';
import 'DetailsScreen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData swatchColor = ThemeData(
      primarySwatch: Colors.orange,
      useMaterial3: true,
    );
    
    return MaterialApp(
      title: 'Home Screen',
      theme: swatchColor,
      home: const MyHomeScreen(title: 'Home Screen'),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key, required this.title});
  final String title;

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  
  final List<String> recipeNames = <String> ['Pumpkin Pie', 'Biscuits n Gravy', 'Omurice'];
  
  @override
  Widget build(BuildContext context) {
    
    // Navigate to DetailsScreen when clicked
    void openDetailsScreen(int recipeIndex){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen(recipeIndex)),
        );
    }
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipes"),
      ),
      
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: recipeNames.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                openDetailsScreen(index);
              });
            },
            child: Container(
              height: 40,
              color: Colors.orangeAccent,
              child: Center(child: Text('Recipe ${index+1}: ${recipeNames[index]}')),
            ),
          );
        }
      ),

    );
    
  }

  
}
