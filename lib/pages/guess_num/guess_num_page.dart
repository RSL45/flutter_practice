import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_practice/pages/guess_num/guess_app_bar.dart';
import 'package:flutter_practice/pages/guess_num/guess_result_notice.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GuessNumPage extends StatefulWidget {
  const GuessNumPage({super.key});

  @override
  State<GuessNumPage> createState() => _GuessNumPageState();
}

class _GuessNumPageState extends State<GuessNumPage> {
  int _randomNum = 0;
  bool _isGuessing = false;

  //null:equal true:big false:small
  bool? _isBig = null;
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: GuessAppBar(
          onCheck: _checkData,
          controller: _controller,
        ),
        body: Stack(
          children: [
            if (_isBig != null)
              Column(
                children: [
                  if (_isBig == true)
                    GuessResultNotice(
                      title: AppLocalizations.of(context)!.guessBig,
                      bgColor: Colors.redAccent,
                    ),
                  const Spacer(),
                  if (_isBig == false)
                    GuessResultNotice(
                      title: AppLocalizations.of(context)!.guessSmall,
                      bgColor: Colors.blueAccent,
                    ),
                ],
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!_isGuessing)
                    Text(AppLocalizations.of(context)!.clickCreateRandomNum),
                  Text(
                    _isGuessing ? '**' : '$_randomNum',
                    style: const TextStyle(
                        fontSize: 56, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _isGuessing ? null : _createRandomNum,
          child: const Icon(Icons.generating_tokens_outlined),
          backgroundColor: _isGuessing ? Colors.grey : Colors.blue,
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void _createRandomNum() {
    setState(() {
      //0~99
      _randomNum = Random().nextInt(100);
      print('===randomNum:$_randomNum===');
      _isGuessing = true;
    });
  }

  void _checkData() {
    print('===checkData:goalNum-$_randomNum,guessNum-${_controller.text}===');
    int? guessValue = int.tryParse(_controller.text);

    if (_isGuessing == false || guessValue == null) return;

    if (guessValue == _randomNum) {
      setState(() {
        _isGuessing = false;
        _isBig = null;
      });
      if (!Platform.isWindows)
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.guessEqual);
      return;
    }

    setState(() {
      _isBig = guessValue > _randomNum;
    });

    if (_isBig == true) {
      if (!Platform.isWindows)
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.guessBig);
    } else {
      if (!Platform.isWindows)
        Fluttertoast.showToast(msg: AppLocalizations.of(context)!.guessSmall);
    }
  }
}
