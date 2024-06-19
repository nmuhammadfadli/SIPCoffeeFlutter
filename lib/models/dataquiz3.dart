import 'package:login_signup/models/option.dart';
import 'package:login_signup/models/question.dart';
import 'package:login_signup/models/quiz.dart';

final List<Quiz> quizzes3 = [
  Quiz(
    id: 3,
    title: 'Quiz Sistem Ketertelusuran dalam Panen Kopi',
    questions: [
      Question(
        id: 11,
        content: 'Apa yang dimaksud dengan sistem ketertelusuran pada fase panen kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 41, questionId: 11, content: 'Proses pencatatan dan pelacakan informasi dari pemetikan hingga pengangkutan biji kopi', isCorrect: true),
          Option(id: 42, questionId: 11, content: 'Proses penjualan langsung kepada konsumen akhir', isCorrect: false),
          Option(id: 43, questionId: 11, content: 'Teknologi untuk mengukur kadar kafein dalam biji kopi', isCorrect: false),
          Option(id: 44, questionId: 11, content: 'Tidak ada yang benar', isCorrect: false),
        ],
      ),
      Question(
        id: 12,
        content: 'Apa manfaat utama dari implementasi sistem ketertelusuran pada fase panen kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 45, questionId: 12, content: 'Memastikan bahwa biji kopi yang dipanen berasal dari lokasi dan waktu yang tercatat', isCorrect: true),
          Option(id: 46, questionId: 12, content: 'Mengurangi waktu proses pengolahan kopi', isCorrect: false),
          Option(id: 47, questionId: 12, content: 'Menjaga kualitas rasa kopi setelah dipanen', isCorrect: false),
          Option(id: 48, questionId: 12, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 13,
        content: 'Mengapa penting untuk mencatat proses pengangkutan dan penyimpanan biji kopi dalam sistem ketertelusuran?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 49, questionId: 13, content: 'Untuk melacak jalur distribusi dan memastikan kualitas biji kopi tetap terjaga', isCorrect: true),
          Option(id: 50, questionId: 13, content: 'Untuk menentukan harga jual biji kopi', isCorrect: false),
          Option(id: 51, questionId: 13, content: 'Agar petani kopi dapat mengetahui kapan waktu yang tepat untuk panen berikutnya', isCorrect: false),
          Option(id: 52, questionId: 13, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 14,
        content: 'Apa yang harus dilakukan jika terjadi pencampuran biji kopi dari petani yang berbeda saat proses panen?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 53, questionId: 14, content: 'Catat dan lacak setiap langkah pengolahan biji kopi dari petani yang berbeda untuk memastikan transparansi', isCorrect: true),
          Option(id: 54, questionId: 14, content: 'Biarkan campuran tersebut karena tidak mempengaruhi kualitas kopi', isCorrect: false),
          Option(id: 55, questionId: 14, content: 'Tidak perlu melakukan pencatatan, cukup lakukan pemisahan fisik', isCorrect: false),
          Option(id: 56, questionId: 14, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 15,
        content: 'Bagaimana sistem ketertelusuran meningkatkan transparansi pasar bagi konsumen terhadap biji kopi pada fase panen?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 57, questionId: 15, content: 'Dengan memungkinkan konsumen melacak asal-usul dan proses pengolahan biji kopi', isCorrect: true),
          Option(id: 58, questionId: 15, content: 'Dengan memberikan informasi tentang cara menyeduh kopi yang berbeda', isCorrect: false),
          Option(id: 59, questionId: 15, content: 'Dengan menawarkan biji kopi dengan harga yang lebih rendah', isCorrect: false),
          Option(id: 60, questionId: 15, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
    ],
  ),
];
