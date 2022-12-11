import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tabouk/custom_widgets/ad_item/ad_item.dart';
import 'package:tabouk/custom_widgets/no_data/no_data.dart';
import 'package:tabouk/custom_widgets/safe_area/page_container.dart';
import 'package:tabouk/locale/app_localizations.dart';
import 'package:tabouk/models/ad.dart';
import 'package:tabouk/providers/auth_provider.dart';
import 'package:tabouk/providers/home_provider.dart';
import 'package:tabouk/providers/seller_ads_provider.dart';
import 'package:tabouk/ui/ad_details/ad_details_screen.dart';
import 'package:tabouk/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:tabouk/utils/error.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class SellerScreen extends StatefulWidget {
  final String userId;

  const SellerScreen({Key key, this.userId}) : super(key: key);
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> with TickerProviderStateMixin{
double _height = 0 , _width = 0;
HomeProvider _homeProvider;

AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


Widget _buildBodyItem(){
  return ListView(
    children: <Widget>[
         SizedBox(
            height: 30,
          ),

      Container(
        alignment: Alignment.center,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: accentColor,
              backgroundImage: NetworkImage(_homeProvider.currentSellerPhoto),
              maxRadius: 40,
            ),


          ],
        ),
      ),




          Container(
          alignment: Alignment.center,
            child: Text(_homeProvider.currentSellerName,style: TextStyle(color: Colors.black),),
          ),


  Container(


  height: 50,
  width: _width*.50,
  margin: EdgeInsets.symmetric(
  horizontal: _width * 0.20, vertical: _height * 0.01),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Color(0xffBFBFBF),
            blurRadius: 4.0,
            spreadRadius: 2
        ),
      ],
      border: Border.all(
        width: 0.1,
        color: Color(0xffBFBFBF),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
      color: Colors.white,
    ),



child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,

  children: <Widget>[
    Container(

      alignment: Alignment.center,
      child: Text(_homeProvider.currentSellerPhone,style: TextStyle(color: Colors.black),),
    ),

    GestureDetector(

      onTap: (){
        launch(
            "tel://${_homeProvider.currentSellerPhone}");
      },
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
          child: Image.asset('assets/images/phone1.png')),
    )
  ],
),
  ),


    Container(
      height: 20,
    ),

      Padding(padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerRight,
          child: Text(_homeProvider.currentLang=='ar'?"اعلانات المستخدم":"User ads",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        ),
      ),



              Container(
          height: _height - 80,
          width: _width,
          child: FutureBuilder<List<Ad>>(
                  future:  Provider.of<SellerAdsProvider>(context,
                          listen: false)
                      .getAdsList(widget.userId) ,
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
                              errorMessage: snapshot.error.toString(),
                           // errorMessage: "حدث خطأ ما ",
                          );
                        } else {
                          if (snapshot.data.length > 0) {
                     return     ListView.builder(
            itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
               var count = snapshot.data.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      _animationController.forward();
               return Container(

                 height: _height*.18,
                                        width: _width,
                 child: InkWell(
                   onTap: (){
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdDetailsScreen(
                                  ad: snapshot.data[index],


                                )));
                   },
                   child: AdItem(
                     animationController: _animationController,
                     animation: animation,
                     ad: snapshot.data[index],
                   )));
             }
          );
                          } else {
                            return NoData(message: AppLocalizations.of(context).translate('no_results'));
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  }),
        )
    ],
  );
}

@override
  Widget build(BuildContext context) {



  final appBar = AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor:Color(0xffF5F6F8),
    centerTitle: true,

    title:Text("صاحب الاعلان",style: TextStyle(fontSize: 15,color: omarColor),),
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
    _homeProvider = Provider.of<HomeProvider>(context);
  return PageContainer(
    child: Scaffold(
      backgroundColor: Color(0xffF5F6F8),
      appBar: appBar,
      body: _buildBodyItem(),
    ),
  );
  }
}