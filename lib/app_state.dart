import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState with ChangeNotifier{
  //create a contrusctor
  AppState();

  String _dataUrl = "https://reqres.in/api/users?per_page=20";
  String _jsonResonse = "";
  bool _isFetching = false;


  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();
    var response = await http.get(_dataUrl);

    if(response.statusCode==200){
      _jsonResonse = response.body;
    }

    _isFetching = false;
    notifyListeners();


  }

  String get getResponseText=> _jsonResonse;

  List<dynamic> getResponseJson(){
    if (_jsonResonse.isNotEmpty){
      Map<String, dynamic> json = jsonDecode(_jsonResonse);
      return json['data'];
    }
  }

  //initialize private variable
  String _displayText = "";

  //create method
  void setDisplayText(String text){
    //perform logic
    _displayText = text;

    //notify listeners
    notifyListeners();
  }


  String get getDisplayText=> _displayText;

}