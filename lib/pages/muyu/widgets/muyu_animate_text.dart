import 'package:flutter/material.dart';

class MuYuAnimateText extends StatefulWidget {
  final String text;
  final AnimationController animationController;

  const MuYuAnimateText(
      {Key? key, required this.text, required this.animationController})
      : super(key: key);

  @override
  State<MuYuAnimateText> createState() => _MuYuAnimateTextState();
}

class _MuYuAnimateTextState extends State<MuYuAnimateText>
    with SingleTickerProviderStateMixin {
  late Animation<double> opacityAnimation;
  late Animation<Offset> offsetAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    opacityAnimation =
        Tween(begin: 1.0, end: 0.0).animate(widget.animationController);
    offsetAnimation = Tween(begin: const Offset(0, 2), end: Offset.zero)
        .animate(widget.animationController);
    scaleAnimation =
        Tween(begin: 1.0, end: 0.6).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: Text(widget.text),
        ),
      ),
    );
  }
}
