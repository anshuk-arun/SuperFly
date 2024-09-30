import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';


/*
 * Age Counter
 * In Class Work 6
 * Anshuk Arun
*/
void main() {
  setupWindow();
  runApp(
// Provide the model to all widgets within the app. We're using
// ChangeNotifierProvider because that's a simple way to rebuild
// widgets when a model changes. We could also just use
// Provider, but then we would have to listen to Counter ourselves.
//
// Read Provider's docs to learn about all the available providers.
    ChangeNotifierProvider(
// Initialize the model in the builder. That way, Provider
// can own Counter's lifecycle, making sure to call `dispose`
// when not needed anymore.
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 360;
const double windowHeight = 640;
void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

/// Simplest possible model, with just one field.

///

/// [ChangeNotifier] is a class in `flutter:foundation`. [Counter] does

/// _not_ depend on Provider.

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();
  }

  void decrement(){
    value -= 1;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Age Counter'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Counter>(
              builder: (context, counter, child) => Text(
                'I am ${counter.value} years old.',
                style: Theme.of(context).textTheme.headlineLarge,
              )
            ),
            ElevatedButton(
              onPressed: (){
                var counter = context.read<Counter>();
                counter.increment();
              },
              child: const Text('Increase Age'),
              style: ButtonStyle(
                overlayColor: WidgetStatePropertyAll<Color>(Color.fromRGBO(58, 103, 240, 0.4))
              ),
            ),
            ElevatedButton(
              onPressed: (){
                var counter = context.read<Counter>();
                counter.decrement();
              },
              child: const Text('Decrease Age'),
              style: ButtonStyle(
                overlayColor:  WidgetStatePropertyAll<Color>(Color.fromRGBO(124, 188, 247, 0.4)) //    Color.fromRGBO(124, 188, 247, 1.0)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
