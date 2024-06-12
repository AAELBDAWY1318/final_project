import 'package:flutter/material.dart';

class ImageSlideAnimation extends StatefulWidget {
  final String image ;
  const ImageSlideAnimation({super.key, required this.image});

  @override
  _ImageSlideAnimationState createState() => _ImageSlideAnimationState();
}

class _ImageSlideAnimationState extends State<ImageSlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: Container(
        // Replace the container with your image widget
        width: 150, // Adjust width as needed
        height: 200, // Adjust height as needed
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
