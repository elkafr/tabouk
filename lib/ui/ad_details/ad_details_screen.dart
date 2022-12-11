import 'package:flutter_html/flutter_html.dart';
import 'package:tabouk/custom_widgets/buttons/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/models/comments.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tabouk/models/miza.dart';
import 'package:tabouk/providers/comment_provider.dart';
import 'package:tabouk/models/ad_details.dart';
import 'package:tabouk/networking/api_provider.dart';
import 'package:tabouk/providers/ad_details_provider.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/favourite_provider.dart';
import 'package:tabouk/ui/chat/chat_screen.dart';
import 'package:tabouk/ui/seller/seller_screen.dart';
import 'package:tabouk/ui/section_ads/section_ads_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:tabouk/utils/commons.dart';
import 'package:tabouk/utils/urls.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:tabouk/ui/ad_details/widgets/slider_images.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/ui/comments/comment_bottom_sheet.dart';
import 'package:tabouk/ui/comment/comment_screen.dart';
import 'package:tabouk/ui/auth/login_screen.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:tabouk/custom_widgets/MainDrawer.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:tabouk/providers/navigation_provider.dart';


class AdDetailsScreen extends StatefulWidget {
  final Ad ad;

  const AdDetailsScreen({Key key, this.ad}) : super(key: key);
  @override
  _AdDetailsScreenState createState() => _AdDetailsScreenState();
}

class _AdDetailsScreenState extends State<AdDetailsScreen> {
  double _height = 0, _width = 0;
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  Completer<GoogleMapController> _controller = Completer();
  HomeProvider _homeProvider;
  String reportValue;
  TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String messageValue;
  NavigationProvider _navigationProvider;
  Future<List<Miza>> _mizaList;
  bool _initialRun = true;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) {
      _homeProvider = Provider.of<HomeProvider>(context);

      _mizaList = _homeProvider.getMizaList(widget.ad.adsId);
    _initialRun = false;
  }
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/pin.png',
    );
  }

  Widget _buildRow(
      {@required String imgPath,
      @required String title,
      @required String value}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1)),
      ),
      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: <Widget>[
          /* Image.asset(
          imgPath,
          color: Color(0xffC5C5C5),
          height: 15,
          width: 15,
        ), */
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title,
                style: TextStyle(color: omarColor, fontSize: 14),
              )),
          Spacer(),
          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }






  Widget _buildRow1(
      {@required String imgPath,
        @required String title,
        @required String value}) {
    return Container(

      padding: EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: <Widget>[
          /* Image.asset(
          imgPath,
          color: Color(0xffC5C5C5),
          height: 15,
          width: 15,
        ), */
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                title+" : ",
                style: TextStyle(color: omarColor, fontSize: 15),
              )),

          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(

            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  alignment:Alignment.center,
                  child: Text(_homeProvider.currentLang == "ar"
                      ? "ارسال بلاغ :-"
                      : "Send report :-",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: CustomTextFormField(
                    hintTxt: _homeProvider.currentLang == "ar"
                        ? "سبب البلاغ"
                        : "Report reason",
                    onChangedFunc: (text) async {
                      reportValue = text;
                    },
                  ),
                ),
                CustomButton(
                  btnColor: mainAppColor,
                  btnLbl: _homeProvider.currentLang == "ar" ? "ارسال" : "Send",
                  onPressedFunction: () async {
                    if (reportValue != null) {
                      final results = await _apiProvider.post(
                          Urls.REPORT_AD_URL +
                              "?api_lang=${_authProvider.currentLang}",
                          body: {
                            "report_user": _authProvider.currentUser.userId,
                            "report_gid": widget.ad.adsId,
                            "report_value": reportValue,
                          });

                      if (results['response'] == "1") {
                        Commons.showToast(context, message: results["message"]);
                        Navigator.pop(context);
                      } else {
                        Commons.showError(context, results["message"]);
                      }
                    } else {
                      Commons.showError(context, "يجب ادخال سبب البلاغ");
                    }
                  },
                ),
                Padding(padding: EdgeInsets.all(10)),
              ],
            ),

          );
        });
  }

  Widget _buildBodyItem() {
    return FutureBuilder<AdDetails>(
        future: Provider.of<AdDetailsProvider>(context, listen: false)
            .getAdDetails(widget.ad.adsId,_authProvider.currentUser!=null?_authProvider.currentUser.userId:"0"),
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
                  errorMessage: AppLocalizations.of(context).translate('error'),
                );
              } else {
                List comments = snapshot.data.adsComments;
                // List related= snapshot.data.adsRelated;
                //var initalLocation = snapshot.data.adsLocation.
                //split(',');
                // LatLng pinPosition = LatLng(double.parse(initalLocation[0]), double.parse(initalLocation[1]));

                // these are the minimum required values to set
                // the camera position
                // CameraPosition initialLocation = CameraPosition(
                //  zoom: 15,
                //  bearing: 30,
                //  target: pinPosition
                //  );



                LatLng pinPosition = LatLng(double.parse(widget.ad.adsMapx), double.parse(widget.ad.adsMapy));

                // these are the minimum required values to set
                // the camera position
                CameraPosition initialLocation = CameraPosition(
                    zoom: 15,
                    bearing: 30,
                    target: pinPosition
                );
                return ListView(
                  children: <Widget>[
                    (_homeProvider.omarKey == "1")
                        ? GestureDetector(
                            child: CustomButton(
                              btnLbl: _homeProvider.currentLang == "ar"
                                  ? "اخفاء المحتوى من هذا المعلن"
                                  : "Hide content from this advertiser",
                              btnColor: mainAppColor,
                              onPressedFunction: () async {
                                final results = await _apiProvider.post(
                                    "https://tabuk.sa.com/api/report999" +
                                        "?api_lang=${_authProvider.currentLang}",
                                    body: {
                                      // "report_user": _authProvider.currentUser.userId,
                                      "report_gid": widget.ad.adsId,
                                      //"report_value": reportValue,
                                    });

                                if (results['response'] == "1") {
                                  Commons.showToast(context,
                                      message: results["message"]);
                                  Navigator.pop(context);
                                } else {
                                  Commons.showError(
                                      context, results["message"]);
                                }
                              },
                            ),
                          )
                        : Text(
                            " ",
                            style: TextStyle(height: 0),
                          ),

                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04, vertical: _height * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.ad.adsTitle,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                widget.ad.adsCityName!=null?widget.ad.adsCityName:"",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                snapshot.data.adsFullDate,
                                style: TextStyle(height: 1.4, fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                              Row(
                                children: <Widget>[
                                  Text(
                                    snapshot.data.adsVisits,
                                    style: TextStyle(height: 1.4, fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Icon(Icons.remove_red_eye,color: Colors.grey[300],),

                                  Padding(padding: EdgeInsets.all(15)),
                                  Text(
                                    snapshot.data.checkAddFav.toString(),
                                    style: TextStyle(height: 1.4, fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Icon(Icons.favorite_border,color: Colors.grey[300],),

                                ],
                              )
                            ],
                          ),
                          Spacer(),


                          

                          Container(
                              margin: EdgeInsets.only(
                                right:
                                    _authProvider.currentLang != 'ar' ? 5 : 0,
                                left: _authProvider.currentLang == 'ar' ? 5 : 0,
                              ),



                              child: ClipOval(
                                child: Image.network(
                                  snapshot.data.adsPhoto,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ))
                        ],
                      ),
                    ),





                    snapshot.data.photos.length == 1
                        ? Container(
                      height: 255,
                      margin: EdgeInsets.symmetric(horizontal: 0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0)), //this right here
                                  child: Container(
                                    child: GestureZoomBox(
                                      maxScale: 5.0,
                                      doubleTapScale: 2.0,
                                      duration:
                                      Duration(milliseconds: 200),
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: Image.network(
                                        snapshot.data.adsMainPhoto,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: ClipRRect(
                          child: Image.network(
                            snapshot.data.adsMainPhoto,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    )
                        : Container(

                      height: 200,
                      margin: EdgeInsets.symmetric(
                          horizontal: _width * 0.04,
                          vertical: _height * 0.01),
                      child: SliderImages(),
                    ),






                      widget.ad.adsKind=="1"?CustomButton(
                        btnLbl: _homeProvider.currentLang=="ar"?"احجز الان":"Reserve now",
                        onPressedFunction: (){

                          if(_authProvider.currentUser!=null){

                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,

                                builder: (context) {

                                  return SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Padding(padding: EdgeInsets.all(15)),
                                          Container(

                                            child: Text(_homeProvider.currentLang=="ar"?"حجز الان":"Reserve now",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                          ),
                                          Padding(padding: EdgeInsets.all(15)),
                                          Container(

                                            child: CustomTextFormField(
                                              maxLines: 4,
                                              hintTxt: _homeProvider.currentLang=="ar"?"محتوى الرسالة":"Message content",

                                              onChangedFunc: (text) async{
                                                messageValue = text;
                                              },
                                            ),

                                          ),

                                          CustomButton(
                                            btnColor: mainAppColor,
                                            btnLbl:_homeProvider.currentLang=="ar"?"ارسال":"Send",
                                            onPressedFunction: () async{

                                              if(messageValue!=null) {

                                                final results = await _apiProvider
                                                    .post(Urls.SEND_URL , body: {
                                                  "message_sender": _authProvider.currentUser.userId,
                                                  "message_recever": widget.ad.adsUser,
                                                  "message_title": " حجز "+widget.ad.adsTitle,
                                                  "message_content": messageValue,
                                                  "message_type": "message",
                                                });


                                                if (results['response'] == "1") {
                                                  Commons.showToast(context, message: results["message"]);
                                                  Navigator.pop(context);
                                                } else {
                                                  Commons.showError(context, results["message"]);
                                                }

                                              }else{
                                                Commons.showError(context, "يجب ادخال الرسالة");
                                              }

                                            },
                                          ),

                                          Padding(padding: EdgeInsets.all(10)),




                                        ],
                                      ),
                                    ),
                                  );
                                });

                          }else{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoginScreen()));
                          }

                        },
                      ): widget.ad.adsKind=="3"?Row(
                        children: <Widget>[
                          SizedBox(width: _width*.06,),
                          Text(widget.ad.adsPrice,style: TextStyle(color: omarColor,fontSize: 16,fontWeight: FontWeight.bold),),
                          Padding(padding: EdgeInsets.all(2)),
                          Text("ريال",style: TextStyle(color: omarColor,fontSize: 16,fontWeight: FontWeight.bold),),

                          Container(
                            width: _width*.77,
                            child: CustomButton(
                              btnLbl: _homeProvider.currentLang=="ar"?"احجز الان":"Reserve now",
                              onPressedFunction: (){

                                if(_authProvider.currentUser!=null){

                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,

                                      builder: (context) {

                                        return SingleChildScrollView(
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[

                                                Padding(padding: EdgeInsets.all(15)),
                                                Container(

                                                  child: Text(_homeProvider.currentLang=="ar"?"حجز الان":"Reserve now",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                                ),
                                                Padding(padding: EdgeInsets.all(15)),
                                                Container(

                                                  child: CustomTextFormField(
                                                    maxLines: 4,
                                                    hintTxt: _homeProvider.currentLang=="ar"?"محتوى الرسالة":"Message content",

                                                    onChangedFunc: (text) async{
                                                      messageValue = text;
                                                    },
                                                  ),

                                                ),

                                                CustomButton(
                                                  btnColor: mainAppColor,
                                                  btnLbl:"ارسال",
                                                  onPressedFunction: () async{

                                                    if(messageValue!=null) {

                                                      final results = await _apiProvider
                                                          .post(Urls.SEND_URL , body: {
                                                        "message_sender": _authProvider.currentUser.userId,
                                                        "message_recever": widget.ad.adsUser,
                                                        "message_title": " حجز "+widget.ad.adsTitle,
                                                        "message_content": messageValue,
                                                        "message_type": "message",
                                                      });


                                                      if (results['response'] == "1") {
                                                        Commons.showToast(context, message: results["message"]);
                                                        Navigator.pop(context);
                                                      } else {
                                                        Commons.showError(context, results["message"]);
                                                      }

                                                    }else{
                                                      Commons.showError(context, "يجب ادخال الرسالة");
                                                    }

                                                  },
                                                ),

                                                Padding(padding: EdgeInsets.all(10)),




                                              ],
                                            ),
                                          ),
                                        );
                                      });

                                }else{
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()));
                                }

                              },
                            ),
                          ),
                        ],
                      ):Text(""),



                    Container(


                        color: Colors.grey[100],
                        padding: EdgeInsets.symmetric(
                            horizontal: _width * 0.04,
                            vertical: _width * 0.04
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Padding(padding: EdgeInsets.all(10)),
                            Html(data: snapshot.data.adsDetails),

                          ],
                        )
                    ),


                    Container(
                      margin: EdgeInsets.all(_width*.04),
                      child:  Text(_homeProvider.currentLang=="ar"?"المميزات":"Advantages",style: TextStyle(fontWeight: FontWeight.bold),),
                    ),

                    Container(

                      height: _width*.3,
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child: FutureBuilder<List<Miza>>(
                          future: Provider.of<HomeProvider>(context, listen: false)
                              .getMizaList(widget.ad.adsId),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return Text(_homeProvider.currentLang=="ar"?"لا يوجد مميزات":"No advantages found");
                                } else {
                                  if (snapshot.data.length > 0) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),

                                            width: _width,

                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(Icons.check_circle,size: 12,),
                                                Padding(padding: EdgeInsets.all(5)),
                                                Text(snapshot.data[index].mizaTitle,style: TextStyle(fontSize: 14,color: Colors.grey[900])),


                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    return Text(_homeProvider.currentLang=="ar"?"لا يوجد مميزات":"No advantages found");
                                  }
                                }
                            }
                            return SpinKitFadingCircle(color: mainAppColor);
                          }),
                    ),

                    (widget.ad.adsVideo!="0" && widget.ad.adsVideo!="" )?CustomButton(
                      height: 50,
                      btnLbl: _homeProvider.currentLang=="ar"?"مشاهدة الفديو":"Show video",
                      onPressedFunction: (){
                        launch(widget.ad.adsVideo);
                      },
                    ):Text(""),


                    SizedBox(height: 15,),
                    Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
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
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          widget.ad.adsType=="1"?GestureDetector(
                            onTap: () {
                              Share.share("https://tabuk.sa.com/site/show/" + widget.ad.adsId,
                                subject: widget.ad.adsDetails,
                                sharePositionOrigin: Rect.fromLTWH(0, 0, _width, _height / 2),
                              );
                            },
                            child: Icon(FontAwesomeIcons.shareAlt,color: Colors.grey[400],size: 30,),
                          ):widget.ad.adsType=="2"?GestureDetector(
                            onTap: () {
                              Share.share("https://tabuk.sa.com/site/show1/" + widget.ad.adsId,
                                subject: widget.ad.adsDetails,
                                sharePositionOrigin: Rect.fromLTWH(0, 0, _width, _height / 2),
                              );
                            },
                            child: Icon(FontAwesomeIcons.shareAlt,color: Colors.grey[400],size: 30,),
                          ):GestureDetector(
                            onTap: () {
                              Share.share("https://tabuk.sa.com/site/show2/" + widget.ad.adsId,
                                subject: widget.ad.adsDetails,
                                sharePositionOrigin: Rect.fromLTWH(0, 0, _width, _height / 2),
                              );
                            },
                            child: Icon(FontAwesomeIcons.shareAlt,color: Colors.grey[400],size: 30,),
                          ),

                         Container(
                           margin: EdgeInsets.only(right: _width*.06,left: _width*.06),
                           height: 30,
                           width: 1,
                           color: Colors.grey[300],
                         ),


                          widget.ad.adsType=="1"?GestureDetector(
                            onTap: () {
                              launch(
                                  "https://api.whatsapp.com/send?text=https://tabuk.sa.com/site/show/${widget.ad.adsId}");
                            },
                            child: Icon(FontAwesomeIcons.whatsapp,color: Colors.grey[400],size: 30,),
                          ):widget.ad.adsType=="2"?GestureDetector(
                            onTap: () {
                              launch(
                                  "https://api.whatsapp.com/send?text=https://tabuk.sa.com/site/show1/${widget.ad.adsId}");
                            },
                            child: Icon(FontAwesomeIcons.whatsapp,color: Colors.grey[400],size: 30,),
                          ):GestureDetector(
                            onTap: () {
                              launch(
                                  "https://api.whatsapp.com/send?text=https://tabuk.sa.com/site/show2/${widget.ad.adsId}");
                            },
                            child: Icon(FontAwesomeIcons.whatsapp,color: Colors.grey[400],size: 30,),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: _width*.06,left: _width*.06),
                            height: 30,
                            width: 1,
                            color: Colors.grey[300],
                          ),







                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.mail,size: 35,color: Colors.grey[400],),

                              alignment: Alignment.center,
                              width: 45,
                            ),
                            onTap: (){

                              if(_authProvider.currentUser!=null){

                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,

                                    builder: (context) {

                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[

                                              Padding(padding: EdgeInsets.all(15)),
                                              Container(

                                                child: Text("رسالة خاصة",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                              ),
                                              Padding(padding: EdgeInsets.all(15)),
                                              Container(

                                                child: CustomTextFormField(
                                                  maxLines: 4,
                                                  hintTxt: "محتوى الرسالة",

                                                  onChangedFunc: (text) async{
                                                    messageValue = text;
                                                  },
                                                ),

                                              ),

                                              CustomButton(
                                                btnColor: mainAppColor,
                                                btnLbl:"ارسال",
                                                onPressedFunction: () async{

                                                  if(messageValue!=null) {

                                                    final results = await _apiProvider
                                                        .post(Urls.SEND_URL , body: {
                                                      "message_sender": _authProvider.currentUser.userId,
                                                      "message_recever": widget.ad.adsUser,
                                                      "message_title": widget.ad.adsTitle,
                                                      "message_content": messageValue,
                                                      "message_type": "message",
                                                    });


                                                    if (results['response'] == "1") {
                                                      Commons.showToast(context, message: results["message"]);
                                                      Navigator.pop(context);
                                                    } else {
                                                      Commons.showError(context, results["message"]);
                                                    }

                                                  }else{
                                                    Commons.showError(context, "يجب ادخال الرسالة");
                                                  }

                                                },
                                              ),

                                              Padding(padding: EdgeInsets.all(10)),




                                            ],
                                          ),
                                        ),
                                      );
                                    });

                              }else{
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginScreen()));
                              }


                            },
                          ),

                          Container(
                            margin: EdgeInsets.only(right: _width*.06,left: _width*.06),
                            height: 30,
                            width: 1,
                            color: Colors.grey[300],
                          ),


                          _authProvider.currentUser == null
                              ? GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/login_screen'),
                            child: Center(
                                child: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color:mainAppColor,
                                )),
                          )
                              : Consumer<FavouriteProvider>(builder:
                              (context, favouriteProvider, child) {
                            return GestureDetector(
                              onTap: () async {
                                if (favouriteProvider.favouriteAdsList
                                    .containsKey(
                                    snapshot.data.adsId)) {
                                  favouriteProvider
                                      .removeFromFavouriteAdsList(
                                      snapshot.data.adsId);
                                  await _apiProvider.get(Urls
                                      .REMOVE_AD_from_FAV_URL +
                                      "ads_id=${snapshot.data.adsId}&user_id=${_authProvider.currentUser.userId}");
                                } else {
                                  favouriteProvider
                                      .addToFavouriteAdsList(
                                      snapshot.data.adsId, 1);
                                  await _apiProvider.post(
                                      Urls.ADD_AD_TO_FAV_URL,
                                      body: {
                                        "user_id": _authProvider
                                            .currentUser.userId,
                                        "ads_id": snapshot.data.adsId
                                      });
                                }
                              },
                              child: Center(
                                child: favouriteProvider
                                    .favouriteAdsList
                                    .containsKey(
                                    snapshot.data.adsId)
                                    ? SpinKitPumpingHeart(
                                  color: Colors.grey[400],
                                  size: 30,
                                )
                                    : Icon(
                                  Icons.favorite_border,
                                  size: 30,
                                  color: Colors.grey[400],
                                ),
                              ),
                            );
                          }),

                          Container(
                            margin: EdgeInsets.only(right: _width*.06,left: _width*.06),
                            height: 30,
                            width: 1,
                            color: Colors.grey[300],
                          ),


                          GestureDetector(
                            child:Icon(Icons.report,size: 35,color: Colors.grey[400],),
                            onTap: () async{
                              _settingModalBottomSheet(context);
                            },
                          ),





                        ],
                      ),
                    ),





          SizedBox(height: 15,),
                    widget.ad.adsKind=="1"?Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: _width * 0.04),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(0.0)),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                GestureDetector(
                  child:Icon(FontAwesomeIcons.facebook,color: Colors.grey[400],size: 30,),
                  onTap: (){
                    widget.ad.adsFacebook!=""?launch(widget.ad.adsFacebook):Commons.showError(context, _homeProvider.currentLang=="ar"?"لم يتم اضافة حساب":"No account has been added");
                  },
                ),



                GestureDetector(
                  child:Icon(FontAwesomeIcons.twitter,color: Colors.grey[400],size: 30,),
                  onTap: (){
                    widget.ad.adsTwitter!=""?launch(widget.ad.adsTwitter):Commons.showError(context, _homeProvider.currentLang=="ar"?"لم يتم اضافة حساب":"No account has been added");
                  },
                ),

                GestureDetector(
                  child:Icon(FontAwesomeIcons.snapchat,color: Colors.grey[400],size: 30,),
                  onTap: (){
                    widget.ad.adsSnapchat!=""?launch(widget.ad.adsSnapchat):Commons.showError(context, _homeProvider.currentLang=="ar"?"لم يتم اضافة حساب":"No account has been added");
                  },
                ),


                GestureDetector(
                  child:Icon(FontAwesomeIcons.instagram,color: Colors.grey[400],size: 30,),
                  onTap: (){
                    widget.ad.adsInstigram!=""?launch(widget.ad.adsInstigram):Commons.showError(context, _homeProvider.currentLang=="ar"?"لم يتم اضافة حساب":"No account has been added");
                  },
                ),


              ],
            ),
          ):Text(""),

                    SizedBox(height: 15,),

                    // Text(widget.ad.adsVideo),

                    widget.ad.adsKind=="1"? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15
                      ),
                      height: 150,
                      decoration: BoxDecoration(
                        color:  Color(0xffF3F3F3),
                        border: Border.all(
                          width: 1.0,
                          color: Color(0xffF3F3F3),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child:   GestureDetector(
                        onTap: (){
                          launch("https://maps.google.com/?daddr=${widget.ad.adsMapx},${widget.ad.adsMapy}");
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.all( Radius.circular(10.0)),
                            child: GoogleMap(

                                myLocationEnabled: true,

                                compassEnabled: true,

                                markers: _markers,

                                initialCameraPosition: initialLocation,

                                onMapCreated: (GoogleMapController controller) {

                                  controller.setMapStyle(Commons.mapStyles);

                                  _controller.complete(controller);



                                  setState(() {

                                    _markers.add(

                                        Marker(

                                            markerId: MarkerId(snapshot.data.adsId),

                                            position: pinPosition,

                                            icon: pinLocationIcon

                                        )

                                    );





                                  });



                                })),
                      ),
                    ):Text(""),


                    SizedBox(height: _width*.03,),

                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child: Text(
                        _homeProvider.currentLang=="ar"?" التعليقات":"ٍShow comments",
                        style: TextStyle(
                            color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: _width*.02,),
                    Container(

                      height: 250,
                      margin: EdgeInsets.symmetric(
                        horizontal: _width * 0.04,
                      ),
                      child: FutureBuilder<List<Comments>>(
                          future: Provider.of<CommentProvider>(context, listen: false)
                              .getCommentsList(_homeProvider.currentAds),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.active:
                                return Text('');
                              case ConnectionState.waiting:
                                return SpinKitFadingCircle(color: mainAppColor);
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return NoData(
                                    message:
                                    _homeProvider.currentLang=="ar"?"لا يوجد تعليقات":"No comments found",
                                  );
                                } else {
                                  if (snapshot.data.length > 0) {
                                    return ListView.builder(
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                            width: _width,
                                            height: _height * 0.13,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(snapshot.data[index].commentBy,style: TextStyle(fontSize: 14,color: Colors.grey[900])),
                                                    Padding(padding: EdgeInsets.all(2)),
                                                    Container(
                                                      width: 300,
                                                      child: Text(snapshot.data[index].commentDetails,style: TextStyle(fontSize: 16,color: mainAppColor,),maxLines: 2,),
                                                    ),
                                                    Text(snapshot.data[index].commentDate,style: TextStyle(fontSize: 14,color: Colors.grey[900])),
                                                  ],
                                                )


                                              ],
                                            ),
                                          );
                                        });
                                  } else {
                                    return NoData(
                                      message:
                                      AppLocalizations.of(context).translate('no_msgs'),
                                    );
                                  }
                                }
                            }
                            return SpinKitFadingCircle(color: mainAppColor);
                          }),
                    ),

                    SizedBox(height: _width*.01,),







                    CustomButton(
                      btnColor: mainAppColor,
                      btnLbl: _homeProvider.currentLang=="ar"?"اضف تعليق":"Add comment",
                      onPressedFunction: (){

                        if(_authProvider.currentUser!=null){

                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,

                              builder: (context) {

                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),

                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        Padding(padding: EdgeInsets.all(15)),
                                        Container(

                                          child: Text( _homeProvider.currentLang=="ar"?"اضف تعليق":"Add comment",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                        ),
                                        Padding(padding: EdgeInsets.all(15)),

                                        CustomTextFormField(
                                          enableHorizontalMargin: false,
                                          controller: _messageController,
                                          hintTxt: _homeProvider.currentLang=="ar"?"اكتب تعليقك هنا ...":"Add your comment here ...",
                                          suffix: IconButton(
                                            icon: Icon(Icons.send,color: mainAppColor,),
                                            onPressed: () async {


                                              final results = await _apiProvider
                                                  .post(Urls.ADD_COMMENT , body: {
                                                "ads_id":  _homeProvider.currentAds,
                                                "comment_details":_messageController.text.toString(),
                                                "user_id": _authProvider.currentUser.userId,


                                              });


                                              if (results['response'] == "1") {
                                                Commons.showToast(context, message: results["message"] );
                                                Navigator.pop(context);

                                              } else {
                                                Commons.showError(context, results["message"]);

                                              }


                                            },
                                          ),
                                        ),

                                        Padding(padding: EdgeInsets.all(10)),




                                      ],
                                    ),
                                  ),
                                );
                              });

                        }else{
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen()));
                        }

                      },
                    ),









                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              }
          }
          return Center(
            child: SpinKitFadingCircle(color: mainAppColor),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,


      title: Image.asset("assets/images/toplogo.png"),
      actions: <Widget>[
        IconButton(
            icon: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return authProvider.currentLang == 'ar'
                    ? Image.asset(
                        'assets/images/left.png',
                        color: omarColor,
                      )
                    : Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: Image.asset(
                          'assets/images/left.png',
                          color: omarColor,
                        ));
              },
            ),
            onPressed: () {

              _homeProvider.setSearchKey("");
              _homeProvider.setAdsKind("");
              _homeProvider.setSelectedCity(null);
              _homeProvider.setSelectedCat(null);


              _navigationProvider.upadateNavigationIndex(0);
              Navigator.pushReplacementNamed(context,  '/navigation');

            })
      ],
    );

    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);

    return PageContainer(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: appBar,
        body: _buildBodyItem(),
      ),
    );
  }
}
