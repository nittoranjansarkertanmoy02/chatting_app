class userModel {
  String? about;
  String? name;
  bool? isOnline;
  String? id;
  String? email;
  String? image;
  String? push_Token;
  String? lastActive;

  userModel({
    this.about,
    this.name,
    this.isOnline,
    this.id,
    this.email,
    this.image,
    this.push_Token,
    this.lastActive,
  });

  userModel.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    isOnline = json['isOnline'];
    id = json['id'];
    email = json['email'] ?? '';
    image = json['image'] ?? '';
    push_Token = json['push_Token'] ?? '';
    lastActive = json['lastActive'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['name'] = this.name;
    data['isOnline'] = this.isOnline;
    data['id'] = this.id;
    data['email'] = this.email;
    data['image'] = this.image;
    data['push_Token'] = this.push_Token;
    data['lastActive'] = this.lastActive;
    return data;
  }
}
