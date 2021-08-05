import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final double size;
  final AssetImage assetImage;

  const CircleImage({
    Key? key,
    required this.size,
    required this.assetImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: assetImage,
        ),
      ),
    );
  }
}
