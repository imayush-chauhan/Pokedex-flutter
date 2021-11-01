import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';
import 'package:pokidexayu/pokemon/favPoke.dart';
import 'package:pokidexayu/pokemon/infoScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pokemon extends StatefulWidget {
  @override
  _PokemonState createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> with SingleTickerProviderStateMixin {

  ScrollController _controller = new ScrollController();
  AnimationController? controller;


  String click = "All";
  bool onClick = false;
  bool isGen = false;
  int genIndex = 0;
  int num = 3;
  bool isCollapsed = false;
  int slideNumber = 10;
  double itemCount = 80;

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

  Map gen = {
    "all": [
      "All",
      "Gen 1",
      "Gen 2",
      "Gen 3",
      "Gen 4",
      "Gen 5",
      "Gen 6",
      "Gen 7",
    ],
    "Gen 1": {
      "length": 151,
      "from": 1,
      "to": 151,
    },
    "Gen 2": {
      "length": 100,
      "from": 152,
      "to": 251,
    },
    "Gen 3": {
      "length": 135,
      "from": 252,
      "to": 386,
    },
    "Gen 4": {
      "length": 107,
      "from": 387,
      "to": 493,
    },
    "Gen 5": {
      "length": 156,
      "from": 494,
      "to": 649,
    },
    "Gen 6": {
      "length": 72,
      "from": 650,
      "to": 721,
    },
    "Gen 7": {
      "length": 88,
      "from": 722,
      "to": 809,
    },
  };

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getFav();
    getUsersData();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
  }


  iconAnimation() {
    if (isCollapsed == false) {
      controller!.reverse();
    } else {
      controller!.forward();
    }
  }

  _scrollListener() {
    if (_controller.offset / 100 > 40) {
      setState(() {
        itemCount = _controller.offset / 100 + 50;
      });
    }

    // if (_controller.offset >= _controller.position.maxScrollExtent*0.98) {
    //
    // }
    // if (_controller.offset <= _controller.position.minScrollExtent &&
    //     !_controller.position.outOfRange) {
    //   setState(() {
    //     print("reach the top");
    //   });
    // }
  }

  int inx = 0;
  bool once = false;

  getUsersData() async {
    var response =
    await http.get(
        Uri.https(
            "raw.githubusercontent.com",
            "imayush-chauhan/PokeInfo/main/pokemon.json"));
    setState(() {
      Data.poke = jsonDecode(response.body);
    });
  }

  getFav() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    if (myPrefs.getStringList("fav") != null) {
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

  Widget allPokemon(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: _controller,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: itemCount.toInt() < 700 ?
            itemCount.toInt() : Data.poke["pokemon"].length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isCollapsed = false;
                    });
                    Future.delayed(Duration(milliseconds: 100), () {
                      Navigator.push(context, PageTransition(
                        child: InfoScreen(
                          appBar: true,
                          inx: index,
                        ),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.rightToLeft,
                      ));
                    });
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    color:
                    Data.poke["pokemon"][index]["typeofpokemon"][0] ==
                        "Electric" ? Colors.yellowAccent :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] ==
                        "Fighting" ? Colors.blueGrey.withOpacity(0.8) :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Grass"
                        ? Colors.greenAccent
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Water"
                        ? Colors.blueAccent
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Poison"
                        ? Colors.purpleAccent
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Rock"
                        ? Colors.grey
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Ghost"
                        ? Colors.deepPurple[300]
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Psychic"
                        ? Colors.deepPurpleAccent
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Fire"
                        ? Colors.orangeAccent
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Ground"
                        ? Colors.brown.withOpacity(0.8)
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Bug"
                        ? Colors.greenAccent[700]
                        :
                    Data.poke["pokemon"][index]["typeofpokemon"][0] == "Dark"
                        ? Colors.grey
                        :
                    Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          //The Faded line in middle of a card
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.056,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.1905,
                          // right: 91.7,
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
                                )
                            ),
                          ),
                        ),
                        Positioned(
                          //Background Faded Circle of image
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.009,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.69,
                          // right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.15),
                            radius: 38,
                          ),
                        ),
                        Positioned(
                          // image of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.705,
                          // right: 27,
                          child: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: Data.poke["pokemon"][index]["imageurl"],
                              cacheKey: Data.poke["pokemon"][index]["imageurl"],
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
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          left: 15,
                          child: Text(Data.poke["pokemon"][index]["name"],
                            // style: TextStyle(
                            //   color: Colors.black.withOpacity(0.9),
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.w600,
                            // )
                            style: GoogleFonts.roboto(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          //type of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          left: 140,
                          child: Text(
                              Data.poke["pokemon"][index]["typeofpokemon"][0],
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
        ),
      ),
    );
  }

  Widget typePokemon(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: find(click).isEmpty ? 10 : find(click).length,
            itemBuilder: (BuildContext context, int index) {
              final suggestionList = find(click).toList();
              return Container(
                height: 100,
                width: double.infinity,
                child: GestureDetector(
                  onTapDown: (details) {
                    print(details.localPosition);
                  },
                  onTapUp: (details) {
                    print(details.localPosition);
                  },
                  onTap: () {
                    setState(() {
                      isCollapsed = false;
                    });
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
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.056,
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
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.009,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.15),
                            radius: 38,
                          ),
                        ),
                        Positioned(
                          // image of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025,
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
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          left: 15,
                          child: Text(suggestionList[index]["name"],
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Positioned(
                          //type of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
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
        ),
      ),
    );
  }

  Widget allPokemonType(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: names.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                setState(() {
                  onClick = false;
                  click = names[index];
                  isCollapsed = false;
                  iconAnimation();
                });
              } else {
                setState(() {
                  onClick = true;
                  click = names[index];
                  isCollapsed = false;
                  iconAnimation();
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color:
                    names[index] == "All" ? Colors.white :
                    names[index] == "Electric" ? Colors.yellowAccent :
                    names[index] == "Fighting" ? Colors.blueGrey
                        .withOpacity(0.8) :
                    names[index] == "Grass" ? Colors.greenAccent :
                    names[index] == "Water" ? Colors.blueAccent :
                    names[index] == "Poison" ? Colors.purpleAccent :
                    names[index] == "Rock" ? Colors.grey :
                    names[index] == "Ghost" ? Colors.deepPurple[300] :
                    names[index] == "Psychic" ? Colors
                        .deepPurpleAccent :
                    names[index] == "Fire" ? Colors.orangeAccent :
                    names[index] == "Ground" ? Colors.brown
                        .withOpacity(0.8) :
                    names[index] == "Bug" ? Colors.greenAccent[700] :
                    names[index] == "Dark" ? Colors.grey :
                    Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text(
                        names[index],
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2,left: 10,right: 10),
                  child: Container(
                    height: 4,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: click == names[index] ?
                      click == "All" ? Colors.black.withOpacity(0.2) :
                      click == "Electric" ? Colors.yellowAccent :
                      click == "Fighting" ? Colors.blueGrey
                          .withOpacity(0.8) :
                      click == "Grass" ? Colors.greenAccent :
                      click == "Water" ? Colors.blueAccent :
                      click == "Poison" ? Colors.purpleAccent :
                      click == "Rock" ? Colors.grey :
                      click == "Ghost" ? Colors.deepPurple[300] :
                      click == "Psychic" ? Colors
                          .deepPurpleAccent :
                      click == "Fire" ? Colors.orangeAccent :
                      click == "Ground" ? Colors.brown
                          .withOpacity(0.8) :
                      click == "Bug" ? Colors.greenAccent[700] :
                      click == "Dark" ? Colors.grey :
                      Colors.white : Colors.white
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCollapsed = false;
          iconAnimation();
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
                title: Text(
                  "Pokedex", style: GoogleFonts.roboto(color: Colors.black),),
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                // leading: IconButton(
                //   onPressed: (){
                //     setState(() {
                //       isCollapsed = !isCollapsed;
                //     });
                //   },
                //   icon: Icon(Icons.dehaze,
                //     color: Colors.black,),
                // ),
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                      iconAnimation();
                    });
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: controller!,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        isCollapsed = false;
                      });
                      showSearch(context: context,
                          delegate: DataSearch(file: Data.poke["pokemon"]));
                    },)
                ],
              ),
              body: Data.poke.isEmpty ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) : Column(
                children: [
                  // top slide bar
                  Data.isGen == false ?
                  allPokemonType(context) :
                  genName(context),

                  SizedBox(
                    height: 6,
                  ),

                  // bottom pokemon card
                  Data.isGenPoke == false ?
                  onClick == false ?
                  allPokemon(context) :
                  typePokemon(context) : genPokemon(context),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.1,
              left: isCollapsed == false ? -MediaQuery
                  .of(context)
                  .size
                  .width * 0.6 : 0,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.9,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.6,
              child: GestureDetector(
                onTap: () {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 55,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Data.isGenPoke = false;
                              Data.isGen = false;
                              isCollapsed = false;
                              click = "All";
                              iconAnimation();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.catching_pokemon_outlined,
                                  color: Colors.black.withOpacity(0.9),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("All Pokemon",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.9),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Data.isGen = true;
                              genIndex = 0;
                              isCollapsed = false;
                              onClick = false;
                              iconAnimation();
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.all_inclusive,
                                  color: Colors.black.withOpacity(0.9),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Generations",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.9),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 35,
                      //   width: MediaQuery
                      //       .of(context)
                      //       .size
                      //       .width * 0.6,
                      //   alignment: Alignment.centerLeft,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         Data.isGen = true;
                      //         genIndex = 1;
                      //         isCollapsed = false;
                      //         onClick = false;
                      //         iconAnimation();
                      //       });
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 55),
                      //       child: Text("Gen 1",
                      //           style: GoogleFonts.roboto(
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.black.withOpacity(0.9),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 35,
                      //   width: MediaQuery
                      //       .of(context)
                      //       .size
                      //       .width * 0.6,
                      //   alignment: Alignment.centerLeft,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         Data.isGen = true;
                      //         genIndex = 2;
                      //         isCollapsed = false;
                      //         onClick = false;
                      //         iconAnimation();
                      //       });
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 55),
                      //       child: Text("Gen 2",
                      //           style: GoogleFonts.roboto(
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.black.withOpacity(0.9),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   height: 35,
                      //   width: MediaQuery
                      //       .of(context)
                      //       .size
                      //       .width * 0.6,
                      //   alignment: Alignment.centerLeft,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         Data.isGen = true;
                      //         genIndex = 3;
                      //         isCollapsed = false;
                      //         onClick = false;
                      //         iconAnimation();
                      //       });
                      //     },
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 55),
                      //       child: Text("Gen 3",
                      //           style: GoogleFonts.roboto(
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.black.withOpacity(0.9),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: 55,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isCollapsed = false;
                              iconAnimation();
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return FavPoke();
                              }));
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.favorite_border_outlined,
                                  color: Colors.black.withOpacity(0.9),
                                  size: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Favorite",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.9),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // child: Stack(
                  //   children: [
                  //     Positioned(
                  //       top: 0,
                  //       child: Container(
                  //         height: 80,
                  //         width: MediaQuery.of(context).size.width*0.5,
                  //         child: Card(
                  //           margin: EdgeInsets.all(0),
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(18),topRight: Radius.circular(18)),
                  //           ),
                  //           color: Colors.white,
                  //           child: Center(
                  //             child: Text(
                  //               "PokeDex",
                  //               style: TextStyle(
                  //                 fontSize: 25,
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 100,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             click = "";
                  //             onClick = false;
                  //             isCollapsed = false;
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.favorite,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("All Pokemon",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 150,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             click = "Fire";
                  //             onClick = true;
                  //             isCollapsed = false;
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.whatshot,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("Fire",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 200,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             click = "Water";
                  //             onClick = true;
                  //             isCollapsed = false;
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.ac_unit,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("Water",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 250,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             click = "Rock";
                  //             onClick = true;
                  //             isCollapsed = false;
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.radio_button_checked,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("Rock",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 300,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             click = "Electric";
                  //             onClick = true;
                  //             isCollapsed = false;
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.flash_on,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("Electric",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       top: 350,
                  //       child: GestureDetector(
                  //         onTap: (){
                  //           setState(() {
                  //             isCollapsed = false;
                  //             Navigator.push(context, MaterialPageRoute(builder: (context){
                  //               return FavPoke();
                  //             }));
                  //           });
                  //         },
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Icon(Icons.favorite,
                  //                 size: 22,
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 15),
                  //               child: Text("Favorite",
                  //                   style: TextStyle(
                  //                     fontSize: 21,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Colors.black,
                  //                   )),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget genName(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: gen["all"].length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if(index == 0){
                setState(() {
                  Data.isGenPoke = false;
                  genIndex = index;
                });
              }else{
                setState(() {
                  Data.isGenPoke = true;
                  genIndex = index;
                });
              }
              // print(gen[gen["all"][index]]["length"]);
              // if (index == 0) {
              //   setState(() {
              //     Data.isGen = false;
              //     isCollapsed = false;
              //     iconAnimation();
              //   });
              // } else {
              //   setState(() {
              //     genIndex = index;
              //     isCollapsed = false;
              //     iconAnimation();
              //   });
              // }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 110,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color:
                    Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text(
                        gen["all"][index],
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2,left: 10,right: 10),
                  child: Container(
                    height: 4,
                    width: 85,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: genIndex == index ?
                        Colors.black.withOpacity(0.2) :
                        Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget genPokemon(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: gen[gen["all"][genIndex]]["length"],
            itemBuilder: (BuildContext context, int index) {
              // final suggestionList = find(click).toList();
              // setState(() {
              //   index = index + int.parse(gen[gen["all"][genIndex]]["from"]);
              // });
              return Container(
                height: 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: GestureDetector(
                  onTap: () {
                    Future.delayed(Duration(milliseconds: 200), () {
                      Navigator.push(context, PageTransition(
                        child: InfoScreen(
                          appBar: true,
                          inx: index +
                              int.parse(gen[gen["all"][genIndex]]["from"].toString()) - 1,
                        ),
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        type: PageTransitionType.rightToLeft,
                      ));
                    });
                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    color:
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] ==
                        "Electric" ? Colors.yellowAccent :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] ==
                        "Fighting" ? Colors.blueGrey.withOpacity(0.8) :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Grass"
                        ? Colors.greenAccent
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Water"
                        ? Colors.blueAccent
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Poison"
                        ? Colors.purpleAccent
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Rock"
                        ? Colors.grey
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Ghost"
                        ? Colors.deepPurple[300]
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Psychic"
                        ? Colors.deepPurpleAccent
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Fire"
                        ? Colors.orangeAccent
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Ground"
                        ? Colors.brown.withOpacity(0.8)
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Bug"
                        ? Colors.greenAccent[700]
                        :
                    Data.poke["pokemon"][index +
                        gen[gen["all"][genIndex]]["from"] -
                        1]["typeofpokemon"][0] == "Dark"
                        ? Colors.grey
                        :
                    Colors.white,
                    child: Stack(
                      children: [
                        Positioned(
                          //The Faded line in middle of a card
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.056,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.1905,
                          // right: 91.7,
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
                                )
                            ),
                          ),
                        ),
                        Positioned(
                          //Background Faded Circle of image
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.009,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.69,
                          // right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.15),
                            radius: 38,
                          ),
                        ),
                        Positioned(
                          // image of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.025,
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.705,
                          // right: 27,
                          child: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: Data.poke["pokemon"][index +
                                  gen[gen["all"][genIndex]]["from"] -
                                  1]["imageurl"],
                              cacheKey: Data.poke["pokemon"][index +
                                  gen[gen["all"][genIndex]]["from"] -
                                  1]["imageurl"],
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
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          left: 15,
                          child: Text(Data.poke["pokemon"][index +
                              gen[gen["all"][genIndex]]["from"] - 1]["name"],
                            // style: TextStyle(
                            //   color: Colors.black.withOpacity(0.9),
                            //   fontSize: 20,
                            //   fontWeight: FontWeight.w600,
                            // )
                            style: GoogleFonts.roboto(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          //type of pokemon
                          top: MediaQuery
                              .of(context)
                              .size
                              .height * 0.04,
                          left: 140,
                          child: Text(
                              Data.poke["pokemon"][index +
                                  gen[gen["all"][genIndex]]["from"] -
                                  1]["typeofpokemon"][0],
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
        ),
      ),
    );
  }

}

class DataSearch extends SearchDelegate<String> {
  var file;

  DataSearch({required this.file});

  // String n;
  // String n = "Loading...";
  // bool yes = false;
  // int inx = 0;

  final recent = [
    "Pikachu",
    "Charizard",
    "Bulbasaur",
    "Squirtle",
    "Mewtwo",
  ];
  final empty = [
    "No Pokemon find",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action for app bar
    return [IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        query = "";
        Data.n = "";
      },
    )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    for (int i = 0; i < 809; i++) {
      if (query == file[i]["name"]) {
        Data.inx = i;
        break;
      }
    }
    return InfoScreen(
      appBar: false,
      inx: Data.inx,
    );
  }

  List<dynamic> find(String s) {
    s.length >= 1 ?
    s = s.substring(0, 1).toUpperCase() + s.substring(1, s.length) :
    s = s.substring(0, 1).toUpperCase();
    List n = [];
    for (int i = 0; i < 809; i++) {
      if (file[i]["name"].startsWith(s)) {
        n.add(file[i]["name"]);
      }
    }
    return n;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ?
    recent : find(query)
        .toList()
        .isEmpty ? recent : find(query).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        Data.n = suggestionList[0];
        return ListTile(
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
          leading: Icon(Icons.blur_on),
          title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: suggestionList[index].substring(query.length),
                      style: GoogleFonts.lato(
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
