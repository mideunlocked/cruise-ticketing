class Lobby {
  final String id;
  final String eventId;
  final String nickName;
  final List<dynamic> attendees;

  const Lobby({
    required this.id,
    required this.eventId,
    required this.nickName,
    required this.attendees,
  });

  factory Lobby.fromJson(Map<String, dynamic> json) {
    return Lobby(
      id: json["id"] as String,
      eventId: json["eventId"] as String,
      nickName: json["nickName"] as String,
      attendees: json["attendees"] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "eventId": eventId,
      "nickName": nickName,
      "attendees": attendees,
    };
  }
}
