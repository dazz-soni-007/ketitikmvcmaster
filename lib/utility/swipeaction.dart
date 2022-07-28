import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ketitik/screens/homescreen/view/home_screen.dart';

import '../screens/profile/profilescreen.dart';
import '../screens/staticpages/fullnewspage.dart';
import '../screens/staticpages/privacyandterms.dart';

/*class ProfilePageRoute extends CupertinoPageRoute {
  ProfilePageRoute()
      : super(builder: (BuildContext context) => const ProfilePage());
}*/

finishPage(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    SystemNavigator.pop();
  }
}

class ProfilePageRoute extends PageRouteBuilder {
  ProfilePageRoute()
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              ProfilePage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class NewsToHome extends PageRouteBuilder {
  NewsToHome()
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              MyHomePage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ProfileToHome extends PageRouteBuilder {
  ProfileToHome()
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              MyHomePage(),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class FullPageRoute extends PageRouteBuilder {
  FullPageRoute(String categorName, String buildUrl, String newsId)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              FullNewsPage(
            categoryName: categorName,
            newsId: newsId,
            fullnewsUrl: buildUrl,
          ),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

/*class FullPageRoute extends CupertinoPageRoute {
  FullPageRoute(String buildUrl, String newsId)
      : super(
            builder: (BuildContext context) => FullNewsPage(
                  newsId: newsId,
                  fullnewsUrl: buildUrl,
                ));
}*/

class TermsPrivacyRoute extends CupertinoPageRoute {
  TermsPrivacyRoute(String buildUrl)
      : super(
            builder: (BuildContext context) => TermsPrivacyPage(
                  fullnewsUrl: buildUrl,
                ));
}
