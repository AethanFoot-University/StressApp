class User {
  static User currentUser;
  String name;
  String email;
  List<int> homeOrder;
  List<String> musicList;

  User(this.name, this.email, this.homeOrder, this.musicList);

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    var homeOrderJson = json['homeOrder'];
    homeOrder = List<int>.from(homeOrderJson);
    var musicListJson = json['musicList'];
    musicList = List<String>.from(musicListJson);
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'email' : email,
    'homeOrder' : homeOrder,
    'musicList' : musicList,
  };
}