import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MuYuCountPanel extends StatelessWidget {
  final int count;
  final VoidCallback onTapSwitchAudio;
  final VoidCallback onTapSwitchImage;

  const MuYuCountPanel({
    Key? key,
    required this.count,
    required this.onTapSwitchAudio,
    required this.onTapSwitchImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(54, 54),
      padding: EdgeInsets.zero,
      backgroundColor: Colors.green,
      elevation: 0,
    );

    return Stack(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.muyuCount(count),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
            top: 10,
            right: 10,
            child: Wrap(
              spacing: 6,
              direction: Axis.vertical,
              children: [
                ElevatedButton(
                  onPressed: onTapSwitchAudio,
                  style: buttonStyle,
                  child: const Icon(Icons.music_note, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: onTapSwitchImage,
                  style: buttonStyle,
                  child: const Icon(Icons.image, color: Colors.white),
                ),
              ],
            ))
      ],
    );
  }
}
