import 'package:login_signup/models/option.dart';

class Question {
  final int id;
  final String content;
  final DateTime? createdAt;
  final List<Option> options;

  Question({
    required this.id,
    required this.content,
    this.createdAt,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      content: json['content'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      options: (json['options'] as List)
          .map((optionJson) => Option.fromJson(optionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'created_at': createdAt?.toIso8601String(),
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}
