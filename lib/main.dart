import 'package:calculog/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String userInput = '';
  String answer = '';
  bool isEqualToZero = false;
  bool isAnswered = true;
  bool addAnswer = false;
  String wrong = "Wrong Input";
  String over = "Over the range";
  String big = "Too Big";
  String small = "Too small";
  int significant = 15; // Max 999,999,999,999,999

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
              answer = '';
              isAnswered = true;
            });
            return;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
            if (userInput.isNotEmpty) {
              setState(() {
                userInput = userInput.substring(0, userInput.length - 1);
                isAnswered = false;
              });
            }
            return;
          }
          if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
              event.character == "=") {
            setState(() {
              isAnswered = false;
              equalPressed();
            });
            return;
          }
          String? key = event.character;
          if (key != null &&
              buttons.contains(event.character) &&
              event.character != "C") {
            if (isAnswered == true) {
              if (["+", "-", "*", "/", "^"].contains(key)) {
                setState(() {
                  userInput = answer + key;
                  isAnswered = false;
                });
              } else {
                setState(() {
                  userInput = key;
                  isAnswered = false;
                });
              }
            } else {
              setState(() {
                userInput += key;
                isAnswered = false;
              });
            }
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
                                    if (addAnswer) {
                                      userInput = a.substring(1);
                                    } else {
                                      userInput = q.substring(0, q.length - 1);
                                    }
                                    // answer = a;
                                    answer = "";
                                    isAnswered = false;
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
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
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
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              height: 150,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 26),
                                    const Text(
                                        "     최대수: 999,999,999,999,999.9"),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("     소수점아래: 최대 9자리"),
                                        Text("유효숫자: 최대 16     "),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Switch(
                                          activeThumbImage: const AssetImage(
                                              "assets/images/equal.png"),
                                          value: false,
                                          onChanged: (value) {},
                                          activeTrackColor:
                                              Colors.orange.shade200,
                                          activeColor: Colors.orange.shade500,
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "수식을 입력",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   children: [
                                        // const SizedBox(width: 5),
                                        Switch(
                                          activeThumbImage: const AssetImage(
                                              "assets/images/equal.png"),
                                          value: true,
                                          onChanged: (value) {},
                                          activeTrackColor:
                                              Colors.orange.shade200,
                                          activeColor: Colors.orange.shade500,
                                        ),
                                        const Expanded(
                                          child: Text(
                                            "계산결과를 입력",
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // ElevatedButton(
                                    //   child: const Text('OK'),
                                    //   onPressed: () => Navigator.pop(context),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.info_outlined),
                      iconSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    Expanded(
                      child: Text(
                        // userInput == "" ? "_" : userInput,
                        userInput == "" ? "_" : toMathExp(userInput),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.start,
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
                    const SizedBox(width: 5),
                    Switch(
                      activeThumbImage:
                          const AssetImage("assets/images/equal.png"),
                      // const NetworkImage(
                      //     "https://cdn0.iconfinder.com/data/icons/mathematical-symbols-2-colored/640/cc_equal-512.png"),
                      // value: isEqualToZero,
                      value: addAnswer,
                      onChanged: (value) {
                        setState(() {
                          // isEqualToZero = value;
                          addAnswer = value;
                        });
                      },
                      activeTrackColor: Colors.orange.shade200,
                      activeColor: Colors.orange.shade500,
                    ),
                    Expanded(
                      child: Text(
                        // answer,
                        answerFormatted(answer),
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
                          answer = '';
                          isAnswered = true;
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.black, // Colors.blue[50],
                      textColor: Colors.grey.shade400, //Colors.black,
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
                          isAnswered = false;
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.black, // Colors.orange[700],
                      textColor: Colors.orange[700], // Colors.white,
                    );
                  }

                  //  other buttons
                  else {
                    return MyButton(
                      buttontapped: () {
                        if (isAnswered == true) {
                          if (isOperator(buttons[index])) {
                            setState(() {
                              userInput = answer + buttons[index];
                              isAnswered = false;
                            });
                          } else {
                            setState(() {
                              userInput = buttons[index];
                              isAnswered = false;
                            });
                          }
                        } else {
                          setState(() {
                            userInput += buttons[index];
                            isAnswered = false;
                          });
                        }
                      },
                      buttonText: toMathExp(buttons[index]),
                      color: isOperator(buttons[index])
                          ? Colors.black //Colors.blueAccent
                          : Colors.black,
                      textColor: isOperator(buttons[index])
                          // ? Colors.white
                          // : Colors.black,
                          ? Colors.blueAccent
                          : Colors.grey.shade400,
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
      answer = wrong;
      return;
    }
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = double.parse(eval.toStringAsFixed(9)).toString();
    // answer = eval.toStringAsExponential();
    if (answer.contains("e")) {
      answer = over;
      return;
    }
    try {
      List<String> nums = answer.split(".");
      if (nums[0][0] == "-" && nums[0].length > significant + 1) {
        answer = over;
        return;
      }
      if (nums[0][0] != "-" && nums[0].length > significant) {
        answer = over;
        return;
      }

      if (nums.length == 2 && nums[1] == "0") {
        answer = nums[0];
      }
    } catch (error) {
      if (answer[0] == "-" && answer.length > significant + 1) {
        answer = over;
        return;
      }
      if (answer[0] != "-" && answer.length > significant) {
        answer = over;
        return;
      }
    }

    log.add('$userInput = $answer');

    // userInput = answer;
    isAnswered = true;

    // NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    // NumberFormat myFormat = NumberFormat('###,###,###,###.##########');
    // answer = myFormat.format(double.parse(answer));
    if (isEqualToZero) {
      userInput = "";
      answer = "";
    }
  }

  String answerFormatted(String number) {
    if (number == "" || number == wrong || number == over) {
      return number;
    }

    String beforeDot, afterDot;
    try {
      List<String> nums = number.split(".");
      beforeDot = nums[0];
      afterDot = nums[1];
    } catch (error) {
      beforeDot = number;
      afterDot = "";
    }

    String formatted = "";
    for (int i = 0; i < beforeDot.length; i++) {
      // print(beforeDot[beforeDot.length - 1 - i]);
      if (i % 3 == 0 &&
          i > 0 &&
          i < beforeDot.length - 1 &&
          beforeDot[beforeDot.length - i - 1] != "-") {
        formatted = ',$formatted';
      }
      formatted = '${beforeDot[beforeDot.length - 1 - i]}$formatted';
    }
    if (afterDot != "") {
      formatted = '$formatted.$afterDot';
    }
    return formatted;

    // Parser p = Parser();
    // Expression exp = p.parse(number);
    // ContextModel cm = ContextModel();
    // double eval = exp.evaluate(EvaluationType.REAL, cm);
    // print(eval);

    // NumberFormat myFormat;
    // myFormat = NumberFormat('###,###,###,###.##########');
    // // return myFormat.format(double.parse(answer));
    // return myFormat.format(eval);
    // }
  }
}
