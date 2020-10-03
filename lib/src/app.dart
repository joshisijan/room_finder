import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:room_finder/src/providers/home_loading_provider.dart';
import 'package:room_finder/src/screens/home.dart';
import 'package:room_finder/src/screens/signin.dart';
import 'package:room_finder/src/styles/theme.dart';


class AppBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeLoadingProvider(),
        ),
      ],
      builder: (context, child) {
        return App();
      }
    );
  }
}


class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Main App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                body: Center(
                  child: Text('An error Occurred!.'),
                ),
              );
            } else if (snapshot.connectionState != ConnectionState.done) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              FirebaseAuth fbAuth = FirebaseAuth.instance;
              return StreamBuilder(
                stream: fbAuth.authStateChanges(),
                builder: (context, user) {
                  if (user.hasError) {
                    return Scaffold(
                      appBar: AppBar(
                        actions: [
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      body: Center(
                        child: Text('An error Occurred!.'),
                      ),
                    );
                  } else if (user.connectionState == ConnectionState.waiting) {
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    if (user.data == null) {
                      return SignInPage();
                    } else {
                      return HomePage();
                    }
                  }
                },
              );
            }
          }),
    );
  }
}
