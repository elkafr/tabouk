import 'package:flutter/material.dart';
import 'package:tabouk/models/comments.dart';

import 'package:tabouk/models/user.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/urls.dart';


class CommentProvider extends ChangeNotifier{
  User _currentUser;
  String _currentLang;

  void update(AuthProvider authProvider) {
    _currentUser = authProvider.currentUser;
    _currentLang = authProvider.currentLang;
  }

ApiProvider _apiProvider = ApiProvider();


  Future<List<Comments>> getCommentsList(String adsId) async {
    final response = await _apiProvider.get(Urls.COMMENTS_URL +
        '?ads_id=$adsId&page=1&api_lang=$_currentLang');
    List<Comments> messageList = List<Comments>();
    if (response['response'] == '1') {
      Iterable iterable = response['comments'];
      messageList = iterable.map((model) => Comments.fromJson(model)).toList();
    }

    return messageList;
  }

  bool _isLoading = false;  
  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  } 
   bool get isLoading => _isLoading;

}