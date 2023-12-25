import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GuessAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GuessAppBar({Key? key, required this.onCheck, required this.controller})
      : super(key: key);

  final VoidCallback onCheck;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
      title: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF3F6F9),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: AppLocalizations.of(context)!.inputGuessNum,
          hintStyle: const TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.run_circle_outlined, color: Colors.blue),
          onPressed: onCheck,
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
