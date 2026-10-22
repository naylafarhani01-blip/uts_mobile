import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/meal.dart';

// Halaman detail menerima objek Meal dari halaman sebelumnya,
// jadi tidak perlu request API lagi.
class DetailPage extends StatelessWidget {
  final Meal meal;
  const DetailPage({super.key, required this.meal});

  // Kotak kecil berisi angka/teks + label (untuk bagian statistik)
  Widget statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Instruksi dipecah per baris menjadi langkah-langkah
    final steps = meal.instructions
        .split(RegExp(r'\r?\n'))
        .where((s) => s.trim().isNotEmpty)
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== Gambar + tombol kembali =====
            Stack(
              children: [
                Image.network(meal.image,
                    height: 300, width: double.infinity, fit: BoxFit.cover),
                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            // ===== Konten putih menimpa gambar =====
            Transform.translate(
              offset: const Offset(0, -24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(meal.name,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('${meal.category} • ${meal.area}',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),

                    // Statistik
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8DC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          statItem(meal.category, 'Category'),
                          statItem(meal.area, 'Area'),
                          statItem('${meal.ingredients.length}', 'Ingredients'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Ingredients
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Ingredients',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${meal.ingredients.length} items',
                            style: const TextStyle(color: hijau)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F6EE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < meal.ingredients.length; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(Icons.circle, size: 6, color: hijau),
                                  const SizedBox(width: 10),
                                  Expanded(child: Text(meal.ingredients[i])),
                                  Text(meal.measures[i]),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Preparation Steps
                    const Text('Preparation Steps',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    for (int i = 0; i < steps.length; i++)
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: hijau,
                              child: Text('${i + 1}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(steps[i],
                                  style: const TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
