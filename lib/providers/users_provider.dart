import 'package:flutter/widgets.dart';

import '../models/users.dart';

class UsersProvider with ChangeNotifier {
  final Users _userData = Users(
    password: "",
    id: "0",
    bio:
        "Passionate event organizer dedicated to creating unforgettable experiences. Expert in coordinating logistics, engaging activities, and ensuring seamless execution. Committed to turning visions into remarkable events.",
    name: "John Doe",
    email: "johndoe@gmail.com",
    number: "07040225758",
    gender: "Male",
    hosted: [
      "0",
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
    ],
    videoUrl: "",
    username: "johndoe",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
    attended: [
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
    ],
    followers: [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
    ],
    following: [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
    ],
    highlights: [],
    dateOfBirth: DateTime(2004, 10, 24),
  );

  final List<Users> _users = [
    Users(
      password: "",
      id: "0",
      bio:
          "Passionate event organizer dedicated to creating unforgettable experiences. Expert in coordinating logistics, engaging activities, and ensuring seamless execution. Committed to turning visions into remarkable events.",
      name: "John Doe",
      email: "johndoe@gmail.com",
      number: "07040225758",
      gender: "Male",
      hosted: [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10,
      ],
      videoUrl: "",
      username: "johndoe",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
      attended: [
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
      ],
      followers: [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
      ],
      following: [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
      ],
      highlights: [],
      dateOfBirth: DateTime(2004, 10, 24),
    ),
    Users(
      password: "",
      id: "1",
      bio:
          "Marcus Rashford MBE is an English professional footballer who plays as a forward for Premier League club Manchester United and the England national team. A product of the Manchester United youth system, he joined the club at the age of seven.",
      name: "Marcus Rashford",
      email: "marcusrashford@gmail.com",
      number: "+1234567890",
      gender: "Male",
      hosted: [],
      videoUrl: "",
      username: "marcusrashford",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTvHWNsaMo9_3sTa4y4L59sECh07v12orE4g&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1997, 10, 31),
    ),
    Users(
      password: "",
      id: "2",
      bio:
          "Israel Mobolaji Temitayo Odunayo Oluwafemi Owolabi Adesanya is a New Zealand professional mixed martial artist, kickboxer and former boxer. As a mixed martial artist, he currently competes in the Middleweight division in the Ultimate Fighting Championship, where he is the former two-time UFC Middleweight Champion.",
      name: "Isreal Adesanya",
      email: "isrealadesanya@gmail.com",
      number: "+1234567890",
      gender: "Male",
      hosted: [],
      videoUrl: "",
      username: "laststylebender",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWkMZfLHk-Z-rHK03xkoaXoTPErClUG9mljyQ9TMmtEnMkcMieJghNhcrheKH4uPs8vHw&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1989, 7, 22),
    ),
    Users(
      password: "",
      id: "3",
      bio:
          "Elon Reeve Musk is a business magnate and investor. Musk is the founder, chairman, CEO and chief technology officer of SpaceX; angel investor, CEO, product architect and former chairman of Tesla, Inc.;",
      name: "Elon Musk",
      email: "elonmusk@gmail.com",
      number: "+1234567890",
      gender: "Male",
      hosted: [],
      videoUrl: "",
      username: "elonmusk",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0Fgw0Mm4iJpDWfuN5ZPRapVFcGPxIUZHcwA&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1971, 6, 28),
    ),
    Users(
      password: "",
      id: "4",
      bio:
          "Cristiano Ronaldo dos Santos Aveiro GOIH ComM is a Portuguese professional footballer who plays as a forward for and captains both Saudi Pro League club Al Nassr and the Portugal national team.",
      name: "Cristiano Ronadlo",
      email: "cristianoronaldo@gmail.com",
      number: "+1234567890",
      gender: "Male",
      hosted: [],
      videoUrl: "",
      username: "CR7",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9dc5yWyjHWFT6bdP1M_NLK1S8rNs81MDjQQ&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1985, 2, 5),
    ),
    Users(
      password: "",
      id: "5",
      bio:
          "Temilade Openiyi, known professionally as Tems, is a Nigerian singer and songwriter. She rose to prominence after being featured on Wizkid's 2020 single \"Essence\", which peaked at number 9 on the Billboard Hot 100 chart following the release of the remix version with Justin Bieber.",
      name: "Temilade Openiyi",
      email: "temilade@gmail.com",
      number: "+1234567890",
      gender: "Female",
      hosted: [],
      videoUrl: "",
      username: "Tems",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFmyPgJaP3cVegpAnyjCv6bqQHsteKBYU4Uw&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1995, 6, 11),
    ),
    Users(
      password: "",
      id: "6",
      bio:
          "Darryl Dwayne Granberry Jr., known professionally as PontiacMadeDDG or simply DDG, is an American rapper, singer-songwriter, actor and YouTuber. He started making videos in 2014, expanding his content with YouTube vlogs after graduating high school in 2015 and attending Central Michigan University.",
      name: "Darryl Dwayne",
      email: "pontiacmadeddg@gmail.com",
      number: "+1234567890",
      gender: "Male",
      hosted: [],
      videoUrl: "",
      username: "DDG",
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgxqIRKVGWyFXe9IfSk2-_e1np3eoFPTRUZw&usqp=CAU",
      attended: [],
      followers: [],
      following: [],
      highlights: [],
      dateOfBirth: DateTime(1997, 10, 10),
    ),
  ];

  Users get userData {
    return _userData;
  }

  List<Users> get users {
    return [..._users];
  }

  Users getUser(String userId) {
    Users? user;
    user = _users.firstWhere((e) => e.id == userId);

    return user;
  }

  List<Users> searchUsers(String keyword) {
    List<Users>? newUsers;

    _users.retainWhere((e) {
      if (e.name.toLowerCase() == keyword ||
          e.username.toLowerCase() == keyword) {
        return true;
      }
      return false;
    });

    newUsers = _users;

    notifyListeners();

    return newUsers;
  }
}
