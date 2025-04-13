import 'package:dio/dio.dart';
import '../models/question_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Question>> fetchQuestions() async {
    try {
      final response = await _dio.get(
        'https://opentdb.com/api.php?amount=10&type=multiple',
      );

      final List results = response.data['results'];

      return results.map((q) => Question.fromMap(q)).toList();
    } catch (e) {
      throw Exception('فشل في تحميل الأسئلة: $e');
    }
  }
}
