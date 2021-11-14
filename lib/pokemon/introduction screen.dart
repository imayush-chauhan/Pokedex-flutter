import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokidexayu/onlinePoki/pokeData.dart';
import 'package:pokidexayu/pokemon/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool onPress = false;

  void signInAnonymously() {
    _auth.signInAnonymously().then((result) {
      setState(() {
        final User? user = result.user;
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Pokemon();
          },));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.redAccent,
      pages: [
        PageViewModel(
          titleWidget: Text("infoDex",
          style: GoogleFonts.roboto(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w600
          ),),
          // body:
          // "infoDex contain data of pokemon for all to use",
          bodyWidget: Text("infoDex contain data of pokemon for all \n"
              "                             to use",
          style: GoogleFonts.roboto(
            color: Colors.white.withOpacity(0.9),
            fontSize: 18,
            fontWeight: FontWeight.w500
          ),),
          image: Text("Pokedex logo hehe",style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 19.0),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Colors.redAccent,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          titleWidget: Text("infoDex 2",
            style: GoogleFonts.roboto(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),),
          // body:
          // "infoDex contain data of pokemon for all to use",
          bodyWidget: Text("infoDex contain data of pokemon for all \n"
              "                             to use",
            style: GoogleFonts.roboto(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
                fontWeight: FontWeight.w500
            ),),
          image: Text("Pokedex logo hehe",style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 19.0),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Colors.redAccent,
            imagePadding: EdgeInsets.zero,
          ),
        ),
        PageViewModel(
          titleWidget: Text("infoDex 3",
            style: GoogleFonts.roboto(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
            ),),
          // body:
          // "infoDex contain data of pokemon for all to use",
          bodyWidget: GestureDetector(
            onTap: (){
              setState(() {
                onPress = true;
              });
              Future.delayed(Duration(milliseconds: 350), () {
                setState(() {
                  onPress = false;
                  signInAnonymously();
                });

              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: onPress == false ? 50 : 47.5,
              width: onPress == false ? 200 : 190,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                "Continue",
                style: GoogleFonts.roboto(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ),
          image: Text("Pokedex logo hehe",style: GoogleFonts.roboto(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
          decoration: PageDecoration(
            titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
            bodyTextStyle: TextStyle(fontSize: 19.0),
            descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            pageColor: Colors.redAccent,
            imagePadding: EdgeInsets.zero,
          ),
        ),
      ],
      doneColor: Colors.transparent,
      onDone: () => null,
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      rtl: false, // Display as right-to-left
      skip: const Text(''),
      next: const Text(''),
      done: const Text(''),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      dotsDecorator: const DotsDecorator(
        activeColor: Colors.white,
        size: Size(10.0, 10.0),
        color: Colors.white24,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
