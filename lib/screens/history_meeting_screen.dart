import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialapp/resources/firestore_methods.dart';
import 'package:socialapp/utils/colors.dart';
import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title:
            Text("History", style: GoogleFonts.pacifico(color: Colors.white)),
      ),
      body: StreamBuilder(
        stream: FireStoreMethods().meetingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                'Room Name: ${(snapshot.data! as dynamic).docs[index]['meetingName']}',
              ),
              subtitle: Text(
                'Joined on ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}',
              ),
            ),
          );
        },
      ),
    );
  }
}
