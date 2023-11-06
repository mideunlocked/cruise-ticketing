import '../helpers/format_number.dart';

class Users {
  final String id;
  final String bio;
  final String name;
  final String email;
  final String number;
  final String gender;
  final String videoUrl;
  final String username;
  final String imageUrl;
  final String? password;
  final String dateOfBirth;
  final List<dynamic>? hosted;
  final List<dynamic>? attended;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final List<dynamic>? highlights;

  const Users({
    required this.id,
    required this.bio,
    required this.name,
    required this.email,
    required this.number,
    required this.gender,
    required this.hosted,
    required this.videoUrl,
    required this.username,
    required this.imageUrl,
    required this.password,
    required this.attended,
    required this.followers,
    required this.following,
    required this.highlights,
    required this.dateOfBirth,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json["id"] as String,
      bio: json["bio"] as String,
      name: json["fullName"] as String,
      email: json["email"] as String,
      number: json["phoneNumber"] as String,
      gender: json["gender"] as String,
      hosted: json["hosted"] as List<dynamic>,
      videoUrl: json["videoUrl"] as String,
      username: json["username"] as String,
      imageUrl: json["imageUrl"] as String,
      password: json["password"] as String?,
      attended: json["attended"] as List<dynamic>,
      followers: json["followers"] as List<dynamic>,
      following: json["following"] as List<dynamic>,
      highlights: json["highlights"] as List<dynamic>,
      dateOfBirth: json["dateOfBirth"] as String,
    );
  }

  int getFollowing() {
    int followingInt = 0;

    followingInt = following?.length ?? 0;

    return followingInt;
  }

  int getFollowers() {
    int followersInt = 0;

    followersInt = followers?.length ?? 0;

    return followersInt;
  }

  int getHosted() {
    int hostedInt = 0;

    hostedInt = hosted?.length ?? 0;

    return hostedInt;
  }

  int getAttended() {
    int attendedInt = 0;

    attendedInt = attended?.length ?? 0;

    return attendedInt;
  }

  Map<String, dynamic> getUserNumbersInFormatedString() {
    String hosted = FormatNumber.formatLargeNumber(getHosted());
    String attended = FormatNumber.formatLargeNumber(getAttended());
    String following = FormatNumber.formatLargeNumber(getFollowing());
    String followers = FormatNumber.formatLargeNumber(getFollowers());

    Map<String, dynamic> userNumbers = {};

    userNumbers = {
      "hosted": hosted,
      "attended": attended,
      "following": following,
      "followers": followers,
    };

    return userNumbers;
  }
}
