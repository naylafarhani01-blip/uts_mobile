// Class model: mengubah JSON dari TheMealDB menjadi objek Dart
class Meal {
  final String id;
  final String name;
  final String image;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients; // nama bahan
  final List<String> measures; // takaran bahan

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> bahan = [];
    List<String> takaran = [];

    // API menyimpan bahan sebagai strIngredient1 ... strIngredient20
    for (int i = 1; i <= 20; i++) {
      final b = json['strIngredient$i'];
      final t = json['strMeasure$i'];
      if (b != null && b.toString().trim().isNotEmpty) {
        bahan.add(b.toString());
        takaran.add((t ?? '').toString());
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      category: json['strCategory'] ?? '-',
      area: json['strArea'] ?? '-',
      instructions: json['strInstructions'] ?? '',
      ingredients: bahan,
      measures: takaran,
    );
  }
}
