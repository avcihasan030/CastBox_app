import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/DATA/Auth/auth_service.dart';
import 'package:final_year_project/DATA/Chat/chat_service.dart';
import 'package:final_year_project/UI/Chat_UI/chat_page.dart';
import 'package:final_year_project/UI/Chat_UI/usertile.dart';
import 'package:flutter/material.dart';

class DisplayUsersPage extends StatelessWidget {
  DisplayUsersPage({Key? key});

  // Chat & Auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final userData = snapshot.data![index];
            return FutureBuilder<DocumentSnapshot>(
              future: _firestore.collection('Users').doc(userData['uuid']).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LinearProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.hasData && snapshot.data != null) {
                  final userData = snapshot.data!.data() as Map<String, dynamic>;
                  final String email = userData['email'];
                  final String name = userData['name'];
                  final dynamic imageUrl = userData['imageUrl'];
                  //final String fcmToken = userData['fcmToken'];

                  // display all users except current user
                  if (email != _authService.getCurrentUser()!.email) {
                    return UserTile(
                      text: name ?? email,
                      imageUrl: imageUrl,
                      onTap: () {
                        // tapped on a user -> go to chat page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              receiverEmail: email,
                              receiverID: userData['uuid'],
                              //receiverFCMToken: fcmToken,
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                // If there's no data or an error, return an empty container
                return Container();
              },
            );
          },
        );
      },
    );
  }
}
