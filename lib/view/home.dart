import 'package:i_bot/widget/ui/appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:i_bot/model/message.dart';
import 'package:i_bot/widget/constent/colors.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:i_bot/widget/message/message_bubble.dart';
import 'package:i_bot/widget/ui/custom_textfeild.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _promtController = TextEditingController();
  static const String apiKey = "AIzaSyAMWFDPfO3fTtXPkL1gS3cXiHE4XqKrNEw";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<MessageModel> _messages = [];

  Future<void> sendMessage() async {
    final message = _promtController.text;
    _promtController.clear();
    setState(() {
      _messages.add(
        MessageModel(isUser: true, message: message, date: DateTime.now()),
      );
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _messages.add(
        MessageModel(
          isUser: false,
          message: response.text ?? "Error",
          date: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Appcolors.bgcolor,
        appBar: const CustomAppBar(
          title: 'Chat with i bot',
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final formattedDate =
                        DateFormat('hh:mm').format(message.date);

                    return Messages(
                      isUser: message.isUser,
                      message: message.message,
                      date: formattedDate,
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: _promtController,
                      hintText: 'Enter a prompt here',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
