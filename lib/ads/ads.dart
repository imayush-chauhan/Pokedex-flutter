// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:pokidexayu/data/data.dart';
//
// class Ads {
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   getHighScore();
//   //   first();
//   //   Future.delayed(Duration(milliseconds: 5),(){
//   //     timeLeft();
//   //   });
//   //   Future.delayed(Duration(milliseconds: 10),(){
//   //     if(Data.showAds == true){
//   //       bannerAds();
//   //       loadInAd();
//   //       loadReAds();
//   //     }
//   //   });
//   // }
//   //
//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   timer?.cancel();
//   //   if(Data.showAds == true){
//   //     _ad?.dispose();
//   //   }
//   // }
//
//   BannerAd? _ad;
//
//   bannerAds(){
//     if(Data.showAds == true){
//       _ad = BannerAd(
//         adUnitId: "ca-app-pub-3028010056599796/1626317951",
//         // adUnitId: BannerAd.testAdUnitId,
//         size: AdSize.banner,
//         request: AdRequest(),
//         listener: BannerAdListener(
//             onAdLoaded: (_){
//               setState(() {
//                 isLoaded = true;
//               });
//             },
//             onAdFailedToLoad: (_ad,error){
//               print("Ad failed to load on Error: $error");
//             }
//         ),
//       );
//     }
//   }
//
//   checkForAd(){
//     if(Data.showAds == true){
//       if(isLoaded == true){
//         return Container(
//           child: Center(
//             child: AdWidget(
//               ad: _ad,
//             ),
//           ),
//           height: 50,
//           width: 320,
//           alignment: Alignment.center,
//         );
//       }else{
//         return Container(
//           height: 50,
//           width: 320,
//         );
//       }
//     }else{
//       return Container(
//         height: 50,
//         width: 320,
//       );
//     }
//   }
//
//   InterstitialAd _in;
//
//   loadInAd(){
//     if(Data.showAds == true){
//       _in = InterstitialAd(
//         adUnitId: "ca-app-pub-3028010056599796/1055294705",
//         // adUnitId: InterstitialAd.testAdUnitId,
//         request: AdRequest(
//           keywords: ["amazon", "games", "land", "collage","toys","learn","coding","food"],
//         ),
//         listener: AdListener(
//             onAdLoaded: (_){
//               setState(() {
//                 isLoadedIn = true;
//               });
//             },
//             onAdFailedToLoad: (_ad,error){
//               print("Ad failed to load on Error: $error");
//             }
//         ),
//       );
//       _in.load();
//     }
//   }
//
//   showInAd(){
//     if(isLoadedIn == true){
//       _in.show();
//     }
//   }
//
//   RewardedAd _re;
//
//   loadReAds(){
//     if(Data.showAds == true){
//       _re =  RewardedAd(
//         adUnitId: 'ca-app-pub-3028010056599796/3446334882',
//         // adUnitId: RewardedAd.testAdUnitId,
//         request: AdRequest(
//           keywords: ["amazon", "games", "land", "collage","toys","learn","coding","food"],),
//         listener: AdListener(
//           onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           },
//         ),
//       );
//       _re.load();
//     }
//   }
//
//   showReAds(){
//     if(Data.showAds == true){
//       _re.show();
//     }
//   }
//
//
// }