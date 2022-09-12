import 'package:flutter/material.dart';
import 'package:socialapp/utils/colors.dart';

class MeetingOption extends StatelessWidget {
  final String text;
  final bool isMute;
  final Function(bool) onChange;
  const MeetingOption({
    Key? key,
    required this.text,
    required this.isMute,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(
            activeColor: Colors.orange,
            value: isMute,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
