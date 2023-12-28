import 'dart:math';

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_practice/pages/muyu/models/muyu_image_option.dart';
import 'package:flutter_practice/pages/muyu/muyu_count_pannel.dart';
import 'package:flutter_practice/pages/muyu/muyu_image_option_panel.dart';
import 'package:flutter_practice/pages/muyu/muyu_record_history.dart';
import 'package:flutter_practice/pages/muyu/widgets/muyu_audio_option_panel.dart';
import 'package:flutter_practice/storage/db_storage/db_storage.dart';
import 'package:flutter_practice/storage/sp_storage.dart';
import 'package:uuid/uuid.dart';

import 'models/muyu_audio_option.dart';
import 'models/muyu_merit_record.dart';
import 'widgets/muyu_animate_text.dart';
import 'widgets/muyu_assets_image.dart';

class MuYuPage extends StatefulWidget {
  const MuYuPage({super.key});

  @override
  State<MuYuPage> createState() => _MuYuPageState();
}

class _MuYuPageState extends State<MuYuPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  final Random _random = Random();
  int _curValue = 0;
  AudioPool? pool;
  final List<MuYuImageOption> imageOptions = const [
    MuYuImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    MuYuImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];
  int _activeImageIndex = 0;
  final List<MuYuAudioOption> audioOptions = const [
    MuYuAudioOption(name: '音效1', path: 'muyu_1.mp3'),
    MuYuAudioOption(name: '音效2', path: 'muyu_2.mp3'),
    MuYuAudioOption(name: '音效3', path: 'muyu_3.mp3'),
  ];

  int _activeAudioIndex = 0;

  String get activeImage => imageOptions[_activeImageIndex].imagePath;

  int get clickValue {
    MuYuImageOption curOption = imageOptions[_activeImageIndex];
    int min = curOption.min;
    int max = curOption.max;
    return min + _random.nextInt(max + 1 - min);
  }

  late AnimationController clickAnimateController;

  List<MuYuMeritRecord> _records = [];
  final Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _initConfig();
    initAudioPool();
    clickAnimateController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuYuConfig();
    _counter = config['counter'] ?? 0;
    _activeImageIndex = config['activeImageIndex'] ?? 0;
    _activeAudioIndex = config['activeAudioIndex'] ?? 0;
    _records = await DbStorage.instance.meritRecordDao.query();
    setState(() {});
  }

  void initAudioPool() async {
    pool = await FlameAudio.createPool(audioOptions[_activeAudioIndex].path,
        maxPlayers: 1);
  }

  @override
  void dispose() {
    clickAnimateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.muyuTitle),
          actions: [
            IconButton(onPressed: _actionToHistory, icon: Icon(Icons.history)),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: MuYuCountPanel(
                count: _counter,
                onTapSwitchAudio: _actionToSwitchAudio,
                onTapSwitchImage: _actionToSwitchImage,
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  MuYuAssetsImage(
                      imagePath: activeImage, onTap: () => _actionImage()),
                  if (_curValue != 0)
                    MuYuAnimateText(
                      text: AppLocalizations.of(context)!
                          .muyuCountPlus(_curValue),
                      animationController: clickAnimateController,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _actionToHistory() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MuYuRecordHistory(recordList: _records)));
  }

  void _actionToSwitchAudio() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return MuYuAudioOptionPanel(
            audioOptions: audioOptions,
            activeIndex: _activeAudioIndex,
            onSelect: _actionSelectAudio,
          );
        });
  }

  void _actionSelectAudio(int selectIndex) async {
    print('===_actionSelectAudio:index-$selectIndex===');
    Navigator.of(context).pop();
    if (selectIndex == _activeAudioIndex) return;
    _activeAudioIndex = selectIndex;
    pool = await FlameAudio.createPool(audioOptions[_activeAudioIndex].path,
        maxPlayers: 1);
    saveConfig();
  }

  void _actionToSwitchImage() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return MuYuImageOptionPanel(
          imageOptions: imageOptions,
          activeIndex: _activeImageIndex,
          onSelect: _actionSelectImage,
        );
      },
    );
  }

  void _actionSelectImage(int selectIndex) {
    Navigator.of(context).pop();
    if (selectIndex == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = selectIndex;
    });
    saveConfig();
  }

  void _actionImage() {
    pool?.start();
    clickAnimateController.forward(from: 0);
    setState(() {
      _curValue = clickValue;
      _counter += _curValue;
      print('===actionImage:counter-$_counter,curValue-$_curValue');
      String id = uuid.v4();
      MuYuMeritRecord _curRecord = MuYuMeritRecord(
        id,
        DateTime.now().millisecondsSinceEpoch,
        _curValue,
        activeImage,
        audioOptions[_activeAudioIndex].name,
      );
      _records.add(_curRecord);
      saveConfig();
      DbStorage.instance.meritRecordDao.insert(_curRecord);
    });
  }

  void saveConfig() {
    SpStorage.instance.saveMuYuConfig(
      counter: _counter,
      activeImageIndex: _activeImageIndex,
      activeAudioIndex: _activeAudioIndex,
    );
  }
}
