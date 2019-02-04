import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:polylingual/polylingual.dart';

/// Load the First Widget and initialise PolyLingual
void main() async {
  // set our required default(fallback) language and initialise PolyLingual
  PolyLingual.defaultLanguageCode = "es";
  await PolyLingual.initialise("res/strings.json");

  // run your app here
  runApp(DemoApp());
}

/// Simple Demo of using PolyLingual to set up app translations
/// and then update the translation file
///
/// for the demo we support 2 languages English and Spanish
class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DemoApp',
      home: LanguageScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("es"),
        const Locale("en"),
      ],
    );
  }
}

// Simple Screen Widget to show the use of PolyLingual
class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("PolyLingual Demo")),
        body: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            Text(
              PolyLingual.of(context).string("greeting"),
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              PolyLingual.of(context).string("good"),
              style: TextStyle(color: Colors.orange),
            ),
            Text(
              PolyLingual.of(context).string("thankyou"),
              style: TextStyle(color: Colors.blue),
            ),
            Text(
              PolyLingual.of(context).string("welcome"),
              style: TextStyle(color: Colors.orange),
            ),
            RaisedButton(
              /// The example uses a defined map to update translations, but this could also come from a downloaded file
              onPressed: () async {
                Map update = {
                  "en": {
                    "greeting": "Hi, how are you?",
                    "welcome": "Thanks very much",
                    "thankyou": "cheers mate!",
                    "good": "Not So bad",
                    "about": "Information"
                  },
                  "es": {
                    "greeting": "¿Hola como estas?",
                    "welcome": "de nada amiga",
                    "thankyou": "muchas gracias",
                    "good": "muy bien",
                    "about": "Información"
                  }
                };
                await PolyLingual.updateLanguageStrings(update);
                setState(() {});
              },
              child: Text("Update EN translation data"),
            ),
          ],
        ));
  }
}
