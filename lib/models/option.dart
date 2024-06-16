class Option {
  final int id;
  final int questionId; // Menambahkan field questionId
  final String content;
  final bool isCorrect;

  Option({
    required this.id,
    required this.questionId, 
    required this.content,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      questionId: json['question_id'], 
      content: json['content'],
      isCorrect: json['is_correct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_id': questionId, 
      'content': content,
      'is_correct': isCorrect,
    };
  }
}
