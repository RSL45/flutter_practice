import 'package:flutter/material.dart';

class WhiteBoardConfirmDialog extends StatelessWidget {
  final String title;
  final String msg;
  final String conformText;
  final VoidCallback onConform;

  WhiteBoardConfirmDialog({
    Key? key,
    required this.title,
    required this.msg,
    required this.onConform,
    this.conformText = '删除',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(),
            _buildMessage(),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: Colors.orange,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildMessage() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          msg,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(70, 35),
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const StadiumBorder(),
          ),
          child: Text(
            "取消",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: onConform,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            elevation: 0,
            minimumSize: const Size(70, 35),
            padding: EdgeInsets.zero,
            shape: const StadiumBorder(),
          ),
          child: Text(conformText),
        ),
      ],
    );
  }
}
