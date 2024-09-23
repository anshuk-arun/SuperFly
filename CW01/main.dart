/*
 * CW 01
 * AnshukArun
 * Increment Counter & Toggle Image
*/


import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CW 01 - AnshukArun'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _toggleValue = true;
  String _imageID = 'assets/images/SunImage_PNG.png';
  int _counter = 0;

  // Increment the Counter by 1
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Switch the Image between Sun and Moon
  void _toggleImage() {
    setState(() {
      _toggleValue = !_toggleValue;
      if (_toggleValue){
        _imageID = 'assets/images/SunImage_PNG.png';
      }
      else {
        _imageID = 'assets/images/CrescentMoonImage_PNG.png';
      }
    });
  }

  // Reset variables to default state
  void _reset(){
    setState((){
      // Reset Counter
      _counter = 0;

      // Reset Toggle Value & ImageID
      _toggleValue = true;
      _imageID = 'assets/images/SunImage_PNG.png';
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
          ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Image.asset(_imageID),
            // Toggle Image Button
            ElevatedButton(
              style: style,
              onPressed: _toggleImage,
              child: const Text('Toggle Image')
            ),
            // Reset Image and Counter Button
            ElevatedButton(
              style: style,
              onPressed: _reset,
              child: const Text('Reset All')
            )
          ],

        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
