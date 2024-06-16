class Message {
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final bool isMe;

  Message({
    required this.content,
    required this.timestamp,
    required this.isRead,
    required this.isMe,
  });
}
