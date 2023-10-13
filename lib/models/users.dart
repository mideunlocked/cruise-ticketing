import 'package:cruise/helpers/format_number.dart';

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
  final DateTime dateOfBirth;
  final List<dynamic> hosted;
  final List<dynamic> attended;
  final List<dynamic> followers;
  final List<dynamic> following;
  final List<dynamic> highlights;

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
    required this.attended,
    required this.followers,
    required this.following,
    required this.highlights,
    required this.dateOfBirth,
  });

  int calculateAge() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - dateOfBirth.year;

    // Adjust age if birthday hasn't occurred yet this year
    if (currentDate.month < dateOfBirth.month ||
        (currentDate.month == dateOfBirth.month &&
            currentDate.day < dateOfBirth.day)) {
      age--;
    }

    return age;
  }

  int getFollowing() {
    int followingInt = 0;

    followingInt = following.length;

    return followingInt;
  }

  int getFollowers() {
    int followersInt = 0;

    followersInt = followers.length;

    return followersInt;
  }

  int getHosted() {
    int hostedInt = 0;

    hostedInt = hosted.length;

    return hostedInt;
  }

  int getAttended() {
    int attendedInt = 0;

    attendedInt = attended.length;

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
