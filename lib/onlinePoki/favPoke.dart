import 'package:flutter/material.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';

class FavPoki extends StatefulWidget {

  @override
  _FavPokiState createState() => _FavPokiState();
}

class _FavPokiState extends State<FavPoki> {
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
        ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: Data.fav.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*0.9,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
              ),
              child: Text(Data.fav[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),),
            );
          },
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
