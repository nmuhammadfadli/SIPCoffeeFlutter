import 'package:login_signup/models/option.dart';
import 'package:login_signup/models/question.dart';
import 'package:login_signup/models/quiz.dart';

final List<Quiz> quizzes2 = [
  Quiz(
    id: 2,
    title: 'Quiz Sistem Ketertelusuran dalam Perawatan Kopi',
    questions: [
      Question(
        id: 6,
        content: 'Apa yang dimaksud dengan sistem ketertelusuran pada perawatan kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 21, questionId: 6, content: 'Proses pencatatan dan pelacakan informasi dari pemupukan hingga pengendalian hama dan penyakit', isCorrect: true),
          Option(id: 22, questionId: 6, content: 'Teknologi untuk memantau harga pasaran kopi secara real-time', isCorrect: false),
          Option(id: 23, questionId: 6, content: 'Proses pemasaran produk kopi kepada konsumen akhir', isCorrect: false),
          Option(id: 24, questionId: 6, content: 'Tidak ada yang benar', isCorrect: false),
        ],
      ),
      Question(
        id: 7,
        content: 'Apa manfaat utama dari implementasi sistem ketertelusuran pada perawatan kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 25, questionId: 7, content: 'Memastikan kualitas dan keamanan produk kopi', isCorrect: true),
          Option(id: 26, questionId: 7, content: 'Mempercepat proses panen dan pengolahan kopi', isCorrect: false),
          Option(id: 27, questionId: 7, content: 'Mengurangi biaya produksi perkebunan kopi', isCorrect: false),
          Option(id: 28, questionId: 7, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 8,
        content: 'Mengapa penting untuk mencatat penggunaan pestisida dan pupuk dalam sistem ketertelusuran?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 29, questionId: 8, content: 'Untuk melacak penggunaan bahan kimia yang diterapkan dan memastikan keamanan produk', isCorrect: true),
          Option(id: 30, questionId: 8, content: 'Untuk meningkatkan kandungan kafein dalam biji kopi', isCorrect: false),
          Option(id: 31, questionId: 8, content: 'Agar produksi kopi lebih ramah lingkungan', isCorrect: false),
          Option(id: 32, questionId: 8, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 9,
        content: 'Apa yang harus dilakukan jika terdapat gejala penyakit pada tanaman kopi selama perawatan?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 33, questionId: 9, content: 'Catat dan lacak gejala penyakit serta tindakan yang diambil dalam sistem ketertelusuran', isCorrect: true),
          Option(id: 34, questionId: 9, content: 'Biarkan tanaman kopi sembuh secara alami tanpa intervensi', isCorrect: false),
          Option(id: 35, questionId: 9, content: 'Tidak perlu melakukan pencatatan, cukup lakukan pengobatan langsung', isCorrect: false),
          Option(id: 36, questionId: 9, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 10,
        content: 'Bagaimana sistem ketertelusuran meningkatkan kepercayaan konsumen terhadap produk kopi dalam fase perawatan?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 37, questionId: 10, content: 'Dengan memungkinkan konsumen untuk melacak penggunaan bahan kimia dan tindakan perawatan lainnya', isCorrect: true),
          Option(id: 38, questionId: 10, content: 'Dengan memberikan informasi tentang resep minuman kopi yang berbeda', isCorrect: false),
          Option(id: 39, questionId: 10, content: 'Dengan menawarkan kopi dengan harga yang lebih murah', isCorrect: false),
          Option(id: 40, questionId: 10, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
    ],
  ),
];
