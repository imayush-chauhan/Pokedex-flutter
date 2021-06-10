import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';
import 'package:pokidexayu/pokemon/infoScreen.dart';

class FavPoke extends StatefulWidget {

  @override
  _FavPokeState createState() => _FavPokeState();
}

class _FavPokeState extends State<FavPoke> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite",
          style: TextStyle(
            color: Colors.black,
          ),),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          iconSize: 20,
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Data.fav.length >= 1 ?
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemCount: Data.fav.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,childAspectRatio: 0.7,
                crossAxisSpacing: 50,
                mainAxisSpacing: 50),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return InfoScreen(
                      appBar: true,
                      inx: int.parse(Data.fav[index]) - 1,
                    );
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Electric" ? Colors.yellowAccent[200] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Fighting" ? Colors.blueGrey[200] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Grass" ? Colors.greenAccent[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Water" ? Colors.blue[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Poison" ? Colors.purpleAccent[200] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Rock" ? Colors.grey[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Ghost" ? Colors.deepPurple[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Psychic" ? Colors.deepPurpleAccent[200] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Fire" ? Colors.orangeAccent[200]:
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Ground" ? Colors.brown[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Bug" ? Colors.greenAccent[400] :
                    Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["typeofpokemon"][0] == "Dark" ? Colors.grey[800]:
                    Colors.pink,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.22,
                        child: CachedNetworkImage(
                          imageUrl: Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["imageurl"],
                          cacheKey: Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["imageurl"],
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Text(Data.poke["pokemon"][int.parse(Data.fav[index]) - 1]["name"],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.7),
                        ),),
                      Text(Data.fav[index].toString(),
                        style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                        ),),
                    ],
                  ),
                ),
              );
            },
          ),
        ) : Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text("No Fav Pokemon",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),),
          ),
        ),
      ),
    );
  }
}
