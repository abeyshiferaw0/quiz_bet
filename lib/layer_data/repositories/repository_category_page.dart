
import 'package:quiz_bet/layer_data/models/category.dart';
import 'package:quiz_bet/layer_data/services/service_category_page.dart';

class CategoryPageRepository {
  const CategoryPageRepository({
    required this.service,
  });
  final CategoryPageService service;

  Future<List<Category>> getAllCategories() async => service.getAllCategories();

}