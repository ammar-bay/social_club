import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:socialapp/resources/auth_methods.dart';
import 'package:socialapp/resources/jitsi_meet_methods.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:socialapp/widgets/meeting_option.dart';
import 'package:socialapp/widgets/text_field_input.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(
      text: _authMethods.user.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        elevation: 0,
        backgroundColor: mobileBackgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldInput(
                textEditingController: meetingIdController,
                hintText: "Room ID",
                textInputType: TextInputType.number),
            const SizedBox(height: 10),
            TextFieldInput(
                textEditingController: nameController,
                hintText: "Name",
                textInputType: TextInputType.number),
            // SizedBox(
            //   height: 60,
            //   child: TextField(
            //     controller: meetingIdController,
            //     maxLines: 1,
            //     textAlign: TextAlign.center,
            //     keyboardType: TextInputType.number,
            //     decoration: const InputDecoration(
            //       fillColor: secondaryBackgroundColor,
            //       filled: true,
            //       border: InputBorder.none,
            //       hintText: 'Room ID',
            //       contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 60,
            //   child: TextField(
            //     controller: nameController,
            //     maxLines: 1,
            //     textAlign: TextAlign.center,
            //     keyboardType: TextInputType.number,
            //     decoration: const InputDecoration(
            //       fillColor: secondaryBackgroundColor,
            //       filled: true,
            //       border: InputBorder.none,
            //       hintText: 'Name',
            //       contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              // onTap: _joinMeeting,
              onPressed: _joinMeeting,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange)),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MeetingOption(
              text: 'Mute Audio',
              isMute: isAudioMuted,
              onChange: onAudioMuted,
            ),
            const SizedBox(height: 10),

            MeetingOption(
              text: 'Turn Off My Video',
              isMute: isVideoMuted,
              onChange: onVideoMuted,
            ),
          ],
        ),
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
