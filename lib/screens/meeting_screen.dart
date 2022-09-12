import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/resources/jitsi_meet_methods.dart';
import 'package:socialapp/screens/history_meeting_screen.dart';
import 'package:socialapp/screens/video_call_screen.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/utils/global_variable.dart';
import 'package:socialapp/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(),
      ),
    );
  }

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
                        text: " Meet",
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
                  onPressed: createNewMeeting,
                  text: 'New Meeting',
                  icon: Icons.videocam,
                ),
                HomeMeetingButton(
                  onPressed: () => joinMeeting(context),
                  text: 'Join Meeting',
                  icon: Icons.add_box_rounded,
                ),
                HomeMeetingButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoryMeetingScreen(),
                      ),
                    );
                  },
                  text: 'History',
                  icon: Icons.history,
                ),
                // HomeMeetingButton(
                //   onPressed: () {},
                //   text: 'Schedule',
                //   icon: Icons.calendar_today,
                // ),
                // HomeMeetingButton(
                //   onPressed: () {},
                //   text: 'Share Screen',
                //   icon: Icons.arrow_upward_rounded,
                // ),
                // HomeMeetingButton(
                //   onPressed: () {},
                //   text: 'Contacts',
                //   icon: Icons.contacts,
                // ),

                // HomeMeetingButton(
                //   onPressed: () {},
                //   text: 'Settings',
                //   icon: Icons.settings,
                // ),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Create/Join Meetings with just a click!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
