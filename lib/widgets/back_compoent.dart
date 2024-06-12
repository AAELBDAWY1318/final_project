import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  final Color  color ;
  const Back({super.key , this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 35.0,
            color: color,

          ),
        ),
      ],
    );
  }
}
// here is the implementation of back arrow
// i am using row widget to handle widget direction issue
