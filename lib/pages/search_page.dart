import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/api_service.dart';
import '../widgets/meal_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Awalnya tampilkan resep "chicken", lalu berubah saat user mencari
  Future<List<Meal>> meals = ApiService.searchMeals('chicken');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          // Saat user menekan Enter, ambil data baru dari API
          onSubmitted: (text) {
            setState(() {
              meals = ApiService.searchMeals(text);
            });
          },
          decoration: InputDecoration(
            hintText: 'Search recipes...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.grey.shade200,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Meal>>(
        future: meals,
        builder: (context, snapshot) {
          // 1. Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 2. Error
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          // 3. Success
          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(child: Text('Resep tidak ditemukan'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('All Recipes',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${data.length} recipes',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) => MealCard(meal: data[index]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
