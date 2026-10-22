import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';
import 'detail_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Meal>> featured;
  late Future<Meal> recommended;

  @override
  void initState() {
    super.initState();
    // Future dibuat sekali di initState supaya tidak request ulang tiap rebuild
    featured = ApiService.searchMeals('chicken');
    recommended = ApiService.randomMeal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Header hijau =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 24),
              decoration: const BoxDecoration(
                color: hijau,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.menu, color: Colors.white),
                  const SizedBox(height: 24),
                  const Text('Hello!!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const Text('What would you like to make?',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 16),

                  // Kotak pencarian: kalau ditekan, pindah ke halaman pencarian
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SearchPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text('Search recipes',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Featured recipes',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // ===== Featured recipes (daftar horizontal) =====
            FutureBuilder<List<Meal>>(
              future: featured,
              builder: (context, snapshot) {
                // 1. Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()));
                }
                // 2. Error
                if (snapshot.hasError) {
                  return SizedBox(
                      height: 220,
                      child: Center(child: Text('Error: ${snapshot.error}')));
                }
                // 3. Success
                final meals = snapshot.data!;
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(16),
                    itemCount: meals.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12),
                        child: MealCard(meal: meals[index]),
                      );
                    },
                  ),
                );
              },
            ),

            // ===== Recommended (1 resep acak) =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Recommended',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            FutureBuilder<Meal>(
              future: recommended,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 160,
                      child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return SizedBox(
                      height: 160,
                      child: Center(child: Text('Error: ${snapshot.error}')));
                }
                final meal = snapshot.data!;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailPage(meal: meal)),
                    );
                  },
                  child: Container(
                    height: 160,
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    padding: const EdgeInsets.all(14),
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(meal.image),
                        fit: BoxFit.cover,
                        colorFilter:
                        const ColorFilter.mode(Colors.black38, BlendMode.darken),
                      ),
                    ),
                    child: Text(meal.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
