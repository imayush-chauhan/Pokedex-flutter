import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'favPoke.dart';
import 'onlineDetail.dart';


class PokeOnline extends StatefulWidget {
  @override
  _PokeOnlineState createState() => _PokeOnlineState();
}

class _PokeOnlineState extends State<PokeOnline> {

  // var url = "https://raw.githubusercontent.com/imayush-chauhan/PokeInfo/main/PokeData.json";
  //
  // PokeHub pokeHub;

  String click = "";
  bool onClick = false;
  int num = 3;
  bool isCollapsed = false;
  int slideNumber = 10;

  List<String> names = [
    "All",
    "Electric",
    "Fire",
    "Water",
    "Grass",
    "Bug",
    "Poison",
    "Fighting",
    "Normal",
    "Dark",
    "Ghost",
    "Psychic",
    "Rock",
    "Ground",
  ];

  @override
  void initState() {
    super.initState();
    getFav();
    getUsersData();
  }

  int inx = 0;
  bool once = false;

  getUsersData() async{
    var response =
    await http.get(
        Uri.https(
            "raw.githubusercontent.com",
            "imayush-chauhan/PokeInfo/main/PokeData.json"));
    setState(() {
      Data.poke = jsonDecode(response.body);
    });
  }

  getFav() async{
    print("hmmmmmmmkmkn");
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    print("hmmmmmmm");
    if(myPrefs.getStringList("fav") != null) {
      print("hooooooo");
      setState(() {
          Data.fav = myPrefs.getStringList("fav") as List<String>;
      });
    }
  }

  // fetchData() async{
  //   var response = await http.get(url);
  //   var decode = jsonDecode(response.body);
  //   setState(() {
  //     pokeHub = PokeHub.fromJson(decode);
  //   });
  //
  // }

  List<dynamic> find(String s){
    List n = [];
    for(int i  = 0; i < 151; i++){
      if(Data.poke["pokemon"][i]["type"][0].startsWith(s)){
        n.add(Data.poke["pokemon"][i]);
        if(once == false){
          inx = i;
          once = true;
        }
      }
    }
    return n;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          isCollapsed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.greenAccent,
                Color(0xff151515),
              ]
          ),
        ),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("PokeDex",style: TextStyle(color: Colors.black),),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  onPressed: (){
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                  icon: Icon(Icons.dehaze,
                    color: Colors.black,),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: (){
                      setState(() {
                        isCollapsed = false;
                      });
                      showSearch(context: context, delegate: DataSearch(file: Data.poke["pokemon"]));
                    },)
                ],
              ),
              body: Data.poke.isEmpty ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Column(
                children: [
                  Container(
                    height: 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: names.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context,int index) {
                        return GestureDetector(
                          onTap: (){
                            if(index == 0){
                              setState(() {
                                onClick = false;
                                isCollapsed = false;
                              });
                            }else{
                              setState(() {
                                onClick = true;
                                click = names[index];
                                isCollapsed = false;
                              });
                            }
                          },
                          child: Container(
                            width: 110,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color:
                              names[index] == "All" ? Colors.white :
                              names[index] == "Electric" ? Colors.yellowAccent :
                              names[index] == "Fighting" ? Colors.blueGrey.withOpacity(0.8) :
                              names[index] == "Grass" ? Colors.greenAccent :
                              names[index] == "Water" ? Colors.blueAccent :
                              names[index] == "Poison" ? Colors.purpleAccent :
                              names[index] == "Rock" ? Colors.grey :
                              names[index] == "Ghost" ? Colors.deepPurple[300] :
                              names[index] == "Psychic" ? Colors.deepPurpleAccent :
                              names[index] == "Fire" ? Colors.orangeAccent:
                              names[index] == "Ground" ? Colors.brown.withOpacity(0.8) :
                              names[index] == "Bug" ? Colors.greenAccent[700] :
                              names[index] == "Dark" ? Colors.grey:
                              Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Center(child: Text(
                                  names[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  onClick == false ? Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: Data.poke["pokemon"].length,
                          itemBuilder: (BuildContext  context, int index){
                            return Container(
                              height: 100,
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isCollapsed = false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return OnlineDetail(
                                      appBar: true,
                                      file: Data.poke["pokemon"],
                                      inx: index,
                                    );
                                  }));
                                  },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                                  color:
                                  Data.poke["pokemon"][index]["type"][0] == "Electric" ? Colors.yellowAccent :
                                  Data.poke["pokemon"][index]["type"][0] == "Fighting" ? Colors.blueGrey.withOpacity(0.8) :
                                  Data.poke["pokemon"][index]["type"][0] == "Grass" ? Colors.greenAccent :
                                  Data.poke["pokemon"][index]["type"][0] == "Water" ? Colors.blueAccent :
                                  Data.poke["pokemon"][index]["type"][0] == "Poison" ? Colors.purpleAccent :
                                  Data.poke["pokemon"][index]["type"][0] == "Rock" ? Colors.grey :
                                  Data.poke["pokemon"][index]["type"][0] == "Ghost" ? Colors.deepPurple[300] :
                                  Data.poke["pokemon"][index]["type"][0] == "Psychic" ? Colors.deepPurpleAccent :
                                  Data.poke["pokemon"][index]["type"][0] == "Fire" ? Colors.orangeAccent:
                                  Data.poke["pokemon"][index]["type"][0] == "Ground" ? Colors.brown.withOpacity(0.8) :
                                  Data.poke["pokemon"][index]["type"][0] == "Bug" ? Colors.greenAccent[700] :
                                  Data.poke["pokemon"][index]["type"][0] == "Dark" ? Colors.grey:
                                  Colors.white,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        //The Faded line in middle of a card
                                        top: MediaQuery.of(context).size.height*0.056,
                                        left: MediaQuery.of(context).size.width*0.1905,
                                        // right: 91.7,
                                        child: Container(
                                          height: 10,
                                          width: MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerRight,
                                                  end: Alignment.centerLeft,
                                                  stops: [0,1],
                                                  colors: [
                                                    Colors.black.withOpacity(0.15),
                                                    Colors.transparent,
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        //Background Faded Circle of image
                                        top: MediaQuery.of(context).size.height*0.009,
                                        left: MediaQuery.of(context).size.width*0.69,
                                        // right: 16,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black.withOpacity(0.15),
                                          radius: 38,
                                        ),
                                      ),
                                      Positioned(
                                        // image of pokemon
                                        top: MediaQuery.of(context).size.height*0.025,
                                        left: MediaQuery.of(context).size.width*0.705,
                                        // right: 27,
                                        child: CircleAvatar(
                                          child: CachedNetworkImage(
                                            imageUrl: Data.poke["pokemon"][index]["img"],
                                            cacheKey: Data.poke["pokemon"][index]["img"],
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                          backgroundColor: Colors.black26,
                                          radius: 30,
                                        ),
                                      ),
                                      Positioned(
                                        //name of pokemon
                                        top: MediaQuery.of(context).size.height*0.04,
                                        left: 15,
                                        child: Text(Data.poke["pokemon"][index]["name"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      Positioned(
                                        //type of pokemon
                                        top: MediaQuery.of(context).size.height*0.04,
                                        left: 140,
                                        child: Text(Data.poke["pokemon"][index]["type"][0],
                                            style: TextStyle(
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
                      ),
                    ),
                  ) : Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: find(click).isEmpty ? 10 : find(click).length,
                          itemBuilder: (BuildContext context, int index){
                            final suggestionList =  find(click).toList();
                            return Container(
                              height: 100,
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isCollapsed = false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return OnlineDetail(
                                      appBar: true,
                                      file: Data.poke["pokemon"],
                                      inx: suggestionList[index]["id"] -1,
                                    );
                                  }));
                                },
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  margin: EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
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
                                   click == "Dark" ? Colors.grey:
                                  Colors.white,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        //The Faded line in middle of a card
                                        top: MediaQuery.of(context).size.height*0.056,
                                        right: 91.7,
                                        child: Container(
                                          height: 10,
                                          width: MediaQuery.of(context).size.width*0.5,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerRight,
                                                  end: Alignment.centerLeft,
                                                  stops: [0,1],
                                                  colors : [
                                                    Colors.black.withOpacity(0.15),
                                                    Colors.transparent,
                                                  ]
                                              ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        //Background Faded Circle of image
                                        top: MediaQuery.of(context).size.height*0.009,
                                        right: 16,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.black.withOpacity(0.15),
                                          radius: 38,
                                        ),
                                      ),
                                      Positioned(
                                        // image of pokemon
                                        top: MediaQuery.of(context).size.height*0.025,
                                        right: 27,
                                        child: CircleAvatar(
                                          child: CachedNetworkImage(
                                            imageUrl: suggestionList[index]["img"],
                                            fit: BoxFit.cover,
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                          backgroundColor: Colors.black26,
                                          radius: 30,
                                        ),
                                      ),
                                      Positioned(
                                        //name of pokemon
                                        top: MediaQuery.of(context).size.height*0.04,
                                        left: 15,
                                        child: Text(suggestionList[index]["name"],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Positioned(
                                        //type of pokemon
                                        top: MediaQuery.of(context).size.height*0.04,
                                        left: 140,
                                        child: Text(suggestionList[index]["type"][0],
                                            style: TextStyle(
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
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AnimatedPositioned(
              duration: Duration(milliseconds: 600),
              top: isCollapsed == false ? MediaQuery.of(context).size.height*0.6 :
              MediaQuery.of(context).size.height*0.1,
              left: isCollapsed == false ? -MediaQuery.of(context).size.width*0.5 : 0,
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width*0.5,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    isCollapsed = true;
                  });
                },
                child: Card(
                  margin: EdgeInsets.all(0),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width*0.5,
                          child: Card(
                            margin: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                            ),
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "PokeDex",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              click = "";
                              onClick = false;
                              isCollapsed = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.favorite,
                                size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("All Pokemon",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              click = "Fire";
                              onClick = true;
                              isCollapsed = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.whatshot,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Fire",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              click = "Water";
                              onClick = true;
                              isCollapsed = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.ac_unit,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Water",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 250,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              click = "Rock";
                              onClick = true;
                              isCollapsed = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.radio_button_checked,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Rock",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 300,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              click = "Electric";
                              onClick = true;
                              isCollapsed = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.flash_on,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Electric",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 350,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              isCollapsed = false;
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return FavPoki();
                              }));
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Icon(Icons.favorite,
                                  size: 22,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Favorite",
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
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

class DataSearch extends SearchDelegate<String> {
  var file;
  DataSearch({required this.file});
  // String n;
  String n = "Loading...";
  bool yes = false;
  int inx = 0;

  final recent= [
    "Pikachu",
    "Charizard",
    "Bulbasaur",
    "Squirtle",
    "Mewtwo",
  ];
  final empty= [
    "No Pokemon find",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for app bar
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = "";
        n = "";
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if(yes == false){
      query = n;
    }
    for(int i = 0; i < 150; i++){
      if(query == file[i]["name"]){
        inx = i;
        break;
      }
    }
    return OnlineDetail(
      appBar: false,
      inx: inx,
      file: file,
    );
  }

  List<dynamic> find(String s){
    s.length >= 1 ? s = s.substring(0,1).toUpperCase() + s.substring(1,s.length) :
    s = s.substring(0,1).toUpperCase();
    List n = [];
    for(int i  = 0; i < 150; i++){
      if(file[i]["name"].startsWith(s)){
        n.add(file[i]["name"]);
      }
    }
    return n;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty ?
    recent : find(query).toList().isEmpty ? recent : find(query).toList();

    return ListView.builder(
      itemBuilder: (context,index){
        yes = false;
        n = suggestionList[0];
        return ListTile(
          onTap: (){
            yes = true;
            query = suggestionList[index];
            showResults(context);
          },
          leading: Icon(Icons.blur_on),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0,query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: TextStyle(
                          color: Colors.grey
                      )
                  )
                ]
            ),
          ),
        );
      },
      itemCount: suggestionList.length,
    );
  }
}
