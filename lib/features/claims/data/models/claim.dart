class Claim {
  final int userId; // Claimant ID
  final int id;     // Claim ID
  final String title; // Claim Title
  final String body;  // Claim Description

  const Claim({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Claim.fromJson(Map<String, dynamic> json) => Claim(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
