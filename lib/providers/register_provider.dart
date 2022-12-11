import 'package:flutter/material.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/urls.dart';

class RegisterProvider extends ChangeNotifier{

  
  String _currentLang;

  void update(AuthProvider authProvider) {

    _currentLang = authProvider.currentLang;
  }

  ApiProvider _apiProvider = ApiProvider();
    List<City> _countryList =  List<City>();

  List<City> get countryList => _countryList;

    Future<List<City>> getCountryList() async {
     final response = await _apiProvider
        .get(Urls.CITIES_URL + "?api_lang=$_currentLang");
     if (response['response'] == "1") {
      Iterable iterable = response['city'];
       _countryList =
          iterable.map((model) => City.fromJson(model)).toList();
      return _countryList;
    }
    return null;
  }

  City _userCountry;

  void setUserCountry(City userCountry) {
    _userCountry = userCountry;
    notifyListeners();
  }

  City get userCountry => _userCountry;


   bool _acceptTerms = false;

  void setAcceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    notifyListeners();
  }

  bool get acceptTerms => _acceptTerms;

}