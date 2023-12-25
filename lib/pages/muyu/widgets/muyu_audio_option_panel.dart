import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/muyu_audio_option.dart';

class MuYuAudioOptionPanel extends StatelessWidget {
  final List<MuYuAudioOption> audioOptions;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const MuYuAudioOptionPanel({
    Key? key,
    required this.audioOptions,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle style =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.selectMuYuAudio,
                style: style,
              ),
            ),
            ...List.generate(
                audioOptions.length, (index) => _buildByIndex(index))
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = activeIndex == index;
    return ListTile(
        selected: active,
        onTap: () => onSelect(index),
        title: Text(audioOptions[index].name),
        trailing: IconButton(
          onPressed: () => _playAudio(audioOptions[index].path),
          icon: const Icon(Icons.record_voice_over_rounded, color: Colors.blue),
          splashRadius: 20,
        ));
  }

  void _playAudio(String path) async {
    AudioPool pool = await FlameAudio.createPool(path, maxPlayers: 4);
    pool.start();
  }
}
