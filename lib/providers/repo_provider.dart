import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_app/model/repositries.dart';
import 'package:github_app/utils/api.dart';
import 'package:http/http.dart' as http;

class RepositriesProvider extends ChangeNotifier {
  List<Repositries> _repoList;

  List<Repositries> get repoList {
    return [..._repoList];
  }

  Future<void> getRepositriesList(String username) async {
    final link = '${Api.api}/users/${username}/repos';

    try {
      final response = await http
          .get(link, headers: {'Authorization': 'token ${Api.token}'});
      List<Repositries> newList = [];

      final responseData = json.decode(response.body) as List<dynamic>;

      for (int i = 0; i < responseData.length; i++) {
        Repositries repo = Repositries(
            repo_name: responseData[i]['name'],
            created_date: responseData[i]['created_at'],
            branch: responseData[i]['default_branch'],
            language: responseData[i]['language'],
            last_pushed: responseData[i]['pushed_at'],
            url: responseData[i]['html_url'],
            stars: responseData[i]['stargazers_count'],
            description: responseData[i]['description']);

        newList.add(repo);
      }

      _repoList = newList;
      _repoList.sort((a, b) => b.created_date.compareTo(a.created_date));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
