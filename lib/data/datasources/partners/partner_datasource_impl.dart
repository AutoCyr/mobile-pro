import 'dart:convert';
import 'dart:io';
import 'package:autocyr_pro/data/datasources/partners/partner_datasource.dart';
import 'package:autocyr_pro/data/excepts/handler.dart';
import 'package:autocyr_pro/data/helpers/preferences.dart';
import 'package:autocyr_pro/data/network/api_client.dart';
import 'package:http/http.dart';

class PartnerDataSourceImpl implements PartnerDataSource {

  final ApiClient _apiClient;

  PartnerDataSourceImpl(this._apiClient);

  @override
  Future addPiece(Map<String, String> body, String filepath, String name) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.postMultipart(path: "partner/add-piece", headers: headers, body: body, filepath: filepath, name: name);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future addSubscription(Map<String, dynamic> body) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.post(path: "partner/add-subscription", headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future addFreeSubscription(Map<String, dynamic> body) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.post(path: "partner/add-free-subscription", headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future checkSubscription(String id) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.get(path: "partner/check-subscription/$id", headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future getPieces(Map<String, dynamic> params) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.getWithParams(path: "partner/get-pieces", params: params, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future getPiece(String id) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.get(path: "partner/get-piece/$id", headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future updateAdresses(Map<String, dynamic> body) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.post(path: "partner/update-addresses", headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future addDisponibilities(Map<String, dynamic> body) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.post(path: "partner/add-disponibilities", headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future updateDisponibilities(Map<String, dynamic> body) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.post(path: "partner/update-disponibilities", headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future updatePiece(Map<String, String> body, String id, String filepath, String name) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      Response response;
      if(filepath == "" && name == "") {
        response = await _apiClient.post(path: "partner/update-piece/$id", headers: headers, body: body);
      } else {
        response = await _apiClient.postMultipart(path: "partner/update-piece/$id", headers: headers, body: body, filepath: filepath, name: name);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future changePieceStatus(String id) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.get(path: "partner/change-piece-status/$id", headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

  @override
  Future getCommandes(Map<String, dynamic> params) async {
    String token = await Preferences().getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    try {
      final response = await _apiClient.getWithParams(path: "partner/get-commandes", params: params, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        return data;
      } else {
        return Handling().handleErrorResponse(response);
      }
    } catch(e) {
      var error = {
        "error": true,
        "message": "Une erreur serveur est survenue",
        "except": e.toString()
      };
      return error;
    }
  }

}