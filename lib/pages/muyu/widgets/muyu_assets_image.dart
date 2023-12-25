import 'package:flutter/material.dart';

class MuYuAssetsImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const MuYuAssetsImage(
      {Key? key, required this.imagePath, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          imagePath,
          height: 200,
        ),
      ),
    );
  }
}
