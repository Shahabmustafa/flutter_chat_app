class UserModel{
  final String? uid;
  final String? name;
  final String? email;
  final String? image;
  final DateTime? lastActive;
  final bool isOnline;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.image,
    this.lastActive,
    required this.isOnline,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      lastActive: json['dateTime'],
      isOnline: json['isOnline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
      'dateTime': lastActive,
      'isOnline': isOnline,
    };
  }
}
