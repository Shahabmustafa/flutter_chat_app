

class Message{
  String sendId;
  String reciverId;
  String content;
  DateTime sentTime;
  MessageType messageType;

  Message({
    required this.sendId,
    required this.reciverId,
    required this.content,
    required this.sentTime,
    required this.messageType,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sendId: json['sendId'],
      reciverId: json['reciverId'],
      content: json['content'],
      sentTime: json['sentTime'],
      messageType: json['messageType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sendId': sendId,
      'reciverId': reciverId,
      'content': content,
      'sentTime': sentTime,
      'messageType': messageType.toJson(),
    };
  }

}

enum MessageType{
  text,
  image;
  String toJson() => name;
}