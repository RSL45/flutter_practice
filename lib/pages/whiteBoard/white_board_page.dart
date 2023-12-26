import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/stroke_width_selector.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/white_board_confirm_dialog.dart';
import 'package:flutter_practice/pages/whiteBoard/widgets/white_board_painter.dart';

import 'models/white_board_line.dart';
import 'widgets/color_selector.dart';
import 'widgets/white_board_appbar.dart';

class WhiteBoardPage extends StatefulWidget {
  const WhiteBoardPage({super.key});

  @override
  State<WhiteBoardPage> createState() => _WhiteBoardPageState();
}

class _WhiteBoardPageState extends State<WhiteBoardPage> {
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
    Navigator.of(context).pop();
    setState(() {});
  }

  void _back() {
    WhiteBoardLine lastLine = _lines.removeLast();
    _historyLines.add(lastLine);
    setState(() {});
  }

  void _revocation() {
    WhiteBoardLine lastLine = _historyLines.removeLast();
    _lines.add(lastLine);
    setState(() {});
  }

  void _onSelectColor(int index) {
    if (index != _activeColorIndex) {
      setState(() {
        _activeColorIndex = index;
      });
    }
  }

  void _onSelectStrokeWidth(int index) {
    if (index != _activeStrokeWidthIndex) {
      setState(() {
        _activeStrokeWidthIndex = index;
      });
    }
  }
}
