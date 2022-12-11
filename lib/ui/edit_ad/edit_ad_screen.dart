import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;



import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/dialogs/confirmation_dialog.dart';
import 'package:tabouk/custom_widgets/drop_down_list_selector/drop_down_list_selector.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/category.dart';
import 'package:tabouk/models/city.dart';
import 'package:tabouk/models/country.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/navigation_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/models/marka.dart';
import 'package:tabouk/models/model.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;

import 'package:location/location.dart';
import 'package:tabouk/models/city.dart';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:math' as math;
import 'dart:io';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class EditAdScreen extends StatefulWidget {
  final Ad ad;

  const EditAdScreen({Key key, this.ad}) : super(key: key);

  @override
  _EditAdScreenState createState() => _EditAdScreenState();
}

class _EditAdScreenState extends State<EditAdScreen> with ValidationMixin {
  double _height = 0, _width = 0;
  final _formKey = GlobalKey<FormState>();
  Future<List<Country>> _countryList;
  Future<List<City>> _cityList;
  Future<List<CategoryModel>> _categoryList;
  Future<List<CategoryModel>> _subList;
  Country _selectedCountry;
  City _selectedCity;
  CategoryModel _selectedCategory;
  CategoryModel _selectedSub;
  bool _initialRun = true;
  HomeProvider _homeProvider;
  List<String> _genders ;
  File _imageFile;
  File _imageFile1;
  File _imageFile2;
  File _imageFile3;
  String _xx=null;
  String _yy=null;
  String _omar;
  String _ali;

  bool _initSelectedCat = true;
  bool _initSelectedCountry= true;
  bool _initSelectedCity = true;
  bool _initSelectedSub = true;

  bool checkedValue=false;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;


  dynamic _pickImageError;
  final _picker = ImagePicker();
  AuthProvider _authProvider;
  ApiProvider _apiProvider =ApiProvider();
  bool _isLoading = false;
  String _adsTitle = '';
  String _adsPrice = '';
  String _adsPhone = '';
  String _adsWhatsapp = '';
  String _adsDescription = '';



  String _adsStars='';
  String _adsItemsNumber='';
  String _adsDoorsNumber='';
  String _adsArea='';
  String _adsAdress='';
  String _adsStreet='';
  String _adsMmsha='';
  String _adsAsasia='';
  String _adsFace='';
  String _adsLocation='';
  String _adsKithchenNumber='';
  String _adsBathNumbers='';
  String _adsHallNumbers='';
  String _adsRoomNumbers='';
  String _adsShopsNumber='';


  NavigationProvider _navigationProvider;
  LocationData _locData;






  List<String> _adsQa3at;
  String _selectedAdsQa3at;

  List<String> _adsMwaqef;
  String _selectedAdsMwaqef;


  List<String> _adsAsanser;
  String _selectedAdsAsanser;

  List<String> _adsMshb;
  String _selectedAdsMshb;


  List<String> _adsCarPath;
  String _selectedAdsCarPath;

  List<String> _adsHoosh;
  String _selectedAdsHoosh;

  List<String> _adsBeer;
  String _selectedAdsBeer;

  List<String> _adsRshashat;
  String _selectedAdsRshashat;

  List<String> _adsMsbh;
  String _selectedAdsMsbh;

  List<String> _adsMl2b;
  String _selectedAdsMl2b;

  List<String> _adsSellType;
  String _selectedAdsSellType;

  List<String> _adsCarState;
  String _selectedAdsCarState;

  List<String> _adsQeerType;
  String _selectedAdsQeerType;

  List<String> _adsWqoodType;
  String _selectedAdsWqoodType;

  List<String> _adsDblFound;
  String _selectedAdsDblFound;



  List<Asset> images = List<Asset>();
  String _error;

  Map<String, dynamic> params = Map();

  Map<String, dynamic> headers = {
    HttpHeaders.contentTypeHeader: 'multipart/form-data',
  };
  List<MultipartFile> multipart = List<MultipartFile>();

  final imagesBytes = {};

  Future<void> _getCurrentUserLocation() async {
    _locData = await Location().getLocation();
    if(_locData != null){
      print('lat' + _locData.latitude.toString());
      print('longitude' + _locData.longitude.toString());
      Commons.showToast(context, message:
      AppLocalizations.of(context).translate('detect_location'));
      setState(() {

      });
    }
  }


  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed1(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile1 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed2(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile2 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }


  void _onImageButtonPressed3(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(source: source);
      _imageFile3 = File(pickedFile.path);
      setState(() {});
    } catch (e) {
      _pickImageError = e;
    }
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {






      _adsQa3at = ["يوجد", "لا يوجد"];
      _adsMwaqef = ["يوجد", "لا يوجد"];
      _adsAsanser = ["يوجد", "لا يوجد"];
      _adsMshb = ["يوجد", "لا يوجد"];
      _adsCarPath = ["يوجد", "لا يوجد"];
      _adsHoosh = ["يوجد", "لا يوجد"];
      _adsBeer = ["يوجد", "لا يوجد"];
      _adsRshashat = ["يوجد", "لا يوجد"];
      _adsMsbh = ["يوجد", "لا يوجد"];
      _adsMl2b = ["يوجد", "لا يوجد"];
      _adsSellType = ["تنازل", "بيع"];
      _adsCarState = ["جديدة", "مستعملة","مصدومة"];
      _adsQeerType =  ["اتوماتك", "عادي"];
      _adsWqoodType = ["بنزبن", "ديزل","هايبرد"];
      _adsDblFound = ["يوجد", "لا يوجد"];

      _homeProvider = Provider.of<HomeProvider>(context);
      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:'6');

      _countryList = _homeProvider.getCountryList();
      _cityList = _homeProvider.getCityList(enableCountry: true,countryId:'500');
      _markaList = _homeProvider.getMarkaList();
      _modelList = _homeProvider.getModelList();

      _initialRun = false;
    }
  }



  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }



  Future<String> getImageFileFromAsset(String path) async {
    final file = File(path).path;
    return file;
  }


  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet1(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed1(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed1(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet2(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed2(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed2(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  void _settingModalBottomSheet3(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new Text('Gallery'),
                    onTap: (){
                      _onImageButtonPressed3(ImageSource.gallery,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Camera'),
                    onTap: (){
                      _onImageButtonPressed3(ImageSource.camera,
                          context: context);
                      Navigator.pop(context);
                    }
                ),
              ],
            ),
          );
        }
    );
  }


  Widget _buildBodyItem() {


    print(widget.ad.adsSub);










    var adsQa3at = _adsQa3at.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsMwaqef = _adsMwaqef.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsAsanser = _adsAsanser.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsMshb = _adsMshb.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsCarPath = _adsCarPath.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsHoosh = _adsHoosh.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsBeer = _adsBeer.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();

    var adsRshashat = _adsRshashat.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsMsbh = _adsMsbh.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsMl2b = _adsMl2b.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsSellType = _adsSellType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsCarState = _adsCarState.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsQeerType = _adsQeerType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    var adsWqoodType = _adsWqoodType.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();



    var adsDblFound = _adsDblFound.map((item) {
      return new DropdownMenuItem<String>(
        child: new Text(item),
        value: item,
      );
    }).toList();


    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),






            GestureDetector(
                onTap: loadAssets,
                child: Container(

                  height: _height * 0.2,
                  width: _width,
                  margin: EdgeInsets.symmetric(horizontal: _height * 0.04),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(
                      color: hintColor.withOpacity(0.4),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('assets/images/camera.png'),
                      Padding(padding: EdgeInsets.all(5)),
                      Text("اختر صور الاعلان",style: TextStyle(fontSize: 14,color: omarColor),)
                    ],
                  ),
                )),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),

              child: CustomTextFormField(
                hintTxt: AppLocalizations.of(context).translate('ad_title'),

                onChangedFunc: (text) {
                  _adsTitle = text;
                },
                initialValue: widget.ad.adsTitle,
                validationFunc: validateAdTitle,
              ),
            ),
            FutureBuilder<List<CategoryModel>>(
              future: _categoryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {

                      return new DropdownMenuItem<CategoryModel>(

                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    categoryList.removeAt(0);

                    if (_initSelectedCat) {

                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (widget.ad.adsCatName == snapshot.data[i].catName) {
                          _selectedCategory = snapshot.data[i];
                          break;
                        }
                      }
                      _initSelectedCat = false;


                    }

                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint: _homeProvider.currentLang=='ar'?'القسم الرئيسي':'Main category',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {


                          _selectedCategory = newValue;
                          _selectedSub=null;
                          _homeProvider.setSelectedCat(newValue);
                          _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
                          AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:_homeProvider.selectedCat.catId);


                          widget.ad.adsCat=_homeProvider.selectedCat.catId;
                          print(widget.ad.adsCat);

                        });
                      },
                      value: _selectedCategory,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),



            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),
            FutureBuilder<List<CategoryModel>>(
              future: _subList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var categoryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<CategoryModel>(
                        child: new Text(item.catName),
                        value: item,
                      );
                    }).toList();
                    categoryList.removeAt(0);

                    if (_initSelectedSub) {

                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (widget.ad.adsSubCatName == snapshot.data[i].catName) {
                          _selectedSub = snapshot.data[i];
                          break;
                        }
                      }
                      _initSelectedSub = false;


                    }

                    return DropDownListSelector(
                      dropDownList: categoryList,
                      marg: .07,
                      hint:_homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub category',
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedSub = newValue;
                          _homeProvider.setSelectedSub(newValue);
                          widget.ad.adsSub=_homeProvider.selectedSub.catId;
                          print(widget.ad.adsSub);
                        });
                      },
                      value: _selectedSub,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else    if (snapshot.hasError) {
                  DioError error = snapshot.error;
                  String message = error.message;
                  if (error.type == DioErrorType.CONNECT_TIMEOUT)
                    message = 'Connection Timeout';
                  else if (error.type ==
                      DioErrorType.RECEIVE_TIMEOUT)
                    message = 'Receive Timeout';
                  else if (error.type == DioErrorType.RESPONSE)
                    message =
                    '404 server not found ${error.response.statusCode}';
                  print(message);
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),

            Container(
              margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
              child: CustomTextFormField(
                hintTxt:  AppLocalizations.of(context).translate('ad_price'),
                onChangedFunc: (text) {
                  _adsPrice = text;
                },
                initialValue: widget.ad.adsPrice,
                validationFunc: validateAdPrice,
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            Container(

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"رقم الجوال":"Phone",
                onChangedFunc: (text) {
                  _adsPhone = text;
                },
                validationFunc: validateAdPrice,
                initialValue: widget.ad.adsPhone,
              ),
            ),




            (widget.ad.adsCat=="1" && widget.ad.adsSub=="9")?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد النجوم"
                        : "Number of stars",
                    onChangedFunc: (text) {
                      _adsStars = text;
                    },
                    initialValue: widget.ad.adsStars,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الوحدات"
                        : "number of units",
                    onChangedFunc: (text) {
                      _adsItemsNumber = text;
                    },
                    initialValue: widget.ad.adsItemsNumber,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الادوار"
                        : "Number of roles",
                    onChangedFunc: (text) {
                      _adsDoorsNumber = text;
                    },
                    initialValue: widget.ad.adsDoorsNumber,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsQa3at,
                    hint: _homeProvider.currentLang == "ar"
                        ? "قاعة / قاعات"
                        : "Hall (s)",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsQa3at = newValue;
                      });
                    },
                    value: _selectedAdsQa3at,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMwaqef,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مواقف سيارات"
                        : "Car parking",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMwaqef = newValue;
                      });
                    },
                    value: _selectedAdsMwaqef,
                  ),
                )
              ],
            ):Text("",style: TextStyle(height: 0),),









            (widget.ad.adsCat=='1' && widget.ad.adsSub=='10')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الواجهة"
                        : "Interface",
                    onChangedFunc: (text) {
                      _adsFace = text;
                    },
                    initialValue: widget.ad.adsFace,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الوحدات"
                        : "number of units",
                    onChangedFunc: (text) {
                      _adsItemsNumber = text;
                    },
                    initialValue: widget.ad.adsItemsNumber,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsAsanser,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مصعد"
                        : "elevator",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsAsanser = newValue;
                      });
                    },
                    value: _selectedAdsAsanser,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMshb,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مشب"
                        : "JSB",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMwaqef,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مواقف سيارات"
                        : "Car parking",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMwaqef = newValue;
                      });
                    },
                    value: _selectedAdsMwaqef,
                  ),
                ),


              ],
            ):Text("",style: TextStyle(height: 0),),



















            (widget.ad.adsCat=='1' && widget.ad.adsSub=='11')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الواجهة"
                        : "Interface",
                    onChangedFunc: (text) {
                      _adsFace = text;
                    },
                    initialValue: widget.ad.adsFace,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الوحدات"
                        : "number of units",
                    onChangedFunc: (text) {
                      _adsItemsNumber = text;
                    },
                    initialValue: widget.ad.adsItemsNumber,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد المحلات"
                        : "number of stores",
                    onChangedFunc: (text) {
                      _adsShopsNumber= text;
                    },
                    initialValue: widget.ad.adsShopsNumber,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsAsanser,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مصعد"
                        : "elevator",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsAsanser = newValue;
                      });
                    },
                    value: _selectedAdsAsanser,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMshb,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مشب"
                        : "JSB",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMwaqef,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مواقف سيارات"
                        : "Car parking",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMwaqef = newValue;
                      });
                    },
                    value: _selectedAdsMwaqef,
                  ),
                ),


              ],
            ):Text("",style: TextStyle(height: 0),),











            (widget.ad.adsCat=='1' && widget.ad.adsSub=='12')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الواجهة"
                        : "Interface",
                    onChangedFunc: (text) {
                      _adsFace = text;
                    },
                    initialValue: widget.ad.adsFace,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الغرف"
                        : "number of rooms",
                    onChangedFunc: (text) {
                      _adsRoomNumbers = text;
                    },
                    initialValue: widget.ad.adsRoomNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد دورات المياه"
                        : "number of toilets",
                    onChangedFunc: (text) {
                      _adsBathNumbers = text;
                    },
                    initialValue: widget.ad.adsBathNumbers,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الصالات"
                        : "number of halled",
                    onChangedFunc: (text) {
                      _adsHallNumbers = text;
                    },
                    initialValue: widget.ad.adsHallNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد المطابخ"
                        : "number of kitchens",
                    onChangedFunc: (text) {
                      _adsKithchenNumber = text;
                    },
                    initialValue: widget.ad.adsKithchenNumber,
                  ),
                ),





                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsAsanser,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مصعد"
                        : "elevator",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsAsanser = newValue;
                      });
                    },
                    value: _selectedAdsAsanser,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsCarPath,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مدخل السيارة"
                        : "Entrance to the car",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsCarPath = newValue;
                      });
                    },
                    value: _selectedAdsCarPath,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsHoosh,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "حوش"
                        : "Hoosh",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsHoosh = newValue;
                      });
                    },
                    value: _selectedAdsHoosh,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMshb,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مشب"
                        : "JSB",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),


















            (widget.ad.adsCat=='1' && widget.ad.adsSub=='13')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الغرف"
                        : "number of rooms",
                    onChangedFunc: (text) {
                      _adsRoomNumbers = text;
                    },
                    initialValue: widget.ad.adsRoomNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد دورات المياه"
                        : "number of toilets",
                    onChangedFunc: (text) {
                      _adsBathNumbers = text;
                    },
                    initialValue: widget.ad.adsBathNumbers,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الصالات"
                        : "number of halled",
                    onChangedFunc: (text) {
                      _adsHallNumbers = text;
                    },
                    initialValue: widget.ad.adsHallNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد المطابخ"
                        : "number of kitchens",
                    onChangedFunc: (text) {
                      _adsKithchenNumber = text;
                    },
                    initialValue: widget.ad.adsKithchenNumber,
                  ),
                ),





                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsAsanser,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مصعد"
                        : "elevator",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsAsanser = newValue;
                      });
                    },
                    value: _selectedAdsAsanser,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsCarPath,
                    hint:_homeProvider.currentLang == "ar"
                        ? "مدخل السيارة"
                        : "Entrance to the car",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsCarPath = newValue;
                      });
                    },
                    value: _selectedAdsCarPath,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsHoosh,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "حوش"
                        : "Hoosh",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsHoosh = newValue;
                      });
                    },
                    value: _selectedAdsHoosh,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMshb,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مشب"
                        : "JSB",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),


















            (widget.ad.adsCat=='1' && widget.ad.adsSub=='14')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الموقع"
                        : "location",
                    onChangedFunc: (text) {
                      _adsLocation = text;
                    },
                    initialValue: widget.ad.adsLocation,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsBeer,
                    hint:_homeProvider.currentLang == "ar"
                        ? "بئر ماء"
                        : "Water well",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsBeer = newValue;
                      });
                    },
                    value: _selectedAdsBeer,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsRshashat,
                    hint:_homeProvider.currentLang == "ar"
                        ? "رشاشات ري"
                        : "Irrigation sprinklers",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsRshashat = newValue;
                      });
                    },
                    value: _selectedAdsRshashat,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),









            (widget.ad.adsCat=='1' && widget.ad.adsSub=='15')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الواجهة"
                        : "Interface",
                    onChangedFunc: (text) {
                      _adsFace = text;
                    },
                    initialValue: widget.ad.adsFace,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),









            (widget.ad.adsCat=='1' && widget.ad.adsSub=='16')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الغرف"
                        : "number of rooms",
                    onChangedFunc: (text) {
                      _adsRoomNumbers = text;
                    },
                    initialValue: widget.ad.adsRoomNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد دورات المياه"
                        : "number of toilets",
                    onChangedFunc: (text) {
                      _adsBathNumbers = text;
                    },
                    initialValue: widget.ad.adsBathNumbers,
                  ),
                ),



                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد الصالات"
                        : "number of halled",
                    onChangedFunc: (text) {
                      _adsHallNumbers = text;
                    },
                    initialValue: widget.ad.adsHallNumbers,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "عدد المطابخ"
                        : "number of kitchens",
                    onChangedFunc: (text) {
                      _adsKithchenNumber = text;
                    },
                    initialValue: widget.ad.adsKithchenNumber,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMsbh,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مسبح"
                        : "Swimming pool",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsCarPath,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مدخل السيارة"
                        : "Entrance to the car",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsCarPath = newValue;
                      });
                    },
                    value: _selectedAdsCarPath,
                  ),
                ),








                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMl2b,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "ملعب"
                        : "Playground",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMl2b = newValue;
                      });
                    },
                    value: _selectedAdsMl2b,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMshb,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "مشب"
                        : "JSB",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMshb = newValue;
                      });
                    },
                    value: _selectedAdsMshb,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),











            (widget.ad.adsCat=='1' && widget.ad.adsSub=='17')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الموقع"
                        : "location",
                    onChangedFunc: (text) {
                      _adsLocation = text;
                    },
                    initialValue: widget.ad.adsLocation,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "السعر"
                        : "price",
                    onChangedFunc: (text) {
                      _adsPrice = text;
                    },
                    initialValue: widget.ad.adsPrice,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsMwaqef,
                    hint: _homeProvider.currentLang == "ar"
                        ? "مواقف سيارات"
                        : "Car parking",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsMwaqef = newValue;
                      });
                    },
                    value: _selectedAdsMwaqef,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),










            (widget.ad.adsCat=='1' && widget.ad.adsSub=='18')?Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "المساحة"
                        : "Space",
                    onChangedFunc: (text) {
                      _adsArea = text;
                    },
                    initialValue: widget.ad.adsArea,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الموقع"
                        : "location",
                    onChangedFunc: (text) {
                      _adsLocation = text;
                    },
                    initialValue: widget.ad.adsLocation,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "السعر"
                        : "price",
                    onChangedFunc: (text) {
                      _adsPrice = text;
                    },
                    initialValue: widget.ad.adsPrice,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الحي"
                        : "Neighborhood",
                    onChangedFunc: (text) {
                      _adsAdress = text;
                    },
                    initialValue: widget.ad.adsAdress,
                  ),
                ),
                Container(
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الشارع"
                        : "Street",
                    onChangedFunc: (text) {
                      _adsStreet = text;
                    },
                    initialValue: widget.ad.adsStreet,
                  ),
                ),



              ],
            ):Text("",style: TextStyle(height: 0),),










            (widget.ad.adsCat=='2')?Column(
              children: <Widget>[


                FutureBuilder<List<Model>>(
                  future: _modelList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var modelList = snapshot.data.map((item) {

                          return new DropdownMenuItem<Model>(

                            child: new Text(item.modelName),
                            value: item,
                          );
                        }).toList();
                        modelList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: modelList,
                          marg: .07,
                          hint: _homeProvider.currentLang=='ar'?'الموديل':'Model',
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus( FocusNode());
                            setState(() {


                              _selectedModel = newValue;
                            });
                          },
                          value: _selectedModel,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "البيانات الاساسية"
                        : "basic information",
                    onChangedFunc: (text) {
                      _adsAsasia = text;
                    },
                    initialValue: widget.ad.adsAsasia,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsSellType,
                    hint: _homeProvider.currentLang == "ar"
                        ? "نوع البيع"
                        : "Type of sale",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsSellType = newValue;
                      });
                    },
                    value: _selectedAdsSellType,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsCarState,
                    hint: _homeProvider.currentLang == "ar"
                        ? "حالة المركبة"
                        : "Vehicle condition",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsCarState = newValue;
                      });
                    },
                    value: _selectedAdsCarState,
                  ),
                ),





                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsQeerType,
                    hint:_homeProvider.currentLang == "ar"
                        ? "نوع ناقل الحركة"
                        : "Transmission type",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsQeerType = newValue;
                      });
                    },
                    value: _selectedAdsQeerType,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsWqoodType,
                    hint:_homeProvider.currentLang == "ar"
                        ? "نوع الوقود"
                        : "Fuel type",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsWqoodType = newValue;
                      });
                    },
                    value: _selectedAdsWqoodType,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsDblFound,
                    hint:_homeProvider.currentLang == "ar"
                        ? "يوجد دبل"
                        : "There is a double",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsDblFound = newValue;
                        print(_selectedAdsDblFound);
                      });
                    },
                    value: _selectedAdsDblFound,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الممشي"
                        : "Walkway",
                    onChangedFunc: (text) {
                      _adsMmsha = text;
                    },
                    initialValue: widget.ad.adsMmsha,
                  ),
                ),




              ],
            ):Text("",style: TextStyle(height: 0),),

















            (widget.ad.adsCat=='3')?Column(
              children: <Widget>[

                FutureBuilder<List<Marka>>(
                  future: _markaList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var markaList = snapshot.data.map((item) {

                          return new DropdownMenuItem<Marka>(

                            child: new Text(item.markaName),
                            value: item,
                          );
                        }).toList();
                        markaList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: markaList,
                          marg: .07,
                          hint: _homeProvider.currentLang=='ar'?'الماركة':'Marka',
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus( FocusNode());
                            setState(() {


                              _selectedMarka = newValue;
                            });
                          },
                          value: _selectedMarka,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
                FutureBuilder<List<Model>>(
                  future: _modelList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasData) {
                        var modelList = snapshot.data.map((item) {

                          return new DropdownMenuItem<Model>(

                            child: new Text(item.modelName),
                            value: item,
                          );
                        }).toList();
                        modelList.removeAt(0);
                        return DropDownListSelector(
                          dropDownList: modelList,
                          marg: .07,
                          hint: _homeProvider.currentLang=='ar'?'الموديل':'Model',
                          onChangeFunc: (newValue) {
                            FocusScope.of(context).requestFocus( FocusNode());
                            setState(() {


                              _selectedModel = newValue;
                            });
                          },
                          value: _selectedModel,
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "البيانات الاساسية"
                        : "basic information",
                    onChangedFunc: (text) {
                      _adsAsasia = text;
                    },
                    initialValue: widget.ad.adsAsasia,
                  ),
                ),






                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsCarState,
                    hint:  _homeProvider.currentLang == "ar"
                        ? "حالة المعدة"
                        : "Vehicle condition",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsCarState = newValue;
                      });
                    },
                    value: _selectedAdsCarState,
                  ),
                ),




                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: DropDownListSelector(
                    marg: .07,
                    dropDownList: adsDblFound,
                    hint:_homeProvider.currentLang == "ar"
                        ? "يوجد دبل"
                        : "There is a double",
                    onChangeFunc: (newValue) {
                      FocusScope.of(context).requestFocus( FocusNode());
                      setState(() {
                        _selectedAdsDblFound = newValue;
                      });
                    },
                    value: _selectedAdsDblFound,
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(top: _height * 0.01,bottom: _height * 0.01),
                  child: CustomTextFormField(
                    hintTxt:_homeProvider.currentLang == "ar"
                        ? "الممشي"
                        : "Walkway",
                    onChangedFunc: (text) {
                      _adsMmsha = text;
                    },
                    initialValue: widget.ad.adsMmsha,
                  ),
                ),




              ],
            ):Text("",style: TextStyle(height: 0),),







            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            Container(

              child: CustomTextFormField(
                hintTxt:  _homeProvider.currentLang=="ar"?"للتواصل واتساب":"whatsapp",
                onChangedFunc: (text) {
                  _adsWhatsapp = text;
                },
       
                validationFunc: validateUserPhone,
              ),
            ),







            Container(
              margin: EdgeInsets.only(top: _height * 0.02,bottom: _height * 0.01),
            ),
            FutureBuilder<List<Country>>(
              future: _countryList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var countryList = snapshot.data.map((item) {
                      return new DropdownMenuItem<Country>(
                        child: new Text(item.countryName),
                        value: item,
                      );
                    }).toList();

                    if (_initSelectedCountry) {

                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (widget.ad.adsCountryName == snapshot.data[i].countryName) {
                          _selectedCountry = snapshot.data[i];
                          break;
                        }
                      }
                      _initSelectedCountry = false;


                    }

                    return DropDownListSelector(
                      dropDownList: countryList,
                      marg: .07,
                      hint:  AppLocalizations.of(context).translate('choose_country'),
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedCountry = newValue;
                          _selectedCity=null;
                          _homeProvider.setSelectedCountry(newValue);
                          _cityList = _homeProvider.getCityList(enableCountry: true,countryId:_homeProvider.selectedCountry.countryId);
                        });
                      },

                      value: _selectedCountry,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              margin: EdgeInsets.only(top: _height * 0.02),
            ),
            FutureBuilder<List<City>>(
              future: _cityList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.hasData) {
                    var cityList = snapshot.data.map((item) {
                      return new DropdownMenuItem<City>(
                        child: new Text(item.cityName),
                        value: item,
                      );
                    }).toList();

                    if (_initSelectedCity) {

                      for (int i = 0; i < snapshot.data.length; i++) {
                        if (widget.ad.adsCityName == snapshot.data[i].cityName) {
                          _selectedCity = snapshot.data[i];
                          break;
                        }
                      }
                      _initSelectedCity = false;


                    }


                    return DropDownListSelector(
                      dropDownList: cityList,
                      marg: .07,
                      hint:  AppLocalizations.of(context).translate('choose_city'),
                      onChangeFunc: (newValue) {
                        FocusScope.of(context).requestFocus( FocusNode());
                        setState(() {
                          _selectedCity = newValue;
                        });
                      },
                      value: _selectedCity,
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                } else    if (snapshot.hasError) {
                  DioError error = snapshot.error;
                  String message = error.message;
                  if (error.type == DioErrorType.CONNECT_TIMEOUT)
                    message = 'Connection Timeout';
                  else if (error.type ==
                      DioErrorType.RECEIVE_TIMEOUT)
                    message = 'Receive Timeout';
                  else if (error.type == DioErrorType.RESPONSE)
                    message =
                    '404 server not found ${error.response.statusCode}';
                  print(message);
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.02),
              child: CustomTextFormField(
                maxLines: 3,
                hintTxt:  AppLocalizations.of(context).translate('ad_description'),
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescription = text;
                },
                initialValue: widget.ad.adsDetails,
              ),
            ),


            /*   Container(
                alignment: Alignment.centerRight,

              child: CheckboxListTile(

                checkColor: Colors.white,
                activeColor: mainAppColor,
                title: Text("هل تريد اضافه موقع السلعه ؟",style: TextStyle(fontSize: 15),),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                    _homeProvider.setCheckedValue(newValue.toString());
                    print(_homeProvider.checkedValue);
                  });
                },

              ),
            ),

            _homeProvider.checkedValue=="true"?Container(
                width: _locData == null ? _width * 0.5 : _width *0.55,
                child: CustomButton(
                  btnColor: mainAppColor,
                  borderColor: accentColor,
                  onPressedFunction: (){
  _getCurrentUserLocation();

                  },
                  btnStyle: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  btnLbl: _locData == null ? AppLocalizations.of(context).translate('choose_location') : AppLocalizations.of(context).translate('detect_location'),
                )):Text(' ',style: TextStyle(height: 0),),

  */

            CustomButton(
              btnLbl: AppLocalizations.of(context).translate('publish_ad'),
              onPressedFunction: () async {
                if (_formKey.currentState.validate() &
                checkAddAdValidation(context,
                    imgFile: _imageFile,
                    adMainCategory: _selectedCategory,
                    adCity: _selectedCity)) {

                  FocusScope.of(context).requestFocus( FocusNode());
                  setState(() => _isLoading = true);

                  String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";



                  for (Asset a in images) {
                    final bytes = await a.getByteData();
                    imagesBytes[a.identifier] = bytes.buffer.asUint8List();
                  }
                  final imagesData = images.map((a) => MultipartFile.fromBytes(imagesBytes[a.identifier], filename: a.name)).toList();



                  if(_selectedAdsCarState=='جديدة'){
                    _omar="1";
                  }else if(_selectedAdsCarState=='مستعملة'){
                    _omar="2";
                  }else if(_selectedAdsCarState=='مصدومة'){
                    _omar="3";
                  }


                  if(_selectedAdsWqoodType=='بنزين'){
                    _ali="1";
                  }else if(_selectedAdsWqoodType=='ديزل'){
                    _ali="2";
                  }else if(_selectedAdsWqoodType=='هايبرد'){
                    _ali="3";
                  }


                  FormData formData = new FormData.fromMap({
                    "user_id": _authProvider.currentUser.userId,
                    "ads_title": _adsTitle,
                    "ads_details": _adsDescription,
                    "ads_cat": _selectedCategory.catId,
                    "ads_sub": _selectedSub.catId,
                    "ads_marka": _selectedMarka!=null?_selectedMarka.markaId:"0",
                    "ads_model": _selectedModel!=null?_selectedModel.modelId:"0",
                    "ads_country": _selectedCountry!=null?_selectedCountry.countryId:"0",
                    "ads_city": _selectedCity.cityId,
                    "ads_price": _adsPrice,
                    "ads_phone": _adsPhone,
                    "ads_whatsapp": _adsWhatsapp,

                    "ads_stars": _adsStars.toString(),
                    "ads_itemsNumber": _adsItemsNumber.toString(),
                    "ads_doorsNumber": _adsDoorsNumber.toString(),
                    "ads_area": _adsArea.toString(),
                    "ads_adress": _adsAdress.toString(),
                    "ads_street": _adsStreet.toString(),
                    "ads_mmsha": _adsMmsha.toString(),
                    "ads_asasia": _adsAsasia.toString(),
                    "ads_face": _adsFace.toString(),
                    "ads_location": _adsLocation.toString(),
                    "ads_kithchenNumber": _adsKithchenNumber.toString(),
                    "ads_bathNumbers": _adsBathNumbers.toString(),
                    "ads_hallNumbers": _adsHallNumbers.toString(),
                    "ads_roomNumbers": _adsRoomNumbers.toString(),
                    "ads_shopsNumber": _adsShopsNumber.toString(),

                    "ads_qa3at": _selectedAdsQa3at=="يوجد"?"1":"0",
                    "ads_mwaqef": _selectedAdsMwaqef=="يوجد"?"1":"0",
                    "ads_asanser": _selectedAdsAsanser=="يوجد"?"1":"0",
                    "ads_mshb": _selectedAdsMshb=="يوجد"?"1":"0",
                    "ads_carPath": _selectedAdsCarPath=="يوجد"?"1":"0",
                    "ads_hoosh": _selectedAdsHoosh=="يوجد"?"1":"0",
                    "ads_beer": _selectedAdsBeer=="يوجد"?"1":"0",
                    "ads_rshashat": _selectedAdsRshashat=="يوجد"?"1":"0",
                    "ads_msbh": _selectedAdsMsbh=="يوجد"?"1":"0",
                    "ads_ml2b": _selectedAdsMl2b=="يوجد"?"1":"0",
                    "ads_sellType ": _selectedAdsSellType =="تنازل"?"1":"0",
                    "ads_qeerType ": _selectedAdsQeerType =="اتوماتك"?"1":"0",
                    "ads_dblFound ":_selectedAdsDblFound,
                    "ads_carState  ": _omar,
                    "ads_wqoodType  ": _ali,



                    "imgURL":imagesData,
                  });
                  final results = await _apiProvider
                      .postWithDio(Urls.EDIT_AD_URL+ "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);


                  if (results['response'] == "1") {

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) {
                          return ConfirmationDialog(
                            title: AppLocalizations.of(context).translate('ad_has_published_successfully'),
                            message:
                            AppLocalizations.of(context).translate('ad_published_and_manage_my_ads'),
                          );
                        });
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/my_ads_screen');
                      _navigationProvider.upadateNavigationIndex(4);
                    });
                  } else {
                    Commons.showError(context, results["message"]);
                  }



                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {




    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,

      title:Text(AppLocalizations.of(context).translate('ad_edit'),style: TextStyle(fontSize: 15,color: omarColor),),
      actions: <Widget>[


        IconButton(
            icon: Consumer<AuthProvider>(
              builder: (context,authProvider,child){
                return authProvider.currentLang == 'ar' ? Image.asset(
                  'assets/images/left.png',
                  color: omarColor,
                ): Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child:  Image.asset(
                      'assets/images/left.png',
                      color: omarColor,
                    ));
              },
            ),
            onPressed: () =>
                Navigator.pop(context)

        )



      ],
    );


    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    return PageContainer(

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,

        body: _buildBodyItem(),
      ),
    );
  }
}
