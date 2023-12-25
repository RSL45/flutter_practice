import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/muyu/models/muyu_image_option.dart';

class MuYuImageOptionItem extends StatelessWidget {
  final MuYuImageOption option;
  final bool active;

  const MuYuImageOptionItem(
      {Key? key, required this.option, required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration border = BoxDecoration(
      border: const Border.fromBorderSide(BorderSide(color: Colors.blue)),
      borderRadius: BorderRadius.circular(8),
    );
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: !active ? null : border,
      child: Column(
        children: [
          Text(
            option.name,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(option.imagePath),
            ),
          ),
          Text('每次功德 +${option.min}~${option.max}',
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
