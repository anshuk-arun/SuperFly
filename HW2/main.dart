//import 'dart:io';
//import 'dart:collection';
//import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'dart:collection';
import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  //setupWindow();
  runApp(
    //const MyApp()
    ChangeNotifierProvider(
      create: (context) => Calculator(),
      child: const MyApp(),
    ),
  );
}

// Display Expression class
class Calculator with ChangeNotifier {
  String _expression = "";
  DoubleLinkedQueue _dq = DoubleLinkedQueue();
  bool _replaceExpression = true;
  Object? lastElement;

  void addNumber(int n){
    
    // after equals sign, starting to type a new number will replace the expression.
    if (_replaceExpression){
      _expression = "";
      lastElement = null;
      _dq.clear();
    }

    // If the last element was a number and we're adding a number, concatenate it to previous number
    if (lastElement is int){
      // last element number to String (concatenated with) new number to String
      // parse that concatenated string for the new number
      // ex: "1" + "2" = "12"
      int newElement = int.parse(lastElement.toString() + n.toString());
      _dq.removeFirst();
      _dq.addFirst(newElement);
      lastElement = newElement;     // needs to be 12
    }
    // last element was operator, this is new number
    else{
      _dq.addFirst(n);
      lastElement = n;      // needs to be current number
    }
    // add the number to the full expression regardless
    _expression += "$n";
    // still continuing the expression, so no replace
    _replaceExpression = false;
    notifyListeners();
  }

  void addOperator(String op){

    // after equals sign, starting to type a new operator will continue on the expression


    // if last element was an operator, pressing an operator will change the operator
    if (lastElement is String){
      // replace the latest Element in expression, which is the old operator, with the new operator.
      _expression.replaceRange(_expression.length-1, _expression.length, op);
      _dq.removeLast();
    }
    // last element was number, so concatenate the operator to expression as expected
    else{
      _expression += op;
    }
    
    /* Support for Long Expressions, does not work currently.
     *
    // Check if we have two numbers to do operation
    if (_dq.elementAt(0) is int && _dq.elementAt(1) is int){
      // helper function to calculate expression
      // check for division by zero
      _expression = operation(_dq).toString();
    }
    *
    */

    _dq.addLast(op); // add the operator to end of deque regardless
    lastElement = op;      // make the current operator the lastElement
    _replaceExpression = false;
    
    notifyListeners();
  }

  void calculate(){

    // there is two numbers and one operator
    if (_dq.length == 3){
      if (_dq.elementAt(0) is int  && _dq.elementAt(1) is int){
        _expression = operation(_dq).toString();
      }
    }
    _replaceExpression = true;
    notifyListeners();
  }

  void clear(){
    _expression = "";
    _dq.clear();
    _replaceExpression = true;
    lastElement = null;
    notifyListeners();
  }



  
  // Helper function to calculate expression
  int operation(DoubleLinkedQueue dq){
    int result = 0;
    String op = dq.last;
    // remove the last operator
    dq.removeLast();

    // Do the operation with the previous two numbers. Remove the numbers from the deque.
    switch (op) {
      case "+":
        result = dq.elementAt(0) + dq.elementAt(1);
        dq.removeFirst();
        dq.removeFirst();
        
      case "-":
        result = dq.elementAt(1) - dq.elementAt(0);
        dq.removeFirst();
        dq.removeFirst();
      case "*":
        result = dq.elementAt(0) * dq.elementAt(1);
        dq.removeFirst();
        dq.removeFirst();
      case "/":
        if (dq.elementAt(0) == 0){
          clear();    // Error, resets everything
        }
        else{
          result = dq.elementAt(1) ~/ dq.elementAt(0);
          dq.removeFirst();
          dq.removeFirst();
        }
      default:
    }
    dq.addFirst(result);

    return result.toInt();
  }
  


}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.lightBlueAccent,

            // minimumSize: const Size(100, 40)
            ),
        ),
      ),
      home: const MyHomePage(title: 'Calculator - HW 2'),
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
  // String to hold the expression for display
  
  // Deque to act as double ended stack for evaluating calculator expression
  // front for operands\numbers
  // back for operators\symbols
  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // Keep Things Centered
      body: Center(

        // vertical
        child: Column(
        
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Display Area
            Consumer<Calculator>(
              builder: (context, calculator, child) => Text(
                "${calculator._expression}",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ),
            
            // Grid of Buttons
            Container(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                crossAxisCount: 3,
                
                children: [
                  // Numbers 1 - 9
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(1);
                    },
                    child: const Text("1"),
                  ),  
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(2);
                    },
                    child: const Text("2"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(3);
                    },
                    child: const Text("3"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(4);
                    },
                    child: const Text("4"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(5);
                    },
                    child: const Text("5"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(6);
                    },
                    child: const Text("6"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(7);
                    },
                    child: const Text("7"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(8);
                    },
                    child: const Text("8"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(9);
                    },
                    child: const Text("9"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addNumber(0);
                    },
                    child: const Text("0"),
                  ),                
                  
                ],
              ),
            ),  // Grid of Buttons
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addOperator('+');
                  },
                  child: const Text("+"),
                ),
                ElevatedButton(
                  onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addOperator('-');
                  },
                  child: const Text("-"),
                ),
                ElevatedButton(
                  onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addOperator('*');
                  },
                  child: const Text("*"),
                ),
                ElevatedButton(
                  onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.addOperator('/');
                  },
                  child: const Text("/"),
                ),    
              ],
            ),
            // Equals and Clear
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                      var calc = context.read<Calculator>();
                      calc.calculate();
                  },
                  child: const Text("="),
                ),
                // Clear Button
                ElevatedButton(
                  onPressed: (){
                    var calc = context.read<Calculator>();
                    calc.clear();
                  },
                  child: const Text("Clear"),
                ),
              ],
            ), 
          
          ],

        ),
      ),

    );
  }
}



/*
Test Cases

number buttons -> displays the digits = Passed
operator buttons -> displays the operators = Passed
multidigit numbers = Passed
Simple Expressions of 2 numbers and 1 operator, displays value upon Equals button = Passed
clear button -> resets everything to default = Passed

Hit a number, hit clear, hit number again. -> will display new number = Passed
hit number, hit equals, hit number again -> will display the new number = Passed

Division works? -> currently works as Integer Division = maybe
division by 0 -> currently displays 0 -> maybe




*/







