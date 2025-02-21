import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goldyu/core/helpers/secure_storage_helper.dart';
import 'package:goldyu/data/providers/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final userData = {
    'email': 'admin@gmail.com',
    'password': '123456',
  };

  void login() {
    HttpClient.post('/login', data: userData).then((response) async {
      dynamic res = jsonDecode(response.body);
      SecureStorageHelper.saveToken(res['token']);
      print('logged in');
    }).catchError((error) {
      print(error);
    });
  }

  void categories() async {
    HttpClient.get('/categories').then((response) {
      if (response.statusCode == 200) {
        print('Categories: ${jsonDecode(response.body)}');
      } else {
        print(
            'Failed to fetch categories. Status code: ${response.statusCode}');
      }
    }).catchError((error) {
      print('Error: $error');
    });
  }

  void models() {
    HttpClient.get('/models').then((response) {
      print('Models: ${jsonDecode(response.body)}');
    }).catchError((error) {
      print(error.responde.data);
    });
  }

  void types() {
    HttpClient.get('/types').then((response) {
      print('Types: ${jsonDecode(response.body)}');
    }).catchError((error) {
      print(error.responde.data);
    });
  }

  void sales() {
    HttpClient.get('/sales').then((response) {
      print('Sales: ${jsonDecode(response.body)}');
    }).catchError((error) {
      print(error.responde.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text('login'),
            ),
            ElevatedButton(
              onPressed: () {
                categories();
              },
              child: const Text('categories'),
            ),
            ElevatedButton(
              onPressed: () {
                models();
              },
              child: const Text('models'),
            ),
            ElevatedButton(
              onPressed: () {
                types();
              },
              child: const Text('types'),
            ),
            ElevatedButton(
              onPressed: () {
                sales();
              },
              child: const Text('sales'),
            ),
          ],
        ),
      ),
    );
  }
}
