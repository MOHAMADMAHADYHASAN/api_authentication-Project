import 'dart:convert';

import 'package:authenticationfire/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;
import '../app_exception.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getGetApiServices(String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } catch (e) {
      throw e.toString();
    }
    return responseJson;
  }

  //////////////////////////////////////////////7
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic newResponseJson = jsonDecode(response.body);
        return newResponseJson;
      case 400:
        throw BadRequestException(response.statusCode.toString());

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.statusCode.toString());

      default:
        throw FetchDataException(
          "Error accured while communication with server " +
              "with status code " +
              response.statusCode.toString(),
        );
    }
  }
}
