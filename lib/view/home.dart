import 'package:flutter/material.dart';
import 'package:i_bot/widget/colors.dart';
import 'package:i_bot/widget/custom_textfeild.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promtController = TextEditingController();
  static const apikey = "AIzaSyAMWFDPfO3fTtXPkL1gS3cXiHE4XqKrNEw";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apikey);
  final List<Message> _messages = [];
  Future<void> sendMessage() async {
    final message = _promtController.text;
    _promtController.clear();
    setState(() {
      _messages
          .add(Message(isUser: true, message: message, date: DateTime.now()));
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _messages.add(Message(
          isUser: false,
          message: response.text ?? "error",
          date: DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Appcolors.primerycolor,
          title: const Center(child: Text('Gemini Ai')),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: '',
                );
              },
            )),
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CustomTextfield(
                          controller: _promtController,
                          hintText: 'Enter a promt here')),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Appcolors.primerycolor,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages(
      {super.key,
      required this.isUser,
      required this.message,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
          color: isUser ? Colors.grey : Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
            topRight: Radius.circular(10),
            bottomRight: isUser ? Radius.zero : Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          )
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;
  const Message({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
