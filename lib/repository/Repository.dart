import '../provider/login_api.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _loginProvider = LoginProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginProvider.fetchUser(client, id, pass);
}
