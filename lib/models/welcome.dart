class Welcome {
  final String imageUrl;
  final String subtitle;
  final String title;

  const Welcome({
    required this.imageUrl,
    required this.subtitle,
    required this.title,
  });
}

List<Welcome> welcomeMessages = const [
  Welcome(
    imageUrl: "assets/image/welcome-1.jpg",
    subtitle: "Where Events Come to Life, One Ticket at a Time",
    title: "Welcome to CRUISE",
  ),
  Welcome(
    imageUrl: "assets/image/welcome-2.jpg",
    subtitle:
        "You'll Be Able to Engage in Conversations with Fellow Attendees and the Host in the Event Lobby.",
    title: "Connect With Fellow Attendees",
  ),
  Welcome(
    imageUrl: "assets/image/welcome-3.jpg",
    subtitle:
        "Locate Nearby Events on the Map Based on Your Location and Easily Filter the Results.",
    title: "Find The Nearest Event to You",
  ),
];
