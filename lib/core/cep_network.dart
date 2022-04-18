import 'package:codesaima/core/cep_model.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      CepModel cepModel = CepModel();

      cepModel = cepModelFromJson(response.body);

      return cepModel;
    } else {
      print(response.statusCode);
    }
  }
}
