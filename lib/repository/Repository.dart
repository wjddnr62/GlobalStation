import '../provider/login_api.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _loginprovider = LoginProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginprovider.fetchUser(client, id, pass);
}
