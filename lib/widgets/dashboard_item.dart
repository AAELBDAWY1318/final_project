import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  final Function() onTap;
  final String image , text;
  const DashboardItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
              color: Colors.black, // Stroke color
              width: 2, // Stroke width
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10.0,
                color: Colors.grey,
                offset: Offset(8, 8),
              ),
            ]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
