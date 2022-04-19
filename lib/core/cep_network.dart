import 'package:codesaima/core/address_model.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    AddressModel cepModel = AddressModel();

    if (response.statusCode == 200) {
      cepModel = cepModelFromJson(response.body);

      return cepModel;
    } else {
      return response.body;
    }
  }
}
