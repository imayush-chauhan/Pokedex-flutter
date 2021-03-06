import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokidexayu/data/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoScreen extends StatefulWidget {
  final bool appBar;
  final int inx;

  InfoScreen({
    required this.inx,
    required this.appBar});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

  int max = 20;
  bool isType = false;
  String click = "";
  int total = 0;

  Future<bool> onWillPop() async {
    return (await set()) ?? false;
  }

  set() {
    isType == false ?
    Navigator.of(context).pop() :
    setState(() {
      isType = false;
    });
  }

  BannerAd? _ad;
  bool isLoaded = false;

  bannerAds(){
    if(Data.showAds == true){
      print("inside banner ads>>>>>>>>>>>>>>>");
      _ad = BannerAd(
        // adUnitId: "ca-app-pub-3028010056599796/1261198552",
        // adUnitId: "ca-app-pub-3028010056599796/1626317951",
        adUnitId: BannerAd.testAdUnitId,
        // adUnitId: "ca-app-pub-3940256099942544/6300978111",
        // adUnitId: "ca-app-pub-3028010056599796/1261198552",
        size: AdSize.banner,
        request: AdRequest(),
        listener: AdListener(
            onAdLoaded: (_){
              setState(() {
                isLoaded = true;
                print("isLoaded is true >>>>>>>>>>>>>>>");
              });
            },
            onAdFailedToLoad: (_ad,error){
              print("Ad failed to load on Error: $error");
              _ad.dispose();
            }
        ),
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _ad!.load();
        });
      });
    }
  }

  checkForAd(){
    if(Data.showAds == true){
      if(isLoaded == true){
        return Container(
          child: Center(
            child: AdWidget(
              ad: _ad!,
            ),
          ),
          height: _ad!.size.height.toDouble(),
          width: _ad!.size.width.toDouble(),
          alignment: Alignment.center,
        );
      }else{
        return Container(
          height: 20,
          width: 320,
        );
      }
    }else{
      return Container(
        height: 20,
        width: 320,
      );
    }
  }

  InterstitialAd? _in;
  bool isLoadedIn = false;

  loadInAd(){
    if(Data.showAds == true){
      _in = InterstitialAd(
        // adUnitId: "ca-app-pub-3028010056599796/1200794278",
        adUnitId: InterstitialAd.testAdUnitId,
        request: AdRequest(
          keywords: ["amazon", "games", "land", "collage","toys","learn","coding","food"],
        ),
        listener: AdListener(
            onAdLoaded: (_){
              setState(() {
                isLoadedIn = true;
              });
            },
            onAdFailedToLoad: (_ad,error){
              print("Ad failed to load on Error: $error");
            }
        ),
      );
      _in!.load();
    }
  }

  showInAd(){
    if(isLoadedIn == true){
      _in!.show();
    }
  }

  setFav() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      myPrefs.setStringList("fav", Data.fav).then((value) {
        getFav();
      });
    });
  }

  getFav() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if (myPrefs.getStringList("fav") != null) {
      setState(() {
        Data.fav = myPrefs.getStringList("fav")!;
      });
    }
  }

  late Color mainColor;
  late Color thickColor;

  Duration duration = Duration(milliseconds: 500);
  Curve curve = Curves.easeInOut;

  @override
  void initState() {
    super.initState();
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Electric") {
      mainColor = Colors.yellowAccent.shade200;
      thickColor = Colors.yellowAccent.shade700;
    } else if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Fire") {
      mainColor = Colors.orangeAccent.shade200;
      thickColor = Colors.orangeAccent.shade400;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Grass") {
      mainColor = Colors.greenAccent.shade200;
      thickColor = Colors.greenAccent.shade400;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Water") {
      mainColor = Colors.blueAccent.shade200;
      thickColor = Colors.blueAccent.shade400;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Poison") {
      mainColor = Colors.purpleAccent.shade200;
      thickColor = Colors.purpleAccent.shade700;
    } else if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Rock") {
      mainColor = Colors.grey.shade200;
      thickColor = Colors.grey.shade500;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Ghost") {
      mainColor = Colors.deepPurple.shade300;
      thickColor = Colors.deepPurple.shade300;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Psychic") {
      mainColor = Colors.deepPurpleAccent.shade200;
      thickColor = Colors.deepPurpleAccent.shade700;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Fighting") {
      mainColor = Colors.redAccent.shade200;
      thickColor = Colors.redAccent.shade400;
    } else
    if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Ground") {
      mainColor = Colors.brown.shade200;
      thickColor = Colors.brown.shade400;
    } else if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Bug") {
      mainColor = Colors.greenAccent.shade200;
      thickColor = Colors.greenAccent.shade400;
    } else if (Data.poke["pokemon"][widget.inx]["typeofpokemon"][0] == "Dark") {
      mainColor = Colors.grey.shade200;
      thickColor = Colors.grey.shade500;
    } else {
      mainColor = Colors.grey.shade200;
      thickColor = Colors.grey.shade400;
    }
    totalPoints();
    Future.delayed(Duration(milliseconds: 400), () {
      calculator();
    });
    bannerAds();
  }

  totalPoints(){
    setState(() {
      total = Data.poke["pokemon"][widget.inx]["special_defense"] +
          Data.poke["pokemon"][widget.inx]["special_attack"] +
          Data.poke["pokemon"][widget.inx]["speed"] +
          Data.poke["pokemon"][widget.inx]["hp"] +
          Data.poke["pokemon"][widget.inx]["attack"] +
          Data.poke["pokemon"][widget.inx]["defense"];
    });
  }

  calculator() {
    setState(() {
      max = Data.poke["pokemon"][widget.inx]["special_defense"];
      if (Data.poke["pokemon"][widget.inx]["special_attack"] >=
          Data.poke["pokemon"][widget.inx]["special_defense"] &&
          Data.poke["pokemon"][widget.inx]["special_attack"] >=
              Data.poke["pokemon"][widget.inx]["speed"] &&
          Data.poke["pokemon"][widget.inx]["special_attack"] >=
              Data.poke["pokemon"][widget.inx]["hp"] &&
          Data.poke["pokemon"][widget.inx]["special_attack"] >=
              Data.poke["pokemon"][widget.inx]["attack"] &&
          Data.poke["pokemon"][widget.inx]["special_attack"] >=
              Data.poke["pokemon"][widget.inx]["defense"]) {
        max = Data.poke["pokemon"][widget.inx]["special_attack"];
      } else if (Data.poke["pokemon"][widget.inx]["speed"] >=
          Data.poke["pokemon"][widget.inx]["special_defense"] &&
          Data.poke["pokemon"][widget.inx]["speed"] >=
              Data.poke["pokemon"][widget.inx]["special_attack"] &&
          Data.poke["pokemon"][widget.inx]["speed"] >=
              Data.poke["pokemon"][widget.inx]["hp"] &&
          Data.poke["pokemon"][widget.inx]["speed"] >=
              Data.poke["pokemon"][widget.inx]["attack"] &&
          Data.poke["pokemon"][widget.inx]["speed"] >=
              Data.poke["pokemon"][widget.inx]["defense"]) {
        max = Data.poke["pokemon"][widget.inx]["speed"];
      } else if (Data.poke["pokemon"][widget.inx]["hp"] >=
          Data.poke["pokemon"][widget.inx]["special_defense"] &&
          Data.poke["pokemon"][widget.inx]["hp"] >=
              Data.poke["pokemon"][widget.inx]["special_attack"] &&
          Data.poke["pokemon"][widget.inx]["hp"] >=
              Data.poke["pokemon"][widget.inx]["speed"] &&
          Data.poke["pokemon"][widget.inx]["hp"] >=
              Data.poke["pokemon"][widget.inx]["attack"] &&
          Data.poke["pokemon"][widget.inx]["hp"] >=
              Data.poke["pokemon"][widget.inx]["defense"]) {
        max = Data.poke["pokemon"][widget.inx]["hp"];
      } else if (Data.poke["pokemon"][widget.inx]["defense"] >=
          Data.poke["pokemon"] [widget.inx]["special_defense"] &&
          Data.poke["pokemon"][widget.inx]["defense"] >=
              Data.poke["pokemon"][widget.inx]["special_attack"] &&
          Data.poke["pokemon"][widget.inx]["defense"] >=
              Data.poke["pokemon"][widget.inx]["hp"] &&
          Data.poke["pokemon"][widget.inx]["defense"] >=
              Data.poke["pokemon"][widget.inx]["attack"] &&
          Data.poke["pokemon"][widget.inx]["defense"] >=
              Data.poke["pokemon"][widget.inx]["speed"]) {
        max = Data.poke["pokemon"][widget.inx]["defense"];
      } else if (Data.poke["pokemon"][widget.inx]["attack"] >=
          Data.poke["pokemon"][widget.inx]["special_defense"] &&
          Data.poke["pokemon"][widget.inx]["attack"] >=
              Data.poke["pokemon"][widget.inx]["special_attack"] &&
          Data.poke["pokemon"][widget.inx]["attack"] >=
              Data.poke["pokemon"][widget.inx]["speed"] &&
          Data.poke["pokemon"][widget.inx]["attack"] >=
              Data.poke["pokemon"][widget.inx]["hp"] &&
          Data.poke["pokemon"][widget.inx]["attack"] >=
              Data.poke["pokemon"][widget.inx]["defense"]) {
        max = Data.poke["pokemon"][widget.inx]["attack"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Data.poke["pokemon"] == {}) {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: mainColor,
        body: Stack(
          children: [
            SafeArea(
              child: GestureDetector(
                onTap: () {
                  Future.delayed(Duration(milliseconds: 100), () {
                    setState(() {
                      isType = false;
                      click = "";
                    });
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 5,),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.22,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.98,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                                color: Colors.black.withOpacity(0.2)),
                          ),
                          color: Colors.white.withOpacity(0.2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 0,
                                ),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.5,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, top: 10, bottom: 15),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(Data.poke["pokemon"][widget
                                                .inx]["name"],
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black.withOpacity(
                                                    0.6),
                                              ),),
                                            Text(Data.poke["pokemon"][widget
                                                .inx]["id"],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black
                                                      .withOpacity(0.6)
                                              ),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .center,
                                              children: [
                                                Text(Data.poke["pokemon"][widget
                                                    .inx]["height"] + ",",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                  ),),
                                                SizedBox(width: 8,),
                                                Text(Data.poke["pokemon"][widget
                                                    .inx]["weight"],
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .w600,
                                                      color: Colors.black
                                                          .withOpacity(0.6)
                                                  ),),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (Data.fav.contains(
                                                    Data.poke["pokemon"][widget
                                                        .inx]["id"].substring(
                                                        1))) {
                                                  setState(() {
                                                    Data.fav.removeAt(
                                                        Data.fav.indexOf(Data
                                                            .poke["pokemon"][widget
                                                            .inx]["id"]
                                                            .substring(1)));
                                                    setFav();
                                                  });
                                                } else {
                                                  setState(() {
                                                    Data.fav.add(Data
                                                        .poke["pokemon"][widget
                                                        .inx]["id"].substring(
                                                        1));
                                                    setFav();
                                                  });
                                                }
                                              },
                                              child: Icon(Data.fav.contains(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["id"].substring(1))
                                                  ?
                                              Icons.star
                                                  : Icons.star_border),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              isType == false ?
                                              Future.delayed(Duration(milliseconds: 800), () {
                                                setState(() {
                                                  click =
                                                  Data.poke["pokemon"][widget
                                                      .inx]["typeofpokemon"][0];
                                                });
                                              }) : setState(() {
                                                click =
                                                Data.poke["pokemon"][widget
                                                    .inx]["typeofpokemon"][0];
                                              });
                                                Future.delayed(Duration(milliseconds: 100), () {
                                                  setState(() {
                                                    isType = true;
                                                  });
                                                });
                                            },
                                            child: Container(
                                              height: 45,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.25,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(16),
                                                    side: BorderSide(
                                                        color: Colors.black26)
                                                ),
                                                color: Colors.transparent,
                                                child: Center(child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["typeofpokemon"][0],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                  ),)),
                                              ),
                                            ),
                                          ),
                                          Data.poke["pokemon"][widget
                                              .inx]["typeofpokemon"].length > 1
                                              ?
                                          GestureDetector(
                                            onTap: () {
                                                isType == false ?
                                                Future.delayed(Duration(milliseconds: 800), () {
                                                  setState(() {
                                                    click =
                                                    Data.poke["pokemon"][widget
                                                        .inx]["typeofpokemon"][1];
                                                  });
                                                }) : setState(() {
                                                  click =
                                                  Data.poke["pokemon"][widget
                                                      .inx]["typeofpokemon"][1];
                                                });
                                                Future.delayed(Duration(milliseconds: 100), () {
                                                  setState(() {
                                                    isType = true;
                                                  });
                                                });
                                            },
                                            child: Container(
                                              height: 45,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.25,
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(16),
                                                    side: BorderSide(
                                                        color: Colors.black26)
                                                ),
                                                color: Colors.transparent,
                                                child: Center(child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["typeofpokemon"][1],
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                  ),)),
                                              ),
                                            ),
                                          )
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.35,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.4,
                                    child: Card(
                                      margin: EdgeInsets.all(0),
                                      color: Colors.white.withOpacity(0.9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(90),
                                          bottomLeft: Radius.circular(90),
                                          topRight: Radius.circular(28),
                                          bottomRight: Radius.circular(28),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.06,
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.04,
                                    child: Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.33,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.33,
                                      child: CachedNetworkImage(
                                        imageUrl: Data.poke["pokemon"][widget
                                            .inx]["imageurl"],
                                        cacheKey: Data.poke["pokemon"][widget
                                            .inx]["imageurl"],
                                        fit: BoxFit.contain,
                                        filterQuality: FilterQuality.high,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      Expanded(flex: 1,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Container(
                            // height: MediaQuery.of(context).size.height*0.7,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              children: [
                                Text("Abilities",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6),
                                  ),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    height: 170,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.96,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          Data.poke["pokemon"][widget
                                              .inx]["abilities"].isEmpty ?
                                          Container(height: 0, width: 0,) :
                                          Data.poke["pokemon"][widget
                                              .inx]["abilities"].length == 1 ?
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10),
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.85,
                                              decoration: BoxDecoration(
                                                color: mainColor,
                                                borderRadius: BorderRadius
                                                    .circular(12),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["abilities"][0],
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ) : Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10),
                                            child: Container(
                                              height: 40,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.85,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                    ),
                                                    child: Center(
                                                      child: Text(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["abilities"][0],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius: BorderRadius
                                                          .circular(12),
                                                    ),
                                                    child: Center(
                                                      child: Text(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["abilities"][1],
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight
                                                              .w400,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 25, right: 25),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(15),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["xdescription"] ==
                                                      "" ? "" :
                                                  Data.poke["pokemon"][widget
                                                      .inx]["xdescription"],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      fontSize: 15,
                                                      fontWeight: FontWeight
                                                          .w600
                                                  ),),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                                Text("Stats",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6),
                                  ),),
                                SizedBox(height: 8,),
                                Container(
                                  height: 400,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.96,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("HP",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["hp"] * MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["hp"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Attack",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["attack"] * MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["attack"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Defence",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["defense"] * MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["defense"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Sp. Attack",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["special_attack"] *
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["special_attack"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Sp. Defense",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["special_defense"] *
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["special_defense"]
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.3,
                                              decoration: BoxDecoration(
                                                color: thickColor,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text("Speed",
                                                  style: TextStyle(
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.75),
                                                  ),),
                                              ),
                                            ),
                                            AnimatedContainer(
                                              duration: duration,
                                              curve: curve,
                                              height: 35,
                                              alignment: Alignment.centerRight,
                                              width: max == 20 ? 40 :
                                              (Data.poke["pokemon"][widget
                                                  .inx]["speed"] * MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.55) / max,
                                              decoration: BoxDecoration(
                                                color: mainColor.withOpacity(
                                                    0.85),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(
                                                      10),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["speed"].toString(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                  ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.96,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: [
                                            Text("TOTAL ",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black.withOpacity(
                                                    0.6),
                                              ),),
                                            Text(total.toString(),
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: thickColor,
                                              ),),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text("Weakness",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.6),
                                  ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0, left: 5),
                                      width: 50,
                                      height: Data.poke["pokemon"][widget
                                          .inx]["weaknesses"].length > 2
                                          ? 140 : 90,
                                      child: Text("{",
                                        style: TextStyle(
                                          fontSize: Data.poke["pokemon"][widget
                                              .inx]["weaknesses"].length > 2
                                              ? 120 : 70,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 0, top: 0),
                                      height: Data.poke["pokemon"][widget
                                          .inx]["weaknesses"].length > 2
                                          ? 135 : 100,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.7,
                                      child: GridView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: BouncingScrollPhysics(),
                                        padding: const EdgeInsets.all(10),
                                        itemCount: Data.poke["pokemon"][widget
                                            .inx]["weaknesses"].length,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            childAspectRatio: 2.4,
                                            mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              isType == false ?
                                              Future.delayed(Duration(milliseconds: 800), () {
                                                setState(() {
                                                  click =
                                                  Data.poke["pokemon"][widget
                                                      .inx]["weaknesses"][index];
                                                });
                                              }) : setState(() {
                                                click =
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index];
                                              });
                                                Future.delayed(Duration(milliseconds: 100), () {
                                                  setState(() {
                                                    isType = true;
                                                  });
                                                });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Electric" ? Colors
                                                    .yellowAccent[200] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Fighting" ? Colors
                                                    .blueGrey[200] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Grass" ? Colors
                                                    .greenAccent[400] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Water" ? Colors.blue[400] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Poison" ? Colors
                                                    .purpleAccent[200] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Rock" ? Colors.grey[400] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Ghost" ? Colors
                                                    .deepPurple[400] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Psychic" ? Colors
                                                    .deepPurpleAccent[200] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Fire" ? Colors
                                                    .orangeAccent[200] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Ground"
                                                    ? Colors.brown[400]
                                                    :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Bug" ? Colors
                                                    .greenAccent[400] :
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index] ==
                                                    "Dark" ? Colors.grey[800] :
                                                Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(15),
                                              ),
                                              child: Center(child: Text(
                                                Data.poke["pokemon"][widget
                                                    .inx]["weaknesses"][index],
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0, right: 5),
                                      width: 50,
                                      alignment: Alignment.topRight,
                                      height: Data.poke["pokemon"][widget
                                          .inx]["weaknesses"].length > 2
                                          ? 140 : 90,
                                      child: Text("}",
                                        style: TextStyle(
                                          fontSize: Data.poke["pokemon"][widget
                                              .inx]["weaknesses"].length > 2
                                              ? 120 : 70,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),),
                                  ],
                                ),
                                checkForAd(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context, PageTransition(
                                            child: InfoScreen(
                                              appBar: true,
                                              inx: int.parse(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["evolutions"][0]
                                                      .substring(1)) - 1,
                                            ),
                                            duration: Duration(
                                                milliseconds: 500),
                                            curve: Curves.easeInOut,
                                            type: PageTransitionType
                                                .rightToLeft,
                                          ));
                                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                                          //   return InfoScreen(
                                          //     appBar: true,
                                          //     inx: int.parse(Data.poke["pokemon"][widget.inx]["evolutions"][0].substring(1)) -1,
                                          //   );
                                          // }));
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.23,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.22,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center,
                                            children: [
                                              SizedBox(height: 20,),
                                              Container(
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.15,
                                                child: CachedNetworkImage(
                                                  imageUrl: Data
                                                      .poke["pokemon"][
                                                  int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][0]
                                                      .substring(1)) - 1]
                                                  ["imageurl"],
                                                  cacheKey: Data
                                                      .poke["pokemon"][
                                                  int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][0]
                                                      .substring(1)) - 1]
                                                  ["imageurl"],
                                                  fit: BoxFit.contain,
                                                  filterQuality: FilterQuality
                                                      .high,
                                                  errorWidget: (context, url,
                                                      error) =>
                                                      Icon(Icons.error),
                                                ),
                                              ),
                                              SizedBox(height: 20,),
                                              Text(Data.poke["pokemon"][
                                              int.parse(
                                                  Data.poke["pokemon"][widget
                                                      .inx]["evolutions"][0]
                                                      .substring(1)) - 1]
                                              ["name"],
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.8)),),
                                              SizedBox(height: 10,),
                                              Text(Data.poke["pokemon"][widget
                                                  .inx]["evolutions"][0]
                                                  .substring(1),
                                                style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.8)),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Data.poke["pokemon"][widget
                                        .inx]["evolutions"].length >= 2 ?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(">", style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black.withOpacity(
                                                  0.7)),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context, PageTransition(
                                                child: InfoScreen(
                                                  appBar: true,
                                                  inx: int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][1]
                                                      .substring(1)) - 1,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                                type: PageTransitionType
                                                    .rightToLeft,
                                              ));
                                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                                              //   return InfoScreen(
                                              //     appBar: true,
                                              //     inx: int.parse(Data.poke["pokemon"][widget.inx]["evolutions"][1].substring(1)) -1,
                                              //   );
                                              // }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.23,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.22,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(20),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.15,
                                                    child: CachedNetworkImage(
                                                      imageUrl: Data
                                                          .poke["pokemon"][
                                                      int.parse(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["evolutions"][1]
                                                          .substring(1)) - 1]
                                                      ["imageurl"],
                                                      cacheKey: Data
                                                          .poke["pokemon"][
                                                      int.parse(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["evolutions"][1]
                                                          .substring(1)) - 1]
                                                      ["imageurl"],
                                                      fit: BoxFit.contain,
                                                      filterQuality: FilterQuality
                                                          .high,
                                                      errorWidget: (context,
                                                          url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Text(Data.poke["pokemon"][
                                                  int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][1]
                                                      .substring(1)) - 1]
                                                  ["name"],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.8)),),
                                                  SizedBox(height: 10,),
                                                  Text(
                                                    Data.poke["pokemon"][widget
                                                        .inx]["evolutions"][1]
                                                        .substring(1),
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.8)),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) : Container(height: 0, width: 0,),
                                    Data.poke["pokemon"][widget
                                        .inx]["evolutions"].length == 3 ?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(">", style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.black.withOpacity(
                                                  0.7)),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context, PageTransition(
                                                child: InfoScreen(
                                                  appBar: true,
                                                  inx: int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][2]
                                                      .substring(1)) - 1,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeInOut,
                                                type: PageTransitionType
                                                    .rightToLeft,
                                              ));
                                              // Navigator.push(context, MaterialPageRoute(builder: (context){
                                              //   return InfoScreen(
                                              //     appBar: true,
                                              //     inx: int.parse(Data.poke["pokemon"][widget.inx]["evolutions"][2].substring(1)) -1,
                                              //   );
                                              // }));
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height * 0.23,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.22,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius
                                                    .circular(20),
                                              ),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  SizedBox(height: 20,),
                                                  Container(
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.15,
                                                    child: CachedNetworkImage(
                                                      imageUrl: Data
                                                          .poke["pokemon"][
                                                      int.parse(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["evolutions"][2]
                                                          .substring(1)) - 1]
                                                      ["imageurl"],
                                                      cacheKey: Data
                                                          .poke["pokemon"][
                                                      int.parse(Data
                                                          .poke["pokemon"][widget
                                                          .inx]["evolutions"][2]
                                                          .substring(1)) - 1]
                                                      ["imageurl"],
                                                      fit: BoxFit.contain,
                                                      filterQuality: FilterQuality
                                                          .high,
                                                      errorWidget: (context,
                                                          url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Text(Data.poke["pokemon"][
                                                  int.parse(Data
                                                      .poke["pokemon"][widget
                                                      .inx]["evolutions"][2]
                                                      .substring(1)) - 1]
                                                  ["name"],
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.8)),),
                                                  SizedBox(height: 10,),
                                                  Text(
                                                    Data.poke["pokemon"][widget
                                                        .inx]["evolutions"][2]
                                                        .substring(1),
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(
                                                            0.8)),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ) : Container(height: 0, width: 0,),
                                  ],
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: isType == false ?
              -MediaQuery
                  .of(context)
                  .size
                  .height * 0.5 : 0,
              curve: Curves.easeInOut,
              duration: Duration(milliseconds: 400),
              child: WillPopScope(
                onWillPop: onWillPop,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.45,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    color: thickColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 45,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.25,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(color: Colors.black38)
                                  ),
                                  color: Colors.black12,
                                  child: Center(child: Text(click,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white.withOpacity(0.9),
                                    ),)),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text("TOTAL ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(
                                      0.6),
                                ),),
                              Text(find(click).length.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),),
                            ],
                          ),
                          isType == false || click == "" ?
                          CircularProgressIndicator() :
                          typePokemon(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  int inx = 0;
  bool once = false;

  List<dynamic> find(String s) {
    List n = [];
    for (int i = 0; i < 809; i++) {
      if (Data.poke["pokemon"][i]["typeofpokemon"][0].startsWith(s)) {
        n.add(Data.poke["pokemon"][i]);
        if (once == false) {
          inx = i;
          once = true;
        }
      }
    }
    return n;
  }

  typePokemon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: find(click).isEmpty ? 10 : find(click).length,
        itemBuilder: (BuildContext context, int index) {
          final suggestionList = find(click).toList();
          return Container(
            height: 100,
            width: double.infinity,
            color: Colors.transparent,
            child: GestureDetector(
              // onTapDown: (details) {
              //   print(details.localPosition);
              // },
              // onTapUp: (details) {
              //   print(details.localPosition);
              // },
              onTap: () {
                Navigator.push(context, PageTransition(
                  child: InfoScreen(
                    appBar: true,
                    inx: int.parse(
                        suggestionList[index]["id"].substring(1)) - 1,
                  ),
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  type: PageTransitionType.rightToLeft,
                ));
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                margin: EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 8),
                color:
                click == "Electric" ? Colors.yellowAccent :
                click == "Fighting" ? Colors.blueGrey.withOpacity(0.8) :
                click == "Grass" ? Colors.greenAccent :
                click == "Water" ? Colors.blueAccent :
                click == "Poison" ? Colors.purpleAccent :
                click == "Rock" ? Colors.grey :
                click == "Ghost" ? Colors.deepPurple[300] :
                click == "Psychic" ? Colors.deepPurpleAccent :
                click == "Fire" ? Colors.orangeAccent :
                click == "Ground" ? Colors.brown.withOpacity(0.8) :
                click == "Bug" ? Colors.greenAccent[700] :
                click == "Dark" ? Colors.grey :
                Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      //The Faded line in middle of a card
                      top: 45,
                      right: 91.7,
                      child: Container(
                        height: 10,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0, 1],
                              colors: [
                                Colors.black.withOpacity(0.15),
                                Colors.transparent,
                              ]
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      //Background Faded Circle of image
                      top: 8,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.15),
                        radius: 38,
                      ),
                    ),
                    Positioned(
                      // image of pokemon
                      top: 19,
                      right: 27,
                      child: CircleAvatar(
                        child: CachedNetworkImage(
                          imageUrl: suggestionList[index]["imageurl"],
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        backgroundColor: Colors.black26,
                        radius: 30,
                      ),
                    ),
                    Positioned(
                      //name of pokemon
                      top: 30,
                      left: 15,
                      child: Text(suggestionList[index]["name"],
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Positioned(
                      //type of pokemon
                      top: 33,
                      left: 140,
                      child: Text(suggestionList[index]["typeofpokemon"][0],
                          style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}