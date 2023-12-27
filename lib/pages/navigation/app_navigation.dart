import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/guess_num/guess_num_page.dart';
import 'package:flutter_practice/pages/muyu/muyu_page.dart';
import 'package:flutter_practice/pages/navigation/app_bottom_bar.dart';
import 'package:flutter_practice/pages/whiteBoard/white_board_page.dart';

import 'models/menu_data.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _index = 0;
  final List<MenuData> menus = const [
    MenuData(label: '猜数字', icon: Icons.question_mark),
    MenuData(label: '电子木鱼', icon: Icons.my_library_music_outlined),
    MenuData(label: '白板绘制', icon: Icons.palette_outlined),
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
      bottomNavigationBar: AppBottomBar(
        menus: menus,
        currentIndex: _index,
        onItemTap: _onChangePage,
      ),
    );
  }

  Widget _buildContent() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: const [
        GuessNumPage(),
        MuYuPage(),
        WhiteBoardPage(),
      ],
    );
    // switch (index) {
    //   case 0:
    //     return const GuessNumPage();
    //   case 1:
    //     return const MuYuPage();
    //   case 2:
    //     return const WhiteBoardPage();
    //   default:
    //     return const SizedBox.shrink();
    // }
  }

  void _onChangePage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _index = index;
    });
  }
}
