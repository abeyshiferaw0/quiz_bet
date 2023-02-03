import 'package:hasura_connect/hasura_connect.dart';
import 'package:logger/logger.dart';

class TokenInterceptor extends InterceptorBase {

  final log = Logger();

  @override
  Future? onRequest(Request request, HasuraConnect connect) {
    // TODO: implement onRequest
    try {
      request.headers["x-hasura-admin-secret"] = "8ShURDi6roXj9tmejrWwX992by5S5Q";
      return Future.value(request);
    } catch (e) {
      log.e(e.toString());
      return null;
    }
  }



}