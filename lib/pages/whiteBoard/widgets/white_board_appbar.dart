import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/back_up_buttons.dart';

class WhiteBoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRevocation;
  final VoidCallback onClear;

  const WhiteBoardAppBar({
    Key? key,
    required this.onBack,
    required this.onRevocation,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 100,
      leading: BackUpButtons(
        onBack: onBack,
        onRevocation: onRevocation,
      ),
      centerTitle: true,
      title: Text("画板绘制"),
      actions: [
        IconButton(
            onPressed: onClear, icon: Icon(Icons.delete_outline_outlined))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
