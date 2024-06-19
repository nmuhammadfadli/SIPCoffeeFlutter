import 'package:login_signup/models/option.dart';
import 'package:login_signup/models/question.dart';
import 'package:login_signup/models/quiz.dart';

final List<Quiz> quizzes = [
  Quiz(
    id: 1,
    title: 'Quiz Sistem Ketertelusuran pada Pembibitan Kopi',
    questions: [
      Question(
        id: 1,
        content: 'Apa yang dimaksud dengan sistem ketertelusuran pada pembibitan kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 1, questionId: 1, content: 'Proses pencatatan dan pelacakan informasi dari benih hingga pembibitan untuk memastikan kualitas dan keamanan produk', isCorrect: true),
          Option(id: 2, questionId: 1, content: 'Teknologi untuk memonitor kondisi tanaman kopi secara real-time', isCorrect: false),
          Option(id: 3, questionId: 1, content: 'Proses pembuatan laporan keuangan terkait biaya pembibitan kopi', isCorrect: false),
          Option(id: 4, questionId: 1, content: 'Tidak ada yang benar', isCorrect: false),
        ],
      ),
      Question(
        id: 2,
        content: 'Apa tujuan utama dari implementasi sistem ketertelusuran pada pembibitan kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 5, questionId: 2, content: 'Memastikan transparansi dan keamanan produk kopi dari proses awal hingga akhir', isCorrect: true),
          Option(id: 6, questionId: 2, content: 'Mempercepat proses pembibitan untuk meningkatkan produksi kopi', isCorrect: false),
          Option(id: 7, questionId: 2, content: 'Mengurangi biaya produksi perkebunan kopi secara keseluruhan', isCorrect: false),
          Option(id: 8, questionId: 2, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 3,
        content: 'Mengapa penting untuk mencatat varietas kopi yang digunakan dalam sistem ketertelusuran?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 9, questionId: 3, content: 'Untuk melacak asal-usul genetik dan karakteristik tanaman kopi', isCorrect: true),
          Option(id: 10, questionId: 3, content: 'Untuk memastikan tanaman kopi tidak terkena serangan hama dan penyakit', isCorrect: false),
          Option(id: 11, questionId: 3, content: 'Agar pengawasan terhadap kualitas air irigasi dapat dilakukan', isCorrect: false),
          Option(id: 12, questionId: 3, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 4,
        content: 'Apa yang harus dilakukan jika terdapat perubahan dalam status kesehatan atau kondisi tanaman kopi selama fase pembibitan?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 13, questionId: 4, content: 'Catat dan lacak perubahan tersebut dalam sistem ketertelusuran untuk menjaga integritas data', isCorrect: true),
          Option(id: 14, questionId: 4, content: 'Tidak perlu dilakukan perubahan apapun dalam sistem ketertelusuran', isCorrect: false),
          Option(id: 15, questionId: 4, content: 'Tingkatkan penggunaan pupuk untuk mengatasi masalah tanaman', isCorrect: false),
          Option(id: 16, questionId: 4, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
      Question(
        id: 5,
        content: 'Bagaimana sistem ketertelusuran membantu meningkatkan transparansi dan kepercayaan konsumen terhadap produk kopi?',
        createdAt: DateTime.now(),
        options: [
          Option(id: 17, questionId: 5, content: 'Dengan memungkinkan konsumen melacak asal-usul dan proses produksi kopi secara detail', isCorrect: true),
          Option(id: 18, questionId: 5, content: 'Dengan menyediakan informasi mengenai cara pengolahan kopi yang berbeda', isCorrect: false),
          Option(id: 19, questionId: 5, content: 'Dengan menjamin bahwa harga kopi yang ditawarkan adalah yang terbaik di pasaran', isCorrect: false),
          Option(id: 20, questionId: 5, content: 'Semua jawaban salah', isCorrect: false),
        ],
      ),
    ],
  ),
];
