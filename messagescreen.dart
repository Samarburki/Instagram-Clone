import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final querySnapshot = await FirebaseFirestore.instance
          .collection('messages')
          .get();

      if (querySnapshot.docs.isEmpty) {
        setState(() {
          errorMessage = 'No messages found';
          isLoading = false;
        });
        return;
      }

      setState(() {
        messages = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'id': doc.id,
            'lastmsg': data['lastmsg'] ?? 'No message',
            'senderId': data['senderId'] ?? 'Unknown',
            'senderImage': data['senderImage'],
            'senderName': data['senderName'] ?? 'Unknown',
            'isRead': data['isRead'] ?? false,
          };
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading messages: ${e.toString()}';
        isLoading = false;
      });
      debugPrint('Firestore error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.pink,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFC0CB),
              Color(0xFFF72585),
              Color(0xFF7209B7),
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.black))
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.black)))
                      : messages.isEmpty
                          ? Center(child: Text('No messages available', style: TextStyle(color: Colors.black)))
                          : ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return Card(
                                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  color: Colors.white.withOpacity(0.8),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        message['senderImage'] ?? 'https://via.placeholder.com/150',
                                      ),
                                      radius: 25,
                                    ),
                                    title: Text(message['senderName'], style: TextStyle(color: Colors.black)),
                                    subtitle: Text(message['lastmsg'], style: TextStyle(color: Colors.black87)),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.done_all,
                                          color: message['isRead'] ? Colors.blue : Colors.grey,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.camera_alt,
                                          size: 20,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
    );
  }
}