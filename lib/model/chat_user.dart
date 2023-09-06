class ChatUser {
  String? image;
  String? lastActiive;
  String? emaill;
  String? about;
  String? name;
  bool? isOnline;
  String? id;
  String? createAt;
  String? pushToken;

  ChatUser(
      {this.image,
        this.lastActiive,
        this.emaill,
        this.about,
        this.name,
        this.isOnline,
        this.id,
        this.createAt,
        this.pushToken});

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    lastActiive = json['last_actiive'] ?? "";
    emaill = json['emaill'] ?? "";
    about = json['about'] ?? "";
    name = json['name'] ?? "";
    isOnline = json['is_online'] ?? "";
    id = json['id'] ?? "";
    createAt = json['create_at'] ?? "";
    pushToken = json['push_token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['last_actiive'] = this.lastActiive;
    data['emaill'] = this.emaill;
    data['about'] = this.about;
    data['name'] = this.name;
    data['is_online'] = this.isOnline;
    data['id'] = this.id;
    data['create_at'] = this.createAt;
    data['push_token'] = this.pushToken;
    return data;
  }
}