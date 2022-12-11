import 'package:flutter/material.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/models/user.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/urls.dart';

class SectionAdsProvider extends ChangeNotifier{

  String _currentLang;

  void update(AuthProvider authProvider) {
 
    _currentLang =  authProvider.currentLang;
  }
ApiProvider _apiProvider = ApiProvider();



    Future<List<Ad>> getAdsList(String catId) async {
    final response = await _apiProvider.get(
      Urls.ADS_SECTION_URL + "cat_id=$catId&api_lang=$_currentLang"
      );
        List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Ad>> getAdsList1(String subId) async {
    final response = await _apiProvider.get(
        Urls.ADS_SECTION_URL1 + "sub_id=$subId&api_lang=$_currentLang"
    );
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Ad>> getAdsListByCity(String cityId) async {
    final response = await _apiProvider.get(
        "https://tabuk.sa.com/api/city123?" + "city_id=$cityId&api_lang=$_currentLang"
    );
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }

}