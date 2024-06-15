import 'message.dart';

class Chat {
  final String name;
  final String profileImageUrl;
  final List<Message> messages;
  final int unreadCount;

  Chat({
    required this.name,
    required this.profileImageUrl,
    required this.messages,
    required this.unreadCount,
  });
}