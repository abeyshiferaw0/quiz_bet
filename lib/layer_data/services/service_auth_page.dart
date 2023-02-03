import 'package:logger/logger.dart';

class AuthPageService {
  final log = Logger();

  Future<String> getUserId() async {
    //todo make real user id
    return Future.value("959a6fb7-1f5a-4e3e-b146-a524fa52dc79");
  }
}
