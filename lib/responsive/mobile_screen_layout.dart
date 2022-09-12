import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/screens/add_post_screen.dart';
import 'package:socialapp/screens/feed_screen.dart';
import 'package:socialapp/screens/live_streaming_screen.dart';
import 'package:socialapp/screens/meeting_screen.dart';
import 'package:socialapp/screens/profile_screen.dart';
import 'package:socialapp/screens/search_screen.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/utils/global_variable.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  // final navigationkey = GlobalKey<CurvedNavigationBarState>();

  final List<Widget> homeScreenItems = [
    const FeedScreen(),
    const SearchScreen(),
    const AddPostScreen(),
    MeetingScreen(),
    LiveStreamingScreen(),
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        // key: navigationkey,
        backgroundColor: Colors.transparent,
        color: mobileBackgroundColor,
        buttonBackgroundColor: Colors.orange,
        onTap: (index) => setState(() {
          _page = index;
        }),
        items: <Widget>[
          Icon(
            Icons.home,
            color: (_page == 0) ? primaryColor : secondaryColor,
          ),
          Icon(
            Icons.search,
            color: (_page == 1) ? primaryColor : secondaryColor,
          ),
          Icon(
            Icons.add_circle,
            color: (_page == 2) ? primaryColor : secondaryColor,
          ),
          Icon(
            Icons.video_call,
            color: (_page == 3) ? primaryColor : secondaryColor,
          ),
          Icon(
            Icons.live_tv_rounded,
            color: (_page == 4) ? primaryColor : secondaryColor,
          ),
          Icon(
            Icons.person,
            color: (_page == 5) ? primaryColor : secondaryColor,
          ),
        ],
      ),
    );
  }
}
