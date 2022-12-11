import 'package:flutter/material.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/models/country.dart';
import 'package:tabouk/models/marka.dart';
import 'package:tabouk/models/miza.dart';
import 'package:tabouk/models/model.dart';
import 'package:tabouk/models/blacklist.dart';
import 'package:tabouk/models/user.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/urls.dart';

class HomeProvider extends ChangeNotifier {
  ApiProvider _apiProvider = ApiProvider();
  User _currentUser;

  String _currentLang;

  void update(AuthProvider authProvider) {
    _currentUser = authProvider.currentUser;
    _currentLang = authProvider.currentLang;
  }

  String get currentLang => _currentLang;

  bool _enableSearch = false;

  void setEnableSearch(bool enableSearch) {
    _enableSearch = enableSearch;
    notifyListeners();
  }

  bool get enableSearch => _enableSearch;


  bool _enableSearch1 = false;

  void setEnableSearch1(bool enableSearch1) {
    _enableSearch1 = enableSearch1;
    notifyListeners();
  }

  bool get enableSearch1 => _enableSearch1;



  bool _enableSearch2 = false;

  void setEnableSearch2(bool enableSearch2) {
    _enableSearch1 = enableSearch2;
    notifyListeners();
  }

  bool get enableSearch2 => _enableSearch2;

  List<CategoryModel> _categoryList = List<CategoryModel>();

  List<CategoryModel> get categoryList => _categoryList;

  CategoryModel _lastSelectedCategory;

  void updateChangesOnCategoriesList(int index) {
    if (lastSelectedCategory != null) {
      _lastSelectedCategory.isSelected = false;
    }
    _categoryList[index].isSelected = true;
    _lastSelectedCategory = _categoryList[index];
    notifyListeners();
  }

  void updateSelectedCategory(CategoryModel categoryModel) {
    _lastSelectedCategory.isSelected = false;
    for (int i = 0; i < _categoryList.length; i++) {
      if (categoryModel.catId == _categoryList[i].catId) {
        _lastSelectedCategory = _categoryList[i];
        _lastSelectedCategory.isSelected = true;
      }
      notifyListeners();
    }
  }

  CategoryModel get lastSelectedCategory => _lastSelectedCategory;








  List<CategoryModel> _categoryList1 = List<CategoryModel>();

  List<CategoryModel> get categoryList1 => _categoryList1;

  CategoryModel _lastSelectedCategory1;

  void updateChangesOnCategoriesList1(int index) {
    if (lastSelectedCategory1 != null) {
      _lastSelectedCategory1.isSelected = false;
    }
    _categoryList1[index].isSelected = true;
    _lastSelectedCategory1 = _categoryList1[index];
    notifyListeners();
  }

  void updateSelectedCategory1(CategoryModel categoryModel) {
    _lastSelectedCategory1.isSelected = false;
    for (int i = 0; i < _categoryList1.length; i++) {
      if (categoryModel.catId == _categoryList1[i].catId) {
        _lastSelectedCategory1 = _categoryList1[i];
        _lastSelectedCategory1.isSelected = true;
      }
      notifyListeners();
    }
  }

  CategoryModel get lastSelectedCategory1 => _lastSelectedCategory1;








  List<CategoryModel> _categoryList2 = List<CategoryModel>();

  List<CategoryModel> get categoryList2 => _categoryList2;

  CategoryModel _lastSelectedCategory2;

  void updateChangesOnCategoriesList2(int index) {
    if (lastSelectedCategory2 != null) {
      _lastSelectedCategory2.isSelected = false;
    }
    _categoryList2[index].isSelected = true;
    _lastSelectedCategory2 = _categoryList2[index];
    notifyListeners();
  }

  void updateSelectedCategory2(CategoryModel categoryModel) {
    _lastSelectedCategory2.isSelected = false;
    for (int i = 0; i < _categoryList2.length; i++) {
      if (categoryModel.catId == _categoryList2[i].catId) {
        _lastSelectedCategory2 = _categoryList2[i];
        _lastSelectedCategory2.isSelected = true;
      }
      notifyListeners();
    }
  }

  CategoryModel get lastSelectedCategory2 => _lastSelectedCategory2;







  Future<List<CategoryModel>> getCategoryList(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

                _categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
          _categoryList.insert(0, categoryModel);
           for (int i = 0; i < _categoryList.length; i++) {
      if (lastSelectedCategory.catId == _categoryList[i].catId) {
        _categoryList[i].isSelected = true;
      }
      }
      }
    }
    return _categoryList;
  }



  Future<List<CategoryModel>> getCategoryList123(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {


        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;

        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }




  Future<List<CategoryModel>> getCategoryListHome(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        //_categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
        //_categoryList.insert(0, categoryModel);
        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }


  Future<List<CategoryModel>> getCategoryListHome1(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home1 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home1 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        //_categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
        //_categoryList.insert(0, categoryModel);
        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }




  Future<List<CategoryModel>> getCategoryListHome2(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home2 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home2 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        //_categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
        //_categoryList.insert(0, categoryModel);
        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }



  Future<List<CategoryModel>> getCategoryListHome3(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home3 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home3 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        //_categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
        //_categoryList.insert(0, categoryModel);
        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }





  Future<List<CategoryModel>> getCategoryListHome4(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home4 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL_Home4 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        //_categoryList.insert(0, categoryModel);
        _lastSelectedCategory = _categoryList[0];
      }
      else{
        categoryModel.isSelected = false;
        //_categoryList.insert(0, categoryModel);
        for (int i = 0; i < _categoryList.length; i++) {
          if (lastSelectedCategory.catId == _categoryList[i].catId) {
            _categoryList[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList;
  }













  Future<List<CategoryModel>> getCategoryList1(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL1 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL1 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList1 =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        _categoryList1.insert(0, categoryModel);
        _lastSelectedCategory1 = _categoryList1[0];
      }
      else{
        categoryModel.isSelected = false;
        _categoryList1.insert(0, categoryModel);
        for (int i = 0; i < _categoryList1.length; i++) {
          if (lastSelectedCategory1.catId == _categoryList1[i].catId) {
            _categoryList1[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList1;
  }







  Future<List<CategoryModel>> getCategoryList2(
      {CategoryModel categoryModel,@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL2 + "?api_lang=$_currentLang"+ "&cat_id="+catId);
    } else {
      response = await _apiProvider
          .get(Urls.MAIN_CATEGORY_URL2 + "?api_lang=$_currentLang");
    }



    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      _categoryList2 =
          iterable.map((model) => CategoryModel.fromJson(model)).toList();

      if (!_enableSearch) {

        _categoryList2.insert(0, categoryModel);
        _lastSelectedCategory1 = _categoryList2[0];
      }
      else{
        categoryModel.isSelected = false;
        _categoryList2.insert(0, categoryModel);
        for (int i = 0; i < _categoryList2.length; i++) {
          if (lastSelectedCategory2.catId == _categoryList2[i].catId) {
            _categoryList2[i].isSelected = true;
          }
        }
      }
    }
    return _categoryList2;
  }

  Future<List<CategoryModel>> getSubList(
      {@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider.get(Urls.MAIN_CATEGORY_URL +
          "?api_lang=$_currentLang" +
          "&cat_id=$catId");
    } else {
      response = await _apiProvider.get(Urls.MAIN_CATEGORY_URL+
          "?api_lang=$_currentLang");
    }

    List subList = List<CategoryModel>();
    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      subList = iterable.map((model) => CategoryModel.fromJson(model)).toList();
    }
    return subList;
  }



  Future<List<CategoryModel>> getSubList1(
      {@required bool enableSub, String catId}) async {
    var response;
    if (enableSub) {
      response = await _apiProvider.get(Urls.MAIN_CATEGORY_URL +
          "?api_lang=$_currentLang" +
          "&cat_id=$catId");
    } else {
      response = await _apiProvider.get(Urls.MAIN_CATEGORY_URL+
          "?api_lang=$_currentLang");
    }

    List subList = List<CategoryModel>();
    if (response['response'] == '1') {
      Iterable iterable = response['cat'];
      subList = iterable.map((model) => CategoryModel.fromJson(model)).toList();
    }
    return subList;
  }

  Future<List<City>> getCityList(
      {@required bool enableCountry, String countryId}) async {
    var response;
    if (enableCountry) {
      response = await _apiProvider.get(Urls.CITIES_URL +
          "?api_lang=$_currentLang" +
           "&country_id=$countryId");
    } else {
      response = await _apiProvider.get(Urls.CITIES_URL +
          "?api_lang=$_currentLang");
    }

    List cityList = List<City>();
    if (response['response'] == '1') {
      Iterable iterable = response['city'];
      cityList = iterable.map((model) => City.fromJson(model)).toList();
    }
    return cityList;
  }



  Future<List<Country>> getCountryList() async {
    final response = await _apiProvider
        .get(Urls.GET_COUNTRY_URL + "?api_lang=$_currentLang");
    List<Country> countryList = List<Country>();
    if (response['response'] == '1') {
      Iterable iterable = response['country'];
      countryList = iterable.map((model) => Country.fromJson(model)).toList();
    }
    return countryList;
  }


  Future<List<Miza>> getMizaList(String adsId) async {
    final response = await _apiProvider
        .get("https://tabuk.sa.com/api/getmiza" + "?ads_id=$adsId&api_lang=$_currentLang");
    List<Miza> countryList = List<Miza>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      countryList = iterable.map((model) => Miza.fromJson(model)).toList();
    }
    return countryList;
  }

  Future<List<Marka>> getMarkaList() async {
    final response = await _apiProvider
        .get(Urls.GET_MARKA_URL + "?api_lang=$_currentLang");
    List<Marka> markaList = List<Marka>();
    if (response['response'] == '1') {
      Iterable iterable = response['marka'];
      markaList = iterable.map((model) => Marka.fromJson(model)).toList();
    }
    return markaList;
  }


  Future<List<Model>> getModelList() async {
    final response = await _apiProvider
        .get(Urls.GET_MODEL_URL + "?api_lang=$_currentLang");
    List<Model> modelList = List<Model>();
    if (response['response'] == '1') {
      Iterable iterable = response['model'];
      modelList = iterable.map((model) => Model.fromJson(model)).toList();
    }
    return modelList;
  }

  Future<List<Ad>> getAdsList() async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_cat":
          _lastSelectedCategory == null ? '0' : _lastSelectedCategory.catId,
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId,
    });
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }
  Future<List<Ad>> getAdsList123() async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_cat":
      _lastSelectedCategory == null ? '0' : _lastSelectedCategory.catId,
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId,
    });
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Ad>> getAdsSearchList() async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_title": _searchKey,
      "ads_cat": _selectedCat != null ?_selectedCat.catId: '0',
      "ads_sub": _selectedSub != null ?_selectedSub.catId: '0',
      "ads_city": _selectedCity != null ? _selectedCity.cityId : '0',
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId
    });

    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Ad>> getAdsSearchList456() async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_cat": _selectedCat != null ?_selectedCat.catId: '0',
      "ads_sub": _selectedSub != null ?_selectedSub.catId: '0',
      "ads_city": _selectedCity != null ? _selectedCity.cityId : '0',
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId
    });

    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Ad>> getAdsSearchListSearch() async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_title": _searchKey,
      "ads_kind":adsKind,
      "ads_city": _selectedCity != null ? _selectedCity.cityId : '0',
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId
    });

    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {



      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();





    }
    return adsList;


  }




  Future<List<Ad>> getAdsList1(String x) async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_cat":
      _lastSelectedCategory1 == null ? '0' : _lastSelectedCategory1.catId,
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId,
      "ads_kind":x
    });
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }



  Future<List<Ad>> getAdsSearchList1(String x) async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_title": _searchKey,
      "priceFrom": _priceFrom,
      "priceTo": _priceTo,
      "ads_kind": x,
      "ads_cat": _lastSelectedCategory1 != null ?_lastSelectedCategory1.catId: '0',
      "ads_sub": _selectedSub1 != null ?_selectedSub1.catId: '0',
      "ads_city": _selectedCity != null ? _selectedCity.cityId : '0',
      "ads_marka": _selectedMarka != null ? _selectedMarka.markaId : '0',
      "ads_model": _selectedModel != null ? _selectedModel.modelId : '0',
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId
    });

    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }













  Future<List<Ad>> getAdsList2(String x) async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_cat":
      _lastSelectedCategory2 == null ? '0' : _lastSelectedCategory2.catId,
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId,
      "ads_kind":x
    });
    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }



  Future<List<Ad>> getAdsSearchList2(String x) async {
    final response = await _apiProvider
        .post(Urls.SEARCH_URL + "?api_lang=$_currentLang", body: {
      "ads_title": _searchKey,
      "priceFrom": _priceFrom,
      "priceTo": _priceTo,
      "ads_kind": x,
      "ads_cat": _lastSelectedCategory2 != null ?_lastSelectedCategory2.catId: '0',
      "ads_sub": _selectedSub != null ?_selectedSub.catId: '0',
      "ads_city": _selectedCity != null ? _selectedCity.cityId : '0',
      "ads_marka": _selectedMarka != null ? _selectedMarka.markaId : '0',
      "ads_model": _selectedModel != null ? _selectedModel.modelId : '0',
      "fav_user_id": _currentUser == null ? '' : _currentUser.userId
    });

    List<Ad> adsList = List<Ad>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Ad.fromJson(model)).toList();
    }
    return adsList;
  }


  Future<List<Blacklist>> getBlacklist(String tt) async {
    final response = await _apiProvider
        .post(Urls.BLACKLIST_URL , body: {
      "s_value": tt
    });

    List<Blacklist> adsList = List<Blacklist>();
    if (response['response'] == '1') {
      Iterable iterable = response['results'];
      adsList = iterable.map((model) => Blacklist.fromJson(model)).toList();
    }
    return adsList;
  }

  String _searchKey = '';

  void setSearchKey(String searchKey) {
    _searchKey = searchKey;
    notifyListeners();
  }

  String get searchKey => _searchKey;



  String _omarKey = '';

  void setOmarKey(String omarKey) {
    _omarKey = omarKey;
    notifyListeners();
  }

  String get omarKey => _omarKey;


  String _checkedValue = '';

  void setCheckedValue(String checkedValue) {
    _checkedValue = checkedValue;
    notifyListeners();
  }

  String get checkedValue => _checkedValue;



  String _catType = '';
  void setCatType(String catType) {
    _catType = catType;
    notifyListeners();
  }
  String get catType => _catType;


  String _fromHome = '';
  void setFromHome(String fromHome) {
    _fromHome = fromHome;
    notifyListeners();
  }
  String get fromHome => _fromHome;


  String _searchKeyBlacklist = '';

  void setSearchKeyBlacklist(String searchKeyBlacklist) {
    _searchKeyBlacklist = searchKeyBlacklist;
    notifyListeners();
  }

  String get searchKeyBlacklist => _searchKeyBlacklist;


  String _priceFrom = '';

  void setPriceFrom(String priceFrom) {
    _priceFrom = priceFrom;
    notifyListeners();
  }

  String get priceFrom => _priceFrom;

  String _priceTo = '';

  void setPriceTo(String priceTo) {
    _priceTo = priceTo;
    notifyListeners();
  }

  String get priceTo => _priceTo;

  Country _selectedCountry;

  void setSelectedCountry(Country country) {
    _selectedCountry = country;
    notifyListeners();
  }

  Country get selectedCountry => _selectedCountry;


  Marka _selectedMarka;

  void setSelectedMarka(Marka marka) {
    _selectedMarka = marka;
    notifyListeners();
  }

  Marka get selectedMarka => _selectedMarka;


  Model _selectedModel;

  void setSelectedModel(Model model) {
    _selectedModel = model;
    notifyListeners();
  }

  Model get selectedModel => _selectedModel;


  CategoryModel _selectedSub;

  void setSelectedSub(CategoryModel sub) {
    _selectedSub = sub;
    notifyListeners();
  }

  CategoryModel get selectedSub => _selectedSub;

  CategoryModel _selectedSub1;

  void setSelectedSub1(CategoryModel sub) {
    _selectedSub1 = sub;
    notifyListeners();
  }

  CategoryModel get selectedSub1 => _selectedSub1;


  CategoryModel _selectedCat;

  void setSelectedCat(CategoryModel Cat) {
    _selectedCat = Cat;
    notifyListeners();
  }

  CategoryModel get selectedCat => _selectedCat;



  String _currentAds = '';

  void setCurrentAds(String currentAds) {
    _currentAds = currentAds;
    notifyListeners();
  }

  String get currentAds => _currentAds;


  // current seller
  String _currentSeller = '';
  void setCurrentSeller(String currentSeller) {
    _currentSeller = currentSeller;
    notifyListeners();
  }
  String get currentSeller => _currentSeller;



  // current seller Name
  String _currentSellerName = '';
  void setCurrentSellerName(String currentSellerName) {
    _currentSellerName = currentSellerName;
    notifyListeners();
  }
  String get currentSellerName => _currentSellerName;


  // current seller Phone
  String _currentSellerPhone = '';
  void setCurrentSellerPhone(String currentSellerPhone) {
    _currentSellerPhone = currentSellerPhone;
    notifyListeners();
  }
  String get currentSellerPhone => _currentSellerPhone;

  // current seller Photo
  String _currentSellerPhoto = '';
  void setCurrentSellerPhoto(String currentSellerPhoto) {
    _currentSellerPhoto = currentSellerPhoto;
    notifyListeners();
  }
  String get currentSellerPhoto => _currentSellerPhoto;


  City _selectedCity;

  void setSelectedCity(City city) {
    _selectedCity = city;
    notifyListeners();
  }

  City get selectedCity => _selectedCity;

  String _age = '';

  void setAge(String age) {
    _age = age;
    notifyListeners();
  }

  String get age => _age;





  // adsKind
  String _adsKind = '';
  void setAdsKind(String adsKind) {
    _adsKind = adsKind;
    notifyListeners();
  }
  String get adsKind => _adsKind;




  String _catName = '';
  void setCatName(String catName) {
    _catName = catName;
    notifyListeners();
  }
  String get catName => _catName;

  String _catId = '';
  void setCatId(String catId) {
    _catId = catId;
    notifyListeners();
  }
  String get catId => _catId;




  String _catName1 = '';
  void setCatName1(String catName1) {
    _catName1 = catName1;
    notifyListeners();
  }
  String get catName1 => _catName1;

  String _catId1 = '';
  void setCatId1(String catId1) {
    _catId1 = catId1;
    notifyListeners();
  }
  String get catId1 => _catId1;



  String _selectedGender = '';

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  String get selectedGender => _selectedGender;





  String _packageId = '';
  void setPackageId(String packageId) {
    _packageId = packageId;
    notifyListeners();
  }
  String get packageId => _packageId;


  String _packagePeriod = '';
  void setPackagePeriod(String packagePeriod) {
    _packagePeriod = packagePeriod;
    notifyListeners();
  }
  String get packagePeriod => _packagePeriod;



  String _packagePrice = '';
  void setPackagePrice(String pacgetCategoryListkagePrice) {
    _packagePrice = packagePrice;
    notifyListeners();
  }
  String get packagePrice=> _packagePrice;


  Future<String> getUnreadMessage() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/get_unread_message?user_id=${_currentUser.userId}");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['Number'];
    }
    return messages;
  }

  Future<String> getUnreadNotify() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/get_unread_notify?user_id=${_currentUser.userId}");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['Number'];
    }
    return messages;
  }


  Future<String> getOmar() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/social");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['setting_omar'];
    }
    return messages;
  }

  Future<String> getPackage1Price2() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/social");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['setting_package1_price2'];
    }
    return messages;
  }

  Future<String> getPackage2Price2() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/social");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['setting_package2_price2'];
    }
    return messages;
  }

  Future<String> getPackage3Price2() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/social");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['setting_package3_price2'];
    }
    return messages;
  }

  Future<String> getPackage4Price2() async {
    final response =
    await _apiProvider.get("https://tabuk.sa.com/api/social");
    String messages = '';
    if (response['response'] == '1') {
      messages = response['setting_package4_price2'];
    }
    return messages;
  }



}
