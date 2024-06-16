class Result {
  final int id;
  final int userId;
  final int score;
  final DateTime takenAt;

  Result({
    required this.id,
    required this.userId,
    required this.score,
    required this.takenAt,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json['id'],
      userId: json['user_id'],
      score: json['score'],
      takenAt: DateTime.parse(json['taken_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'score': score,
      'taken_at': takenAt.toIso8601String(),
    };
  }
}
