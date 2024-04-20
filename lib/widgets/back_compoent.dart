import 'package:flutter/material.dart';

class Back extends StatelessWidget {
  const Back({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
      [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 35.0,

          ),
        ),
      ],
    );
  }
}
// here is the implementation of back arrow
// i am using row widget to handle widget direction issue
