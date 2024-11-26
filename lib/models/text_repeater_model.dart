import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TextRepeaterModel extends ChangeNotifier {
  String inputText = '';
  String repeatCount = '1';
  String selectedDelimiter = '\n';
  double _fontSize = 16;

  // Font styling properties
  FontWeight _fontWeight = FontWeight.normal;
  FontStyle _fontStyle = FontStyle.normal;

  // List to store repeated texts
  List<String> savedTexts = [];

  // Getter for fontSize
  double get fontSize => _fontSize;

  // Getter for fontWeight
  FontWeight get fontWeight => _fontWeight;

  // Getter for fontStyle
  FontStyle get fontStyle => _fontStyle;

  // Setter for fontSize
  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  // Setter for fontWeight
  void setFontWeight(FontWeight weight) {
    _fontWeight = weight;
    notifyListeners();
  }

  // Setter for fontStyle
  void setFontStyle(FontStyle style) {
    _fontStyle = style;
    notifyListeners();
  }

  // Setter for input text
  void setInputText(String value) {
    inputText = value;
    notifyListeners();
  }

  // Setter for repeat count
  void setRepeatCount(String value) {
    repeatCount = value;
    notifyListeners();
  }

  // Setter for delimiter
  void setDelimiter(String value) {
    selectedDelimiter = value;
    notifyListeners();
  }

  // Get repeated text
  String getRepeatedText() {
    if (inputText.isEmpty || int.tryParse(repeatCount) == null) {
      return '';
    }
    int count = int.parse(repeatCount);
    return List.generate(count, (index) => inputText).join(selectedDelimiter);
  }

  // Save the repeated text to the list
  void saveText() {
    final repeatedText = getRepeatedText();
    if (repeatedText.isNotEmpty) {
      savedTexts.add(repeatedText);
      notifyListeners();
    }
  }

  // Copy text to clipboard
  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  // Share text
  void shareText(String text) {
    Share.share(text);
  }

  // Save text to file
  Future<void> saveToFile(String text) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/repeated_text.txt');
    await file.writeAsString(text);
  }

  // Clear all values
  void clearAll() {
    inputText = '';
    repeatCount = '1';
    selectedDelimiter = ' ';
    _fontSize = 16;
    _fontWeight = FontWeight.normal; // Reset font weight
    _fontStyle = FontStyle.normal;   // Reset font style
    notifyListeners();
  }
}

