import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:github_app/model/user.dart';
import '../utils/api.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User user;

  Future<void> getUserProfile(String username) async {
    final url = '${Api.api}/users/${username}';

    try {
      final response =
          await http.get(url, headers: {'Authorization': 'token ${Api.token}'});

      final responseData = json.decode(response.body) as Map<String, dynamic>;

      print(responseData['name']);

      user = User(
        name:responseData['login'],
        username: responseData['name'],
        imageUrl: responseData['avatar_url'],
        followers: responseData['followers'],
        followings: responseData['following'],
        public_repo: responseData['public_repos'],
        joined_date: responseData['created_at'],
        location: responseData['location'],
      );

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
