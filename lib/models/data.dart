
import 'package:login_signup/models/option.dart';
import 'package:login_signup/models/question.dart';
import 'package:login_signup/models/quiz.dart';

final List<Quiz> quizzes = [
  Quiz(
    id: 1,
    title: 'Sistem Ketertelusuran',
    questions: [
      Question(
        id: 1,
        content: 'Apa itu sistem ketertelusuran?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 1, questionId: 1, content: 'Pendataan dari hulu ke hilir', isCorrect: true),
          Option(id: 2, questionId: 1, content: 'Transformasi teknologi', isCorrect: false),
          Option(id: 3, questionId: 1, content: 'Mekanisme pencatatan manual', isCorrect: false),
          Option(id: 4, questionId: 1, content: 'Tidak ada yang benar', isCorrect: false),
        ],
      ),
      Question(
        id: 2,
        content: 'Apa manfaat sistem ketertelusuran?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 5, questionId: 2, content: 'Menjamin standar mutu', isCorrect: true),
          Option(id: 6, questionId: 2, content: 'tidak ada', isCorrect: false),
          Option(id: 7, questionId: 2, content: 'agar lebih keren', isCorrect: false),
          Option(id: 8, questionId: 2, content: 'semua jawaban salah', isCorrect: false),
        ],
      ),
    ],
  ),
  Quiz(
    id: 2,
    title: 'Perawatan Kopi',
    questions: [
      Question(
        id: 3,
        content: 'Pupuk apa yang direkomendasikan dalam kopi ekspor?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 9, questionId: 3, content: 'Pupuk Organik', isCorrect: true),
          Option(id: 10, questionId: 3, content: 'NPK 800', isCorrect: false),
          Option(id: 11, questionId: 3, content: 'AB Mix', isCorrect: false),
          Option(id: 12, questionId: 3, content: 'Tidak ada', isCorrect: false),
        ],
      ),
    ],
  ),
];
