import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/stroke_width_selector.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/white_board_confirm_dialog.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/white_board_painter.dart';
import 'package:flutter_practice/storage/sp_storage.dart';

import 'models/white_board_line.dart';
import 'widgets/color_selector.dart';
import 'widgets/white_board_appbar.dart';

class WhiteBoardPage extends StatefulWidget {
  const WhiteBoardPage({super.key});

  @override
  State<WhiteBoardPage> createState() => _WhiteBoardPageState();
}

class _WhiteBoardPageState extends State<WhiteBoardPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<WhiteBoardLine> _lines = [];
  List<WhiteBoardLine> _historyLines = [];

  int _activeColorIndex = 0;
  int _activeStrokeWidthIndex = 0;

  final List<Color> supportColors = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.lime,
    Colors.brown
  ];

  final List<double> supportStrokeWidths = [1, 2, 4, 6, 8, 10];

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  void _initConfig() async {
    Map<String, dynamic> config =
        await SpStorage.instance.readWhiteBoardConfig();
    // _lines = config['lines'];
    // _historyLines = config['historyLines'];
    _activeColorIndex = config['activeColorIndex'] ?? 0;
    _activeStrokeWidthIndex = config['activeStrokeWidthIndex'] ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteBoardAppBar(
        onClear: _showClearDialog,
        onBack: _lines.isEmpty ? null : _back,
        onRevocation: _historyLines.isEmpty ? null : _revocation,
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            child: CustomPaint(
              painter: WhiteBoardPainter(lines: _lines),
              child: ConstrainedBox(constraints: const BoxConstraints.expand()),
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: ColorSelector(
                    supportColors: supportColors,
                    activeIndex: _activeColorIndex,
                    onSelect: _onSelectColor,
                  ),
                ),
                StrokeWidthSelector(
                  supportStrokeWidths: supportStrokeWidths,
                  color: supportColors[_activeColorIndex],
                  activeIndex: _activeStrokeWidthIndex,
                  onSelect: _onSelectStrokeWidth,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    _lines.add(WhiteBoardLine(
        points: [details.localPosition],
        color: supportColors[_activeColorIndex],
        strokeWidth: supportStrokeWidths[_activeStrokeWidthIndex]));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print('===onPanUpdate-details:${details.localPosition}===');
    Offset point = details.localPosition;
    double distance = (_lines.last.points.last - point).distance;
    print('===onPanUpdate-distance:$distance===');
    if (distance > 5) {
      _lines.last.points.add(details.localPosition);
      setState(() {});
    }
  }

  void _showClearDialog() {
    String msg = "您的当前操作会清空绘制内容，是否确定删除!";
    showDialog(
        context: context,
        builder: (ctx) => WhiteBoardConfirmDialog(
              title: '清空提示',
              conformText: '确定',
              msg: msg,
              onConform: _clear,
            ));
  }

  void _clear() {
    _lines.clear();
    _historyLines.clear();
    Navigator.of(context).pop();
    setState(() {});
    saveConfig();
  }

  void _back() {
    WhiteBoardLine lastLine = _lines.removeLast();
    _historyLines.add(lastLine);
    saveConfig();
    setState(() {});
  }

  void _revocation() {
    WhiteBoardLine lastLine = _historyLines.removeLast();
    _lines.add(lastLine);
    saveConfig();
    setState(() {});
  }

  void _onSelectColor(int index) {
    if (index != _activeColorIndex) {
      setState(() {
        _activeColorIndex = index;
      });
      saveConfig();
    }
  }

  void _onSelectStrokeWidth(int index) {
    if (index != _activeStrokeWidthIndex) {
      setState(() {
        _activeStrokeWidthIndex = index;
      });
      saveConfig();
    }
  }

  void saveConfig() async {
    bool saveWhiteBoard = await SpStorage.instance.saveWhiteBoardConfig(
      // lines: _lines,
      // historyLines: _historyLines,
      activeColorIndex: _activeColorIndex,
      activeStrokeWidthIndex: _activeStrokeWidthIndex,
    );
    print('===saveWhiteBoard:$saveWhiteBoard===');
  }
}
