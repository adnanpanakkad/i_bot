import 'package:i_bot/api/api_key.dart';
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
  // static const String apIKey = "AIzaSyAMWFDPfO3fTtXPkL1gS3cXiHE4XqKrNEw";

  final model = GenerativeModel(model: 'gemini-pro', apiKey: Apikey().apIKey);
  final List<MessageModel> _messages = [];
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final message = _promtController.text;
    _promtController.clear();
    setState(() {
      _messages.add(
        MessageModel(isUser: true, message: message, date: DateTime.now()),
      );
      _isLoading = true;
    });

    final content = [Content.text(message)];
    final response = await model.generateContent(content);

    setState(() {
      _isLoading = false;
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
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: CustomTextfield(
                        controller: _promtController,
                        hintText: 'Enter a prompt here',
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      shape: BoxShape.circle,
                    ),
                    margin: const EdgeInsets.only(right: 15, left: 10),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
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
