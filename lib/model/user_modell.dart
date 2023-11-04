class UserModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? image;
  final DateTime? lastActive;
  final bool isOnline;

  const UserModel({
    this.name,
    this.image,
    this.lastActive,
    this.uid,
    this.email,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        name: json['name'],
        image: json['image'],
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
      );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'image': image,
    'email': email,
    'isOnline': isOnline,
    'lastActive': lastActive,
  };
}
