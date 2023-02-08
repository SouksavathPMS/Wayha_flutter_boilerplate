import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hasura_connect/hasura_connect.dart';

class TokenInterceptor extends InterceptorBase {
  // final FirebaseAuth firebaseAuth;

  TokenInterceptor();
  @override
  Future? onRequest(Request request, HasuraConnect connect) async {
    // firebaseAuth = FirebaseAuth.instance;
    // var user = firebaseAuth.currentUser;
    // IdTokenResult token = await user!.getIdTokenResult();
    // log(token.token.toString());
    try {
      // request.headers["Authorization"] = "Bearer ${token.token}";
      request.headers["x-hasura-admin-secret"] = dotenv.env['SRECRETE']!;
      return request;
    } catch (e) {
      return null;
    }
  }
}
