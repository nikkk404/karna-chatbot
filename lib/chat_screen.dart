import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mistral_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final MistralService mistralService = MistralService();

  void sendMessage() async {
    String userMessage = _controller.text;
    setState(() {
      messages.add({'role': 'user', 'content': userMessage});
    });
    _controller.clear();

    String botResponse = await mistralService.sendMessage(userMessage);
    setState(() {
      messages.add({'role': 'bot', 'content': botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    messages[index]['content']!,
                    textAlign: messages[index]['role'] == 'user'
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(
                      color: messages[index]['role'] == 'user'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
