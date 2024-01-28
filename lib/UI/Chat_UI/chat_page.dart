import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:final_year_project/DATA/Chat/chat_service.dart';
import 'package:final_year_project/UI/utils/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  /// textController
  final TextEditingController _messageController = TextEditingController();

  /// chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  /// send message method
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      /// send the message
      await _chatService.sendMessage(
          receiverID, _messageController.text.trim());

      /// clear the text controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
        backgroundColor: Colors.blueGrey,
        title: Text(
          receiverEmail,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),

          /// display all messages
          Expanded(child: _buildMessageList()),

          /// user input
          _buildUserInput(),
        ],
      ),
    );
  }

  /// build a message list
  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderId),
      builder: (context, snapshot) {
        /// errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        /// loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        /// return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  /// build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    /// is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    // return Container(
    //   alignment: alignment,
    //   child: Text(
    //     data['message'],
    //   ),
    // );
    return ChatBubble(message: data['message'], isCurrentUser: isCurrentUser);
  }

  /// build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 8),
      child: Row(
        children: [
          /// textfield should take up most of the space
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.photo_camera,
                      size: 24,
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.orange,
                    size: 24,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.primaries.last),
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  hintText: 'Type a message',
                ),
                obscureText: false,
              ),
            ),
          ),

          FloatingActionButton(
            onPressed: sendMessage,
            shape: const CircleBorder(),
            backgroundColor: Colors.primaries.last,
            child: const Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
