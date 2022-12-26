import 'package:calculog/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> log = [];
  var userInput = '';
  var answer = '';
  bool isEqualToZero = false;
  List<String> keypads = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    ".",
    "+",
    "-",
    "*",
    "/",
    "=",
    "(",
    ")",
  ];

  // Array of button
  final List<String> buttons = [
    'C',
    // '+/-',
    '(',
    // '%',
    ')',
    // 'DEL',
    '^',
    '7',
    '8',
    '9',
    '/', // /,÷,
    '4',
    '5',
    '6',
    '*', // *,⨉,×,ˣ,
    '1',
    '2',
    '3',
    '-', // -,−,
    '0',
    '.',
    '=',
    '+', // +,+,
  ];

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
            setState(() {
              userInput = '';
              answer = '0';
            });
            return;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
            setState(() {
              userInput = userInput.substring(0, userInput.length - 1);
            });
            return;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            setState(() {
              equalPressed();
            });
            return;
          }
          String? key = event.character;
          if (key != null &&
              buttons.contains(event.character) &&
              event.character != "C") {
            setState(() {
              userInput += key;
            });
            print(event.character);
          }
          // LogicalKeyboardKey.bracketLeft [
          // LogicalKeyboardKey.parenthesisLeft (()
          // if (event.isKeyPressed(LogicalKeyboardKey.parenthesisLeft)) {}
        }
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Calculator"),
        // ),
        backgroundColor: Colors.black87,
        body: Column(
          children: <Widget>[
            // 상태바 여백
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),

            // 계산기록
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                // overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.shade600,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: SingleChildScrollView(
                        reverse: true,
                        child: Wrap(
                          spacing: 10.0,
                          runSpacing: 5,
                          children: [
                            for (var str in log)
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey.shade300,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  shadowColor: Colors.black,
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  var qa = str.split("=");
                                  var q = qa[0];
                                  var a = qa[1];
                                  setState(() {
                                    userInput = q;
                                    answer = a;
                                  });
                                },
                                child: Text(
                                  toMathExp(str),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        // child: Wrap(
                        //   spacing: 6.0,
                        //   runSpacing: 6.0,
                        //   children: [
                        //     for (var str in log)
                        //       Chip(
                        //         labelPadding: const EdgeInsets.all(0),
                        //         shadowColor: Colors.grey[60],
                        //         padding: const EdgeInsets.all(0),
                        //         label: TextButton(
                        //           onPressed: () {},
                        //           child: Text(str),
                        //         ),
                        //       )
                        //   ],
                        // ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: log.isNotEmpty ? 0 : -50,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          log = [];
                        });
                      },
                      icon: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 입력, 계산결과
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // 입력
                  Container(
                    color: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 0,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.info_outlined),
                          iconSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        Expanded(
                          child: Text(
                            // userInput == "" ? "_" : userInput,
                            userInput == "" ? "_" : toMathExp(userInput),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              userInput =
                                  userInput.substring(0, userInput.length - 1);
                            });
                          },
                          icon: Icon(Icons.backspace_outlined,
                              color: userInput == ""
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade500),
                          iconSize: 16,
                        ),
                      ],
                    ),
                  ),

                  // 계산결과
                  Container(
                    color: Colors.grey.shade900,
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Switch(
                          value: isEqualToZero,
                          onChanged: (value) {
                            setState(() {
                              isEqualToZero = value;
                            });
                          },
                          activeTrackColor: Colors.orange.shade200,
                          activeColor: Colors.orange,
                        ),
                        Expanded(
                          child: Text(
                            answer,
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  )
                ]),

            // 키패드
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 5 / 4,
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput = '';
                          answer = '0';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.blue[50],
                      textColor: Colors.black,
                    );
                  }

                  // +/- button
                  // else if (index == 1) {
                  //   return MyButton(
                  //     buttonText: buttons[index],
                  //     color: Colors.blue[50],
                  //     textColor: Colors.black,
                  //   );
                  // }

                  // % Button
                  // else if (index == 2) {
                  //   return MyButton(
                  //     buttontapped: () {
                  //       setState(() {
                  //         userInput += buttons[index];
                  //       });
                  //     },
                  //     buttonText: buttons[index],
                  //     color: Colors.blue[50],
                  //     textColor: Colors.black,
                  //   );
                  // }

                  // Delete Button
                  // else if (index == 3) {
                  //   return MyButton(
                  //     buttontapped: () {
                  //       setState(() {
                  //         userInput =
                  //             userInput.substring(0, userInput.length - 1);
                  //       });
                  //     },
                  //     buttonText: buttons[index],
                  //     color: Colors.blue[50],
                  //     textColor: Colors.black,
                  //   );
                  // }

                  // Equal_to Button
                  else if (index == 18) {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.orange[700],
                      textColor: Colors.white,
                    );
                  }

                  //  other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        setState(() {
                          userInput += buttons[index];
                        });
                      },
                      buttonText: toMathExp(buttons[index]),
                      color: isOperator(buttons[index])
                          ? Colors.blueAccent
                          : Colors.white,
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.black,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '^' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  String toMathExp(str) => str
      .replaceAll('+', '+')
      .replaceAll('-', '−')
      .replaceAll('*', '×')
      .replaceAll('/', '÷');

// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    // finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp;
    try {
      exp = p.parse(finaluserinput);
    } catch (error) {
      answer = "Wrong Input";
      return;
    }
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = double.parse(eval.toStringAsFixed(9)).toString();
    // answer = eval.toStringAsExponential();
    try {
      List<String> nums = answer.split(".");
      if (nums.length == 2 && nums[1] == "0") {
        answer = nums[0];
      }
    } catch (error) {}

    log.add('$userInput = $answer');

    userInput = answer;

    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    NumberFormat myFormat = NumberFormat('###,###,###,###.##########');
    answer = myFormat.format(double.parse(answer));
    if (isEqualToZero) {
      userInput = "";
      answer = "";
    }
  }
}
