class userModel {
  String? about;
  String? name;
  bool? isOnline;
  String? id;
  String? email;

  userModel({this.about, this.name, this.isOnline, this.id, this.email});

  userModel.fromJson(Map<String, dynamic> json) {
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    isOnline = json['isOnline'] ;
    id = json['id'] ?? '';
    email = json['email'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about'] = this.about;
    data['name'] = this.name;
    data['isOnline'] = this.isOnline;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}
