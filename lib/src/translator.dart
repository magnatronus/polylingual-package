import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

/// PolyLingual is an easy way of adding translation strings to your app
/// It  detects the current phone language and provides a mechanism to return
/// a localised string for that language, if available.
/// Otherwise it will return the string in the selected default.
///
/// [defautLanguage] is used as the fallback language if no translation is provided.
/// The default is 'en' but this can be set as required.
class PolyLingual {
  Locale locale;
  static Map<dynamic, dynamic> _values;
  static String defaultLanguageCode = "en";

  PolyLingual(this.locale);

  /// Create an instance of PolyLingual and pass in the current phone locale
  static PolyLingual of(BuildContext context) {
    return PolyLingual(Localizations.localeOf(context));
  }

  /// Get the required string in the current phone language
  /// [id] is the key value of the required string from the resource file
  String string(id) {
    String result;
    try {
      result = _values[locale.languageCode][id];
    } catch (e) {
      result = _values[defaultLanguageCode][id];
    }
    return result;
  }

  /// This will initialise [PolyLingual] by loading in a user defined language translation map
  /// This method should always be run first, usually in the main() function (see the example app for details), so that the strings are available to the rest of the app
  ///
  /// The translation map comes either from the latest stored data OR from the specified initial asset map if there is no stored data
  /// This way the app can have seed translations built in, that can be updated without re-building or re-issung the app (as long as there are no new strings)
  ///
  /// [filename] is the default name of the file. This *MUST* exist and be declared as an asset in pubspec.yaml. This data is used to seed the PolyLingual translation map.
  ///
  /// for example:
  ///  assets:
  ///   - res/strings.json
  static initialise(String filename) async {
    var map = await _loadTranslationMapAsString();
    if (map != null) {
      _values = jsonDecode(map);
    } else {
      var strings = await rootBundle.loadString(filename);
      await updateLanguageStrings(jsonDecode(strings));
    }
  }

  /// Update the PolyLingual translation map
  /// This method can be used to correct and update the currently stored translation map
  ///
  /// [data] is the Translation Map similar to the asset supplied original.
  ///
  static updateLanguageStrings(Map data) async {
    await _saveTranslationMap(jsonEncode(data));
    _values = data;
  }

  /// Store the supplied data as the current Translation Map
  static _saveTranslationMap(String data) async {
    final directory = await getApplicationDocumentsDirectory();
    File tmap = File("${directory.path}/translator.json");
    tmap.writeAsStringSync(data);
  }

  /// check to see if there is an existing Translation Map to load
  static _loadTranslationMapAsString() async {
    String result;
    final directory = await getApplicationDocumentsDirectory();
    File tmap = File("${directory.path}/translator.json");
    if (tmap.existsSync()) {
      result = tmap.readAsStringSync();
    }
    return result;
  }
}
