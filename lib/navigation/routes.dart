import 'package:flutter/material.dart';

import '../pages/splashscreen/SplashScreen.dart';
import '../pages/notAuthorized/notAuthorized.dart';
import '../pages/steamAuthentication/steamAuthentication.dart';
import '../pages/profile/profile.dart';
import '../pages/lastGames/LastGames.dart';
import '../pages/bestHeroes/BestHeroes.dart';
import '../pages/totals/Totals.dart';
import '../pages/counts/Counts.dart';
import '../pages/searchAuthentication/searchAuthentication.dart';
import '../pages/settings/settings.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => SplashScreen(),
  '/profile': (context) => Profile(),
  '/splash': (context) => SplashScreen(),
  '/notAuth': (context) => NotAuthorized(),
  '/steamAuth': (context) => SteamAuthentication(),
  '/lastGames': (context) => LastGames(),
  '/bestHeroes': (context) => BestHeroes(),
  '/totals': (context) => Totals(),
  '/counts': (context) => Counts(),
  '/searchAuth': (context) => SearchAuth(),
  '/settings': (context) => Settings()
};
