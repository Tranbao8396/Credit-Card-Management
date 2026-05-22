import 'package:credit_management/pages/accountPage/account_page.dart';
import 'package:credit_management/pages/discoverPage/discover_page.dart';
import 'package:credit_management/pages/cardPage/card_page.dart';
import 'package:credit_management/pages/searchPage/search_page.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  final Widget child;
  const HomeLayout({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  int currentPageIndex = 0;

  //MARK: List pages
  final List<Widget> _screens = [
    const HomePage(),
    const DiscoverPage(),
    const SearchPage(),
    const AccountPage(),
  ];
  //------------------

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) => setState(() {
          currentPageIndex = index;
        }),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.credit_card_rounded),
            label: 'Thẻ',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_rounded),
            label: 'Khám phá',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            label: 'Tra cứu MCC',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Tài Khoản',
          ),
        ],
      ),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: IndexedStack(index: currentPageIndex, children: _screens),
        ),
      ),
    );
  }
}
