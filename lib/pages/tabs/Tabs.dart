import 'package:flutter/material.dart';
import 'GHUserPage.dart';
import '../../services/ScreenAdaper.dart';
import '../../services/gh_sqflite.dart';
import 'GHHomePage.dart';
import 'GHCategoryPage.dart';
import 'GHShopCartPage.dart';

/// tab
class Tabs extends StatefulWidget {
  final Map<String, dynamic>? arguments;

  const Tabs({Key? key, this.arguments}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Widget> _pageList = const [
    GHHomePage(),
    GHCategoryPage(),
    GHShopCartPage(),
    GHUserPage()
  ];

  @override
  void initState() {
    super.initState();
    if (widget.arguments != null) {
      _currentIndex = widget.arguments!["index"] ?? 0;
    } else {
      _currentIndex = 0;
    }
    _pageController = PageController(initialPage: _currentIndex);
    GHSqflite sq = GHSqflite();
    sq.create();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pageList,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "首页",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: "分类",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: "购物车",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "我的",
          ),
        ],
      ),
    );
  }
}
