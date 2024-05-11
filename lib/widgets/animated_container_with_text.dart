import 'package:charity/constant/my_colors.dart';
import 'package:flutter/material.dart';

class AnimatedTextContainer extends StatefulWidget {
  final String text;
  final Duration duration; // Animation duration

  const AnimatedTextContainer({super.key, required this.text, this.duration = const Duration(seconds: 1)});

  @override
  State<AnimatedTextContainer> createState() => _AnimatedTextContainerState();
}

class _AnimatedTextContainerState extends State<AnimatedTextContainer> with SingleTickerProviderStateMixin {
  late Animation<double> _widthAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _widthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) => Container(
        width: _widthAnimation.value * MediaQuery.of(context).size.width* 0.65, // Animate width
        height: _widthAnimation.value * MediaQuery.of(context).size.height* 0.1, // Set container height
        decoration: BoxDecoration(
          color: MyColors.myWhile,
          borderRadius: BorderRadius.circular(10.0,),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0,
              offset: Offset(8,8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18.0,
              fontWeight: FontWeight.bold, 
            ),
          ),
        ),
      ),
    );
  }
}
