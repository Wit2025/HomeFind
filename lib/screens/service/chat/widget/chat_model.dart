class ChatMessage {
  final String id;
  final String text;
  final bool isFromMe;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isFromMe,
    required this.timestamp,
  });
}
