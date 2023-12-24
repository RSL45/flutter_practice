import 'package:flutter/material.dart';

class GuessResultNotice extends StatefulWidget {
  const GuessResultNotice(
      {Key? key, required this.title, required this.bgColor})
      : super(key: key);
  final String title;
  final Color bgColor;

  @override
  State<GuessResultNotice> createState() => _GuessResultNoticeState();
}

class _GuessResultNoticeState extends State<GuessResultNotice>
    with SingleTickerProviderStateMixin {
  // late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animationController.forward();
  }

  @override
  void didUpdateWidget(covariant GuessResultNotice oldWidget) {
    //reset animate,start at begin
    animationController.forward(from: 0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        color: widget.bgColor,
        //AnimatedBuilder 局部刷新
        child: AnimatedBuilder(
          animation: animationController,
          builder: (_, child) => Text(
            widget.title,
            style: TextStyle(
              fontSize: 54 * animationController.value,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
