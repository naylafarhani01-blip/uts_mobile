import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

// Semua permintaan HTTP ke TheMealDB ada di sini
class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  // Cari resep berdasarkan nama
  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    // Cek status respons
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data (kode ${response.statusCode})');
    }

    final data = jsonDecode(response.body);
    if (data['meals'] == null) return []; // tidak ada hasil

    // Ubah setiap item JSON menjadi objek Meal
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  // Ambil 1 resep acak (untuk bagian Recommended)
  static Future<Meal> randomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat data (kode ${response.statusCode})');
    }

    final data = jsonDecode(response.body);
    return Meal.fromJson(data['meals'][0]);
  }
}
