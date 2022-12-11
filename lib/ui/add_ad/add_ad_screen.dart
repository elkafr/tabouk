import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/validation_mixin.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/commission_app_provider.dart';
import 'package:tabouk/models/commission_app.dart';
import 'package:tabouk/utils/error.dart';
import 'dart:math' as math;
import 'package:tabouk/custom_widgets/MainDrawer.dart';



class AddAdScreen extends StatefulWidget {
  @override
  _AddAdScreenState createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> with ValidationMixin {
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

  bool checkedValue=false;

  Future<List<Marka>> _markaList;
  Marka _selectedMarka;

  Future<List<Model>> _modelList;
  Model _selectedModel;


  dynamic _pickImageError;
  final _picker = ImagePicker();
  AuthProvider _authProvider;
  ApiProvider _apiProvider =ApiProvider();
  CommisssionAppProvider _commisssionAppProvider;
  Future<CommissionApp> _commissionApp;
  bool _isLoading = false;
  String _adsTitle = '';
  String _adsTitleEn = '';
  String _adsWebsite = '';
  String _adsPrice = '';
  String _adsPhone = '';
  String _adsWhatsapp = '';
  String _adsDescription = '';
  String _adsDescriptionEn = '';
  String _adsFacebook = '';
  String _adsTwitter = '';
  String _adsInstigram = '';
  String _adsSnapchat = '';
  String _adsVideo = '';


  String _adsAdress='';



  NavigationProvider _navigationProvider;
  LocationData _locData;








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

  Widget _buildRow(String title, String value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          Container(
            width:  _width *0.55,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,fontSize: 12, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
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








      _homeProvider = Provider.of<HomeProvider>(context);

      _commisssionAppProvider = Provider.of<CommisssionAppProvider>(context);
      _commissionApp = _commisssionAppProvider.getCommissionApp();

      _categoryList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('total'),catImage: 'assets/images/all.png'),enableSub: false);

      _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
      AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:'6');

      _countryList = _homeProvider.getCountryList();
      _cityList = _homeProvider.getCityList(enableCountry: true,countryId:'0');
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


print(_yy);











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


           Center(
             child:  GestureDetector(
                 onTap: (){
                   _settingModalBottomSheet2(context);
                 },
                 child: Container(

                   height: _height * 0.13,
                   width: _width*.27,

                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(150.0)),
                     border: Border.all(
                       color: mainAppColor,
                     ),
                     color: Colors.white,

                   ),
                   child: Stack(
                     children: <Widget>[
                   Container(

                     child: _imageFile2 != null
                         ?ClipRRect(
                         borderRadius: BorderRadius.circular(8.0),
                         child:  Image.file(
                           _imageFile2,
                           // fit: BoxFit.fill,
                         ))
                         : Icon(Icons.image,size: 70,color: Colors.grey[300],),
                     padding: EdgeInsets.only(top: 12,right: 15),
                   ),

                       Positioned(
                         child: Icon(Icons.add_circle,color: Colors.green,size: 35,),
                         bottom: 0,
                       )
                     ],
                   ),
                 )),
           ),





            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"اسم العلامة التجارية بالعربية":"Brand name in Arabic",

                onChangedFunc: (text) {
                  _adsTitle = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"اسم العلامة التجارية بالانجليزية":"Brand name in English",

                onChangedFunc: (text) {
                  _adsTitleEn = text;
                },
                validationFunc: validateAdTitle,
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"رقم التواصل":"contact number",

                      onChangedFunc: (text) {
                        _adsPhone = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"الموقع الالكتروني":"website",

                      onChangedFunc: (text) {
                        _adsWebsite = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                ],
              ),
            ),




            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _width*.46,
                    child: FutureBuilder<List<CategoryModel>>(
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
                            return DropDownListSelector(
                              dropDownList: categoryList,
                              marg: .03,
                              hint: _homeProvider.currentLang=='ar'?'القسم الرئيسي':'Main category',
                              onChangeFunc: (newValue) {
                                FocusScope.of(context).requestFocus( FocusNode());
                                setState(() {


                                  _selectedCategory = newValue;
                                  _selectedSub=null;
                                  _homeProvider.setSelectedCat(newValue);
                                  _subList = _homeProvider.getCategoryList(categoryModel:  CategoryModel(isSelected:false ,catId: '0',catName:
                                  AppLocalizations.of(context).translate('all'),catImage: 'assets/images/all.png'),enableSub: true,catId:_homeProvider.selectedCat.catId);


                                  _xx=_homeProvider.selectedCat.catId;
                                  print(_xx);

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
                  ),
                  Container(
                    width: _width*.46,
                    child:FutureBuilder<List<CategoryModel>>(
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
                            return DropDownListSelector(
                              dropDownList: categoryList,
                              marg: .03,
                              hint:_homeProvider.currentLang=='ar'?'القسم الفرعي':'Sub category',
                              onChangeFunc: (newValue) {
                                FocusScope.of(context).requestFocus( FocusNode());
                                setState(() {
                                  _selectedSub = newValue;
                                  _homeProvider.setSelectedSub(newValue);
                                  _yy=_homeProvider.selectedSub.catId;
                                  print(_yy);
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
                  ),
                ],
              ),
            ),






            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _width*.46,
                    child:  FutureBuilder<List<City>>(
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
                            return DropDownListSelector(
                              dropDownList: cityList,
                              marg: .03,
                              hint:  _homeProvider.currentLang=="ar"?"اختر المدينة":"Select city",
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
                  ),
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"العنوان":"Adress",

                      onChangedFunc: (text) {
                        _adsAdress = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                ],
              ),
            ),















            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: CustomTextFormField(
                maxLines: 3,
                hintTxt:_homeProvider.currentLang=="ar"?"التفاصيل بالعربية":"Details in Arabic",
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescription = text;
                },
              ),
            ),



            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              child: CustomTextFormField(
                maxLines: 3,
                hintTxt:_homeProvider.currentLang=="ar"?"التفاصيل بالانجليزية":"Details in English",
                validationFunc: validateAdDescription,
                onChangedFunc: (text) {
                  _adsDescriptionEn = text;
                },
              ),
            ),





            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"رابط facebook":"Facebook url",

                      onChangedFunc: (text) {
                        _adsFacebook = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"رابط Twitter":"Twitter url",

                      onChangedFunc: (text) {
                        _adsTwitter = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                ],
              ),
            ),





            Container(
              margin: EdgeInsets.symmetric(vertical: _height * 0.01),
              width: _width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"رابط instigram":"Instigram url",

                      onChangedFunc: (text) {
                        _adsInstigram = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                  Container(
                    width: _width*.46,
                    child: CustomTextFormField(
                      hintTxt: _homeProvider.currentLang=="ar"?"رابط Snapchat":"Snapchat url",

                      onChangedFunc: (text) {
                        _adsSnapchat = text;
                      },
                      validationFunc: validateAdTitle,
                    ),
                  ),
                ],
              ),
            ),



            Container(

              child: CustomTextFormField(
                hintTxt: _homeProvider.currentLang=="ar"?"رابط فديو يوتيوب ان وجد":"Youtube video link, if available",

                onChangedFunc: (text) {
                  _adsVideo= text;
                },
                validationFunc: validateAdTitle,
                suffixIconIsImage: true,
                suffixIconImagePath: "assets/images/video.png",
              ),
            ),


            SizedBox(height: _width*.02,),


            GestureDetector(
                onTap: loadAssets,
                child: Container(

                  height: _height * 0.07,
                  width: _width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: _height * 0.04),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(
                      color: hintColor.withOpacity(0.1),
                    ),
                    color: Colors.white,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      Text("اختر صور الاعلان",style: TextStyle(fontSize: 14,color: omarColor),),
                      Spacer(),
                      Image.asset('assets/images/image.png'),
                    ],
                  ),
                )),




            Stack(
              children: <Widget>[
                Container(
                    width:_width,
                    alignment: Alignment.centerRight,
                    child: CustomButton(

                      btnColor: Colors.white,
                      borderColor: accentColor,
                      onPressedFunction: (){
                        _getCurrentUserLocation();

                      },
                      btnStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                      btnLbl: _locData == null ? AppLocalizations.of(context).translate('choose_location') : AppLocalizations.of(context).translate('detect_location'),
                    )),
                Positioned(
                    child: Image.asset("assets/images/location.png"),
                  left: _width*.1,
                  top: _width*.05,
                )
              ],
            ),

            SizedBox(height: _width*.03,),

            Container(
              margin: EdgeInsets.only(left: _width*.06,right: _width*.06),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _homeProvider.currentLang=="ar"?Text("رسوم الاشترك قى الباقة المختارة ${_homeProvider.packagePrice} ريال",style: TextStyle(fontWeight: FontWeight.bold),):Text("Subscription fee for the selected package ${_homeProvider.packagePrice} SR",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.all(5)),
                  Text(_homeProvider.currentLang=="ar"?"فضلا تحويل المبلغ على احد حسابتنا التالية وارفاق صورة التحويل لتاكيد اضافة علامتكم لتجارية بالمنصة":"Please transfer the amount to one of our following accounts and attach a copy of the transfer to confirm adding your brand to the platform",style: TextStyle(),),
                ],
              ),
            ),

            Container(
              height: _width*.3,
              child: FutureBuilder<CommissionApp>(
                  future: _commissionApp,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return Center(
                          child: SpinKitFadingCircle(color: mainAppColor),
                        );
                      case ConnectionState.active:
                        return Text('');
                      case ConnectionState.waiting:
                        return Center(
                          child: SpinKitFadingCircle(color: mainAppColor),
                        );
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return Error(
                            //  errorMessage: snapshot.error.toString(),
                            errorMessage:AppLocalizations.of(context).translate('error'),
                          );
                        } else {
                          return  Container(
                            child: ListView.builder(
                                itemCount: snapshot.data.banks.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: _width*.06, left: _width*.06, right: _width*.06),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          const Radius.circular(15.00),
                                        ),
                                        border: Border.all(color: hintColor)),
                                    height: _width*.27,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                                color: accentColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: (Radius.circular(15.0)),
                                                    topRight: (Radius.circular(15.0)))),
                                            height: 45,
                                            width: _width,
                                            child: Center(
                                              child: Text(
                                                snapshot.data.banks[index].bankTitle,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                              ),
                                            )),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          child: _buildRow(
                                              '${AppLocalizations.of(context).translate('account_owner')}   :   ',
                                              snapshot.data.banks[index].bankName),
                                        ),
                                        _buildRow(
                                            '${AppLocalizations.of(context).translate('account_number')} :   ',
                                            snapshot.data.banks[index].bankAcount),

                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }),
            ),

            SizedBox(height: _width*.02,),


            GestureDetector(
                onTap: (){
                  _settingModalBottomSheet1(context);
                },
                child: Container(

                  height: _height * 0.07,
                  width: _width,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.symmetric(horizontal: _height * 0.04),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    border: Border.all(
                      color: hintColor.withOpacity(0.1),
                    ),
                    color: Colors.white,

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[


                      Text("رفع صورة الحوالة",style: TextStyle(fontSize: 14,color: omarColor),),
                      Spacer(),
                      Image.asset('assets/images/image.png'),
                    ],
                  ),
                )),

           _isLoading
      ? Center(
      child:SpinKitFadingCircle(color: mainAppColor),
    )
        :CustomButton(
              btnLbl: _homeProvider.currentLang=="ar"?"إضافة":"Add",
              onPressedFunction: () async {
                if (_formKey.currentState.validate() &
                    checkAddAdValidation(context,
                    imgFile: _imageFile,
                        adMainCategory: _selectedCategory,
                        adCity: _selectedCity)) {

                               FocusScope.of(context).requestFocus( FocusNode());
                             setState(() => _isLoading = true);

                               String fileName = (_imageFile!=null)?Path.basename(_imageFile.path):"";

                               String fileName1 = (_imageFile1!=null)?Path.basename(_imageFile1.path):"";
                               String fileName2 = (_imageFile2!=null)?Path.basename(_imageFile2.path):"";

                               for (Asset a in images) {
                                 final bytes = await a.getByteData();
                                 imagesBytes[a.identifier] = bytes.buffer.asUint8List();
                               }
                               final imagesData = images.map((a) => MultipartFile.fromBytes(imagesBytes[a.identifier], filename: a.name)).toList();









                  FormData formData = new FormData.fromMap({
                    "user_id": _authProvider.currentUser.userId,
                    "ads_title": _adsTitle,
                    "ads_title_en": _adsTitleEn,
                    "ads_phone": _adsPhone,
                    "ads_website": _adsWebsite,
                    "ads_cat": _selectedCategory.catId,
                    "ads_sub": _selectedSub.catId,
                    "ads_city": _selectedCity.cityId,
                    "ads_adress": _adsAdress.toString(),
                    "ads_details": _adsDescription,
                    "ads_details_en": _adsDescriptionEn,
                    "ads_facebook": _adsFacebook,
                    "ads_twitter": _adsTwitter,
                    "ads_instigram": _adsInstigram,
                    "ads_snapchat": _adsSnapchat,
                    "ads_video": _adsVideo,
                    "ads_package_id": _homeProvider.packageId,
                    "ads_package_period": _homeProvider.packagePeriod,
                    "ads_package_price": _homeProvider.packagePrice,
                    "ads_kind": "1",
                    "imgURL":imagesData,
                    "imgURL1": (_imageFile1!=null)?await MultipartFile.fromFile(_imageFile1.path, filename: fileName1):"",
                    "imgURL2": (_imageFile2!=null)?await MultipartFile.fromFile(_imageFile2.path, filename: fileName2):"",
                  });
                  final results = await _apiProvider
                      .postWithDio(Urls.ADD_AD_URL + "?api_lang=${_authProvider.currentLang}", body: formData);
                  setState(() => _isLoading = false);


                  if (results['response'] == "1") {

                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (_) {
                          return ConfirmationDialog(
                            title: results['message'],
                            message:
                                "",
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
      backgroundColor: Color(0xffF5F6F8),
      centerTitle: true,

      title:Text(_homeProvider.currentLang=="ar"?"اضافة علامة تجارية":"Add a brand",style: TextStyle(fontSize: 15,color: omarColor),),
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
    _navigationProvider = Provider.of<NavigationProvider>(context);
    return PageContainer(

      child: Scaffold(
        backgroundColor: Color(0xffF5F6F8),
        appBar: appBar,


        body: _buildBodyItem(),
      ),
    );
  }
}
