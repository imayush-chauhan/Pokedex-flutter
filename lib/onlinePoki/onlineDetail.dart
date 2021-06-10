import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlineDetail extends StatefulWidget {
  final dynamic file;
  final bool appBar;
  final int inx;
  OnlineDetail({
     required this.file,
    required this.inx,
    required this.appBar});

  @override
  _OnlineDetailState createState() => _OnlineDetailState();
}

class _OnlineDetailState extends State<OnlineDetail> {

  int max = 20;

  setFav() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    setState(() {
      myPrefs.setStringList("fav", Data.fav).then((value) {
        getFav();
      });
    });
  }

  getFav() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if(myPrefs.getStringList("fav") != null) {
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
    // print(widget.file[widget.inx]["type"].length);
    if(widget.file[widget.inx]["type"][0] == "Electric"){
      mainColor = Colors.yellowAccent.shade200;
      thickColor = Colors.yellowAccent.shade700;
    }else if(widget.file[widget.inx]["type"][0] == "Fire"){
      mainColor = Colors.orangeAccent.shade200;
      thickColor = Colors.orangeAccent.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Grass"){
      mainColor = Colors.greenAccent.shade200;
      thickColor = Colors.greenAccent.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Water"){
      mainColor = Colors.blueAccent.shade200;
      thickColor = Colors.blueAccent.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Poison"){
      mainColor = Colors.purpleAccent.shade200;
      thickColor = Colors.purpleAccent.shade700;
    }else if(widget.file[widget.inx]["type"][0] == "Rock"){
      mainColor = Colors.grey.shade200;
      thickColor = Colors.grey.shade500;
    }else if(widget.file[widget.inx]["type"][0] == "Ghost"){
      mainColor = Colors.deepPurple.shade300;
      thickColor = Colors.deepPurple.shade300;
    }else if(widget.file[widget.inx]["type"][0] == "Psychic"){
      mainColor = Colors.deepPurpleAccent.shade200;
      thickColor = Colors.deepPurpleAccent.shade700;
    }else if(widget.file[widget.inx]["type"][0] == "Fighting"){
      mainColor = Colors.redAccent.shade200;
      thickColor = Colors.redAccent.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Ground"){
      mainColor = Colors.brown.shade200;
      thickColor = Colors.brown.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Bug"){
      mainColor = Colors.greenAccent.shade200;
      thickColor = Colors.greenAccent.shade400;
    }else if(widget.file[widget.inx]["type"][0] == "Dark"){
      mainColor = Colors.grey.shade200;
      mainColor = Colors.grey.shade500;
    }else{
      mainColor = Colors.white;
      thickColor = Colors.white70;
    }
    // prev_1 = widget.file[widget.inx]["prev_evolution"][0]["num"];
    // prev_2 = widget.file[widget.inx]["prev_evolution"][1]["num"];

    Future.delayed(Duration(milliseconds: 800),(){
      calculator();
    });
    // widget.file[widget.inx]["type"][0] == "Electric" ? mainColor = Colors.yellowAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Fire" ? mainColor = Colors.orangeAccent.shade200 :
    // widget.file[widget.inx]["type"][0] == "Grass" ? mainColor = Colors.greenAccent.shade200 :
    // widget.file[widget.inx]["type"][0] == "Water" ? mainColor = Colors.blueAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Poison" ? mainColor = Colors.purpleAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Rock" ? mainColor = Colors.grey.shade200:
    // widget.file[widget.inx]["type"][0] == "Ghost" ? mainColor = Colors.deepPurple.shade300:
    // widget.file[widget.inx]["type"][0] == "Psychic" ? mainColor = Colors.deepPurpleAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Fighting" ? mainColor = Colors.redAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Ground" ? mainColor = Colors.brown.shade200:
    // widget.file[widget.inx]["type"][0] == "Bug" ? mainColor = Colors.greenAccent.shade200:
    // widget.file[widget.inx]["type"][0] == "Dark" ? mainColor = Colors.grey.shade200 : Colors.white;
  }

  calculator(){
    setState(() {
      max = widget.file[widget.inx]["spdef"];
      if(widget.file[widget.inx]["spatk"] >= widget.file[widget.inx]["spdef"] &&
          widget.file[widget.inx]["spatk"] >= widget.file[widget.inx]["spe"] &&
          widget.file[widget.inx]["spatk"] >= widget.file[widget.inx]["hp"] &&
          widget.file[widget.inx]["spatk"] >= widget.file[widget.inx]["atk"] &&
          widget.file[widget.inx]["spatk"] >= widget.file[widget.inx]["def"]) {
        max = widget.file[widget.inx]["spatk"];
      }else if(widget.file[widget.inx]["spe"] >= widget.file[widget.inx]["spdef"] &&
          widget.file[widget.inx]["spe"] >= widget.file[widget.inx]["spatk"] &&
          widget.file[widget.inx]["spe"] >= widget.file[widget.inx]["hp"] &&
          widget.file[widget.inx]["spe"] >= widget.file[widget.inx]["atk"] &&
          widget.file[widget.inx]["spe"] >= widget.file[widget.inx]["def"]){
        max = widget.file[widget.inx]["spe"];
      }else if(widget.file[widget.inx]["hp"] >= widget.file[widget.inx]["spdef"] &&
          widget.file[widget.inx]["hp"] >= widget.file[widget.inx]["spatk"] &&
          widget.file[widget.inx]["hp"] >= widget.file[widget.inx]["spe"] &&
          widget.file[widget.inx]["hp"] >= widget.file[widget.inx]["atk"] &&
          widget.file[widget.inx]["hp"] >= widget.file[widget.inx]["def"]){
        max = widget.file[widget.inx]["hp"];
      }else if(widget.file[widget.inx]["def"] >= widget.file[widget.inx]["spdef"] &&
          widget.file[widget.inx]["def"] >= widget.file[widget.inx]["spatk"] &&
          widget.file[widget.inx]["def"] >= widget.file[widget.inx]["hp"] &&
          widget.file[widget.inx]["def"] >= widget.file[widget.inx]["atk"] &&
          widget.file[widget.inx]["def"] >= widget.file[widget.inx]["spe"]){
        max = widget.file[widget.inx]["def"];
      }else if(widget.file[widget.inx]["atk"] >= widget.file[widget.inx]["spdef"] &&
          widget.file[widget.inx]["atk"] >= widget.file[widget.inx]["spatk"] &&
          widget.file[widget.inx]["atk"] >= widget.file[widget.inx]["spe"] &&
          widget.file[widget.inx]["atk"] >= widget.file[widget.inx]["hp"] &&
          widget.file[widget.inx]["atk"] >= widget.file[widget.inx]["def"]){
        max = widget.file[widget.inx]["atk"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.file == {} ? Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    ) : Scaffold(
      backgroundColor: mainColor,
      // widget.file[widget.inx]["type"][0] == "Electric" ? Colors.yellowAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Fire" ? Colors.orangeAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Grass" ? Colors.greenAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Water" ? Colors.blueAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Poison" ? Colors.purpleAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Rock" ? Colors.grey[200] :
      // widget.file[widget.inx]["type"][0] == "Ghost" ? Colors.deepPurple[300] :
      // widget.file[widget.inx]["type"][0] == "Psychic" ? Colors.deepPurpleAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Fighting" ? Colors.redAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Ground" ? Colors.brown[200] :
      // widget.file[widget.inx]["type"][0] == "Bug" ? Colors.greenAccent[200] :
      // widget.file[widget.inx]["type"][0] == "Dark" ? Colors.grey[200]:
      // Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5,),
            Container(
              height: MediaQuery.of(context).size.height*0.22,
              width: MediaQuery.of(context).size.width*0.98,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: Colors.black.withOpacity(0.2)),
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
                        width: MediaQuery.of(context).size.width*0.5,
                        height: MediaQuery.of(context).size.height*0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5,top: 10,bottom: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.file[widget.inx]["name"],
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.6),
                                    ),),
                                  Text("#"+widget.file[widget.inx]["num"],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.6)
                                    ),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(widget.file[widget.inx]["height"]+",",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.6),
                                        ),),
                                      SizedBox(width: 8,),
                                      Text(widget.file[widget.inx]["weight"],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(0.6)
                                        ),),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      if(Data.fav.contains(widget.file[widget.inx]["id"].toString())){
                                        setState(() {
                                          Data.fav.removeAt(
                                              Data.fav.indexOf(widget.file[widget.inx]["id"].toString()));
                                          setFav();
                                        });
                                      }else{
                                        setState(() {
                                          Data.fav.add(widget.file[widget.inx]["id"].toString());
                                          setFav();
                                        });
                                      }
                                    },
                                    child: Icon(Data.fav.contains(widget.file[widget.inx]["id"].toString()) ?
                                        Icons.star : Icons.star_border),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width*0.25,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.black26)
                                    ),
                                    color: Colors.transparent,
                                    child: Center(child: Text(widget.file[widget.inx]["type"][0],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.9),
                                      ),)),
                                  ),
                                ),
                                widget.file[widget.inx]["type"].length > 1 ?
                                Container(
                                  height: 45,
                                  width: MediaQuery.of(context).size.width*0.25,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(color: Colors.black26)
                                    ),
                                    color: Colors.transparent,
                                    child: Center(child: Text(widget.file[widget.inx]["type"][1],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.9),
                                      ),)),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*0.35,
                          width: MediaQuery.of(context).size.width*0.4,
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
                          top: -MediaQuery.of(context).size.height*0.06,
                          left: MediaQuery.of(context).size.width*0.04,
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.33,
                            width: MediaQuery.of(context).size.width*0.33,
                            child: CachedNetworkImage(
                              imageUrl: widget.file[widget.inx]["img"],
                              cacheKey: widget.file[widget.inx]["img"],
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              errorWidget: (context, url, error) => Icon(Icons.error),
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
                  width: MediaQuery.of(context).size.width,
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
                          height: 110,
                          width: MediaQuery.of(context).size.width*0.96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                widget.file[widget.inx]["ability2"] == "" ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.85,
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(widget.file[widget.inx]["ability1"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                    ),
                                  ),
                                  ),
                                ): Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.85,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width*0.4,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(widget.file[widget.inx]["ability1"],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width*0.4,
                                          decoration: BoxDecoration(
                                            color: mainColor,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Center(
                                            child: Text(widget.file[widget.inx]["ability2"],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
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
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.85,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: mainColor,width: 1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: MediaQuery.of(context).size.width*0.3,
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text("Hidden",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),),
                                            ),
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width*0.16,),
                                          Text(widget.file[widget.inx]["hiddenability"],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
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
                        width: MediaQuery.of(context).size.width*0.96,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("HP",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["hp"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["hp"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Attack",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["atk"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["atk"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Defence",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["def"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["def"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Sp. Attack",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["spatk"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["spatk"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Sp. Defence",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["spdef"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["spdef"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width*0.3,
                                    decoration: BoxDecoration(
                                      color: thickColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text("Speed",
                                        style: TextStyle(
                                          fontSize: 14.5,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(0.75),
                                        ),),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: duration,
                                    curve: curve,
                                    height: 35,
                                    alignment: Alignment.centerRight,
                                    width: max == 20 ? 40 :
                                    (widget.file[widget.inx]["spe"] * MediaQuery.of(context).size.width*0.55)/max,
                                    decoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.85),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text(widget.file[widget.inx]["spe"].toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.7),
                                        ),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: MediaQuery.of(context).size.width*0.96,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("TOTAL ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.6),
                                    ),),
                                  Text("${widget.file[widget.inx]["spe"]
                                      + widget.file[widget.inx]["hp"] +
                                      widget.file[widget.inx]["atk"] +
                                      widget.file[widget.inx]["def"] +
                                      widget.file[widget.inx]["spatk"] +
                                      widget.file[widget.inx]["spdef"]}",
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0,left: 5),
                            width: 50,
                            height: widget.file[widget.inx]["weaknesses"].length > 2
                                ? 140 : 90,
                            child: Text("{",
                              style: TextStyle(
                                fontSize: widget.file[widget.inx]["weaknesses"].length > 2
                                    ? 120 : 70,
                                color: Colors.black.withOpacity(0.7),
                              ),),),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 0,top: 0),
                            height: widget.file[widget.inx]["weaknesses"].length > 2
                                ? 135 : 100,
                            width: MediaQuery.of(context).size.width*0.7,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(10),
                              itemCount: widget.file[widget.inx]["weaknesses"].length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,childAspectRatio: 2.4,
                                  mainAxisSpacing: 10),
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                    widget.file[widget.inx]["weaknesses"][index] == "Electric" ? Colors.yellowAccent[200] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Fighting" ? Colors.blueGrey[200] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Grass" ? Colors.greenAccent[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Water" ? Colors.blue[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Poison" ? Colors.purpleAccent[200] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Rock" ? Colors.grey[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Ghost" ? Colors.deepPurple[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Psychic" ? Colors.deepPurpleAccent[200] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Fire" ? Colors.orangeAccent[200]:
                                    widget.file[widget.inx]["weaknesses"][index] == "Ground" ? Colors.brown[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Bug" ? Colors.greenAccent[400] :
                                    widget.file[widget.inx]["weaknesses"][index] == "Dark" ? Colors.grey[800]:
                                    Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(child: Text(widget.file[widget.inx]["weaknesses"][index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.7),
                                    ),)),
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0,right: 5),
                            width: 50,alignment: Alignment.topRight,
                            height: widget.file[widget.inx]["weaknesses"].length > 2
                                ? 140 : 90,
                            child: Text("}",
                              style: TextStyle(
                                fontSize: widget.file[widget.inx]["weaknesses"].length > 2
                                    ? 120 : 70,
                                color: Colors.black.withOpacity(0.7),
                              ),),),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.file[widget.inx]["prev_evolution"] != null ?
                          widget.file[widget.inx]["prev_evolution"].length >= 1?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return OnlineDetail(
                                        appBar: true,
                                        file: widget.file,
                                        inx: int.parse(widget.file[widget.inx]["prev_evolution"][0]["num"]) -1,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 170,
                                    width: MediaQuery.of(context).size.width*0.22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.15,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.file[
                                              int.parse(widget.file[widget.inx]["prev_evolution"][0]["num"]) -1]
                                            ["img"],
                                            cacheKey: widget.file[
                                            int.parse(widget.file[widget.inx]["prev_evolution"][0]["num"]) -1]
                                            ["img"],
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(widget.file[widget.inx]["prev_evolution"][0]["name"],
                                        style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                        SizedBox(height: 10,),
                                        Text(widget.file[widget.inx]["prev_evolution"][0]["num"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text("<",style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.7)),),
                              ),
                            ],
                          ) : Container(height: 0,width: 0,) : Container(height: 0,width: 0,),
                          widget.file[widget.inx]["prev_evolution"] != null ?
                          widget.file[widget.inx]["prev_evolution"].length == 2 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return OnlineDetail(
                                        appBar: true,
                                        file: widget.file,
                                        inx: int.parse(widget.file[widget.inx]["prev_evolution"][1]["num"]) -1,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 170,
                                    width: MediaQuery.of(context).size.width*0.22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.15,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.file[
                                              int.parse(widget.file[widget.inx]["prev_evolution"][1]["num"]) -1]
                                            ["img"],
                                            cacheKey: widget.file[
                                              int.parse(widget.file[widget.inx]["prev_evolution"][1]["num"]) -1]
                                            ["img"],
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(widget.file[widget.inx]["prev_evolution"][1]["name"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                        SizedBox(height: 10,),
                                        Text(widget.file[widget.inx]["prev_evolution"][1]["num"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text("<",style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.7)),),
                              ),
                            ],
                          ) : Container(height: 0,width: 0,) : Container(height: 0,width: 0,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return OnlineDetail(
                                    appBar: true,
                                    file: widget.file,
                                    inx: widget.inx,
                                  );
                                }));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 170,
                                width: MediaQuery.of(context).size.width*0.22,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      child: CachedNetworkImage(
                                        imageUrl: widget.file[widget.inx]["img"],
                                        cacheKey: widget.file[widget.inx]["img"],
                                        fit: BoxFit.contain,
                                        filterQuality: FilterQuality.high,
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(widget.file[widget.inx]["name"],
                                      style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                    SizedBox(height: 10,),
                                    Text(widget.file[widget.inx]["num"],
                                      style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          widget.file[widget.inx]["next_evolution"] != null ?
                          widget.file[widget.inx]["next_evolution"].length >= 1?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(">",style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.7)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return OnlineDetail(
                                        appBar: true,
                                        file: widget.file,
                                        inx: int.parse(widget.file[widget.inx]["next_evolution"][0]["num"]) -1,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 170,
                                    width: MediaQuery.of(context).size.width*0.22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.15,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.file[
                                            int.parse(widget.file[widget.inx]["next_evolution"][0]["num"]) -1]
                                            ["img"],
                                            cacheKey: widget.file[
                                            int.parse(widget.file[widget.inx]["next_evolution"][0]["num"]) -1]
                                            ["img"],
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(widget.file[widget.inx]["next_evolution"][0]["name"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                        SizedBox(height: 10,),
                                        Text(widget.file[widget.inx]["next_evolution"][0]["num"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ) : Container(height: 0,width: 0,) : Container(height: 0,width: 0,),
                          widget.file[widget.inx]["next_evolution"] != null ?
                          widget.file[widget.inx]["next_evolution"].length == 2 ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(">",style: TextStyle(fontSize: 25,color: Colors.black.withOpacity(0.7)),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return OnlineDetail(
                                        appBar: true,
                                        file: widget.file,
                                        inx: int.parse(widget.file[widget.inx]["next_evolution"][1]["num"]) -1,
                                      );
                                    }));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 170,
                                    width: MediaQuery.of(context).size.width*0.22,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20,),
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.15,
                                          child: CachedNetworkImage(
                                            imageUrl: widget.file[
                                            int.parse(widget.file[widget.inx]["next_evolution"][1]["num"]) -1]
                                            ["img"],
                                            cacheKey: widget.file[
                                            int.parse(widget.file[widget.inx]["next_evolution"][1]["num"]) -1]
                                            ["img"],
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(widget.file[widget.inx]["next_evolution"][1]["name"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                        SizedBox(height: 10,),
                                        Text(widget.file[widget.inx]["next_evolution"][1]["num"],
                                          style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ) : Container(height: 0,width: 0,) : Container(height: 0,width: 0,),
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
    );
  }
}