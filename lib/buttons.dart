import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

//Constructor
  const MyButton({
    required this.color,
    required this.textColor,
    required this.buttonText,
    this.buttontapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(0.2),
          child: ClipRRect(
            // borderRadius:
            //     BorderRadius.circular(MediaQuery.of(context).size.width / 16),
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: Colors.grey.shade900,
                //   width: 5,
                // ),
                color: color,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.shade800,
                    blurRadius: 5.0,
                    spreadRadius: -1.0,
                    offset: const Offset(0.0, 0.0),
                  )
                ],
              ),
              // height: MediaQuery.of(context).size.height,
              // color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
