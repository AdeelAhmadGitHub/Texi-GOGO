import 'package:flutter/material.dart';

class PositionChanged extends StatefulWidget {
   PositionChanged({Key? key}) : super(key: key);

  @override
  State<PositionChanged> createState() => _PositionChangedState();
}

class _PositionChangedState extends State<PositionChanged> {
  FocusNode _focusNode = FocusNode();

  int a=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Listener(
              // onPointerHover: (_){
              //   print(a++);
              // },
  //             onPointerUp: (_){
  //               setState(() {
  // if (!_focusNode.hasFocus) {
  //                     print("good");
  //                     _focusNode.requestFocus();
  //                   }
  // print(_focusNode.hasFocus);
  //               });
  //               print(a++);
  //             },
               onPointerDown: (_) {
          if (!_focusNode.hasFocus) {
    print("good");
    _focusNode.requestFocus();
    }
        print(_focusNode.hasFocus);
          setState(() {

          });
              },
              child: Container(

                height: 40,
                width: 200,
                color: Colors.orange,
              ),
            ),
          const  SizedBox(height: 40,),
            Align(
              alignment: _focusNode.hasFocus?Alignment.center:Alignment.bottomLeft,
              child: Container(
                height: 40,
                width: 200,
                color: Colors.orange,
              ),
            ),
            // Transform.translate(
            //   offset: _focusNode.hasFocus ? const Offset(20.0, 30.0) : Offset.zero,
            //   child: Container(
            //     height: 40,
            //     width: 200,
            //     color: Colors.orange,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
