import 'package:flutter/material.dart';

class DataLoaders {
  Future<void> loadDataFor<T>({
    required BuildContext context,
    required bool condition,
    required Map<String, dynamic> params,
    required Future Function({required BuildContext context, required Map<String, dynamic> params, required bool more}) retrieveFunction,
    required bool more,
  }) async {
    if (condition) {
      await retrieveFunction(context: context, params: params, more: more).catchError((error) {
        print("Erreur lors du chargement des données : $error");
      });
    }
  }
}