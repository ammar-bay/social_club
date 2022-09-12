import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:socialapp/resources/jitsi_meet_methods.dart';
import 'package:socialapp/screens/go_live_screen.dart';
import 'package:socialapp/screens/live_feed_screen.dart';
// import 'package:socialapp/screens/history_meeting_screen.dart';
// import 'package:socialapp/screens/video_call_screen.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/utils/global_variable.dart';
import 'package:socialapp/widgets/home_meeting_button.dart';

class LiveStreamingScreen extends StatelessWidget {
  LiveStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 30),
                  children: [
                    TextSpan(
                        text: "Social",
                        style: GoogleFonts.pacifico(color: Colors.white)),
                    TextSpan(
                        text: " Stream",
                        style: GoogleFonts.pacifico(color: Colors.orange))
                  ],
                ),
              ),
            ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeMeetingButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LiveFeedScreen()));
                  },
                  text: 'Following',
                  icon: Icons.favorite,
                ),
                HomeMeetingButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoLiveScreen()));
                  },
                  text: 'Go Live',
                  icon: Icons.add_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
