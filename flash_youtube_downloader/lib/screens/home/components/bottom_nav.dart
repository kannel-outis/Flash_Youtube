import 'package:flash_youtube_downloader/utils/utils.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final PageController pageController;
  const BottomNav({Key? key, required this.pageController}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 50,
      width: Utils.blockWidth * 100,
      child: BottomNavigationBar(
        elevation: 50,
        backgroundColor: theme.scaffoldBackgroundColor,
        selectedItemColor: isDarkMode ? Colors.white : Colors.black,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
          widget.pageController.jumpToPage(index);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library_rounded, size: 20),
            label: "Library",
          ),
        ],
      ),
    );
  }
}
