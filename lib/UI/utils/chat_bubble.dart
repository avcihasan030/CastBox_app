import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width*0.7,
        ),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blueGrey : Colors.blueGrey.shade300,
         // borderRadius: BorderRadius.circular(8.0),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isCurrentUser ? 12.0 : 0.0),
            topRight: Radius.circular(isCurrentUser ? 0.0 : 12.0),
            bottomLeft: const Radius.circular(12.0),
            bottomRight: const Radius.circular(12.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            overflow: TextOverflow.visible
          ),
        ),
      ),
    );
  }
}
