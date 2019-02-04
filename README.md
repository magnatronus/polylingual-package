# polylingual

PolyLingual is a plug-in that provides a means of storing and updating  String translations for a Flutter app. These translations are defined and updated  using a simple JSON file similar to the one below.

```
{
    "en": {
        "greeting": "Hello, how are you?",
        "welcome": "you're welcome, my friend",
        "thankyou": "thank you very much",
        "good": "very well",
        "about": "Information"

    },
    "es": {
        "greeting": "¿Hola como estas?",
        "welcome": "de nada amiga",
        "thankyou": "muchas gracias",
        "good": "muy bien",
        "about": "Información"

    }
}
```

### How PolyLingual Works
The first thing you **MUST** do is initialise PolyLingual with a default Translation map (or load the existing one). This is done in main() before the main widget is loaded to make sure we have all the strings available.

```
void main() async {

  // set our required default(fallback) language and initialise PolyLingual
  PolyLingual.defaultLanguageCode = "es";
  await PolyLingual.initialise("res/strings.json");


  // run your app here
  runApp(DemoApp());
  
}
```

You also need to do the following to the project pubspec.yaml file

```
  flutter_localizations:
    sdk: flutter 
```

as well as define and add an initial translation string file as an asset (see example for more details)

```
  assets:
  #  - images/a_dot_burr.jpeg
  #  - images/a_dot_ham.jpeg
    - res/strings.json
```

Then, whenever you need to display a localised string somewhere just use

```
PolyLingual.of(context).string("greeting")
```

where 'greeting' is a key in the translation file (take a look at the example  *strings.json* file for the correct format).


### Updating the Translation Map
You can also update the app translation map using a new translation file in case you need to update an existing string or correct a typo. 
In the example this is hard coded, but your app could have **check for updates** button that would download the new file and auto update the translations.



## iOS
Please note that for iOS you will also need to add any supported languages to the Runner info.plist file. Read [here for more info](https://flutter.io/tutorials/internationalization/)



## Getting Started

Take a look at the example project to see how to use PolyLingual to create a multi language app that can be updated simply by providng an updated JSON file.


For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
