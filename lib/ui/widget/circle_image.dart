import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final ImageProvider<Object> image;

  const CircleImage({
    Key? key,
    required this.size,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: image,
        ),
      ),
    );
  }
}
