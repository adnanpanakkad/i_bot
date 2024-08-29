class MessageModel {
  final bool isUser;
  final String message;
  final DateTime date;

  const MessageModel({
    required this.isUser,
    required this.message,
    required this.date,
  });
}
