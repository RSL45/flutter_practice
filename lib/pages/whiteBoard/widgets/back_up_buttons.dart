import 'package:flutter/material.dart';

class BackUpButtons extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;

  const BackUpButtons(
      {Key? key, required this.onBack, required this.onRevocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const BoxConstraints boxConstraints =
        BoxConstraints(minWidth: 32, minHeight: 32);
    Color backColor = onBack == null ? Colors.grey : Colors.black;
    Color revocationColor = onRevocation == null ? Colors.grey : Colors.black;
    return Center(
      child: Wrap(
        children: [
          Transform.scale(
            scaleX: -1,
            child: IconButton(
              onPressed: onBack,
              icon: Icon(Icons.next_plan_outlined, color: backColor),
              splashRadius: 20,
              constraints: boxConstraints,
            ),
          ),
          IconButton(
            onPressed: onRevocation,
            icon: Icon(Icons.next_plan_outlined, color: revocationColor),
            splashRadius: 20,
            constraints: boxConstraints,
          ),
        ],
      ),
    );
  }
}
