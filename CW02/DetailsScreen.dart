import 'package:flutter/material.dart';
import 'HomeScreen.dart';

void main() {
}

class DetailsScreen extends StatelessWidget {
  final List<String> recipeInstructions = <String> ['Buy from the store', 'Order from Grubhub', 'Waste hundreds of dollars and hours of your time.'];
  String displayDetails = "";

  DetailsScreen(incIndex, {super.key}){
    displayDetails = recipeInstructions[incIndex];
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.cyanAccent,
              child: Text(
                displayDetails
              ),
            ),
            FloatingActionButton(
              onPressed: (){
                Navigator.of(context).pop();
                //Navigator.pop(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
              child: const Text('Back to Recipes'),
            ),  
          ],
        )
      )

    );
  
  }
}

/*
class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key, required this.title});
  final String title;

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  

  
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   padding: const EdgeInsets.all(8),
    //   itemCount: recipeInstructions.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return Container(
    //       height: 40,
    //       color: Colors.orangeAccent,
    //       child: Center(child: Text('Instructions ${index+1}: ${recipeInstructions[index]}')),
    //     );
    //   }
    // );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Details Screen'),
    //   ),
      
    //   body: Center(
        
    //     child: FloatingActionButton(
    //       onPressed: (){
    //         //Navigator.pop;
    //         Navigator.of(context).pop();
    //         //Navigator.pop(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    //       },
    //       child: const Text('Back to Recipes'),
    //     )
    //   )
    // );
    
  }
}

*/