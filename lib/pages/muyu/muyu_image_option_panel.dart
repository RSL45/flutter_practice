import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_practice/pages/muyu/widgets/muyu_select_image.dart';

import 'models/muyu_image_option.dart';

class MuYuImageOptionPanel extends StatelessWidget {
  final List<MuYuImageOption> imageOptions;
  final int activeIndex;
  final ValueChanged<int> onSelect;

  const MuYuImageOptionPanel({
    Key? key,
    required this.imageOptions,
    required this.activeIndex,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle labelStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    const EdgeInsets padding =
        EdgeInsets.symmetric(horizontal: 8.0, vertical: 16);
    return Material(
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Container(
              height: 46,
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context)!.selectMuYuVersion,
                  style: labelStyle),
            ),
            Expanded(
              child: Padding(
                padding: padding,
                child: Row(
                  children: [
                    Expanded(child: _buildByIndex(0)),
                    const SizedBox(width: 10),
                    Expanded(child: _buildByIndex(1)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildByIndex(int index) {
    bool active = index == activeIndex;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: MuYuImageOptionItem(
        option: imageOptions[index],
        active: active,
      ),
    );
  }
}
