class Reply {
  final String text;
  final String lobbyId;
  final String fileLink;
  final String messageId;
  final String messageUserId;

  const Reply({
    required this.text,
    required this.lobbyId,
    required this.fileLink,
    required this.messageId,
    required this.messageUserId,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      text: json["text"] ?? "",
      lobbyId: json["lobbyId"] ?? "",
      fileLink: json["fileLink"] ?? "",
      messageId: json["messageId"] ?? "",
      messageUserId: json["messageUserId"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "lobbyId": lobbyId,
      "fileLink": fileLink,
      "messagedId": messageId,
      "messageUserId": messageUserId,
    };
  }
}
