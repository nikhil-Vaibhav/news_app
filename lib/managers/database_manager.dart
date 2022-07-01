
import 'package:news_app/news.dart';
import 'package:news_app/services/database_service.dart';

class DatabaseManager{
  final DatabaseService _service = DatabaseService();

  Future<List<News>> getRecentNews(int offset) {
    return _service.getRecentNewsPosts(offset);
  }

  Future<List<News>> getAllBlogPosts(int offset) {
    return _service.getAllBlogPosts(offset);
  }
}