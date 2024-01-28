import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:final_year_project/DATA/Chat/chat_service.dart';
import 'package:final_year_project/UI/Chat_UI/chat_page.dart';
import 'package:final_year_project/UI/Chat_UI/usertile.dart';
import 'package:flutter/material.dart';

class DisplayUsersPage extends StatelessWidget {
  DisplayUsersPage({super.key});

  // Chat & Auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Online Users"),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        /// error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        /// loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return list view
        return ListView(
          children: snapshot.data!
              .map((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    /// display all users except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          // tapped on a user -> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData['email'],
                  receiverID: userData['uuid'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
