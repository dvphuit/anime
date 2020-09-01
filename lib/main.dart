import 'package:anime/src/ui/app_bar.dart';
import 'package:anime/src/ui/app_theme.dart';
import 'package:anime/src/ui/explore_page.dart';
import 'package:anime/src/ui/home/home_page.dart';
import 'package:anime/src/ui/library_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class Page {
  final String title;
  final Icon icon;
  final Widget page;

  Page({Key key, @required this.title, @required this.icon, @required this.page});
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  final List<Page> _pages = [
    Page(title: "Home", icon: Icon(Icons.home), page: HomePage()),
    Page(title: "Explore", icon: Icon(Icons.explore), page: ExplorePage()),
    Page(title: "Library", icon: Icon(Icons.video_library), page: LibraryPage()),
  ];

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    var appTheme = AppTheme();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme.darkTheme,
        darkTheme: appTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: Scaffold(
          appBar: MyAppBar(title: _pages[_selectedIndex].title),
          body: SafeArea(
            child: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: _pages.map((e) => e.page).toList(),
            ),
          ),
          bottomNavigationBar: _buildBottomNav(),
        ));
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => {
        setState(() {
          _selectedIndex = index;
          pageController.jumpToPage(index);
        })
      },
      items: _pages.map((e) => BottomNavigationBarItem(icon: e.icon, title: Text(e.title))).toList()
    );
  }
}
