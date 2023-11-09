class Message{
  String senderId;
  String receiverId;
  String content;
  DateTime sentTime;
  MessageType messageType;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentTime,
    required this.messageType,
});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        content: json['content'],
        sentTime: json['sentTime'],
        messageType: json['messageType'],
      );

  Map<String, dynamic> toJson() => {
    'senderId': senderId,
    'receiverId': receiverId,
    'content': content,
    'sentTime': sentTime,
    'messageType': messageType.toJson(),
  };
}

enum MessageType{
  text,
  image;
  String toJson () => name;
}