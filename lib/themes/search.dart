import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData searchTheme() {
  return ThemeData(
    appBarTheme: AppBarTheme(    
      titleSpacing: 0, 
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.normal
      ),
      toolbarHeight: 65,    
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.grey.shade500),
      actionsIconTheme: IconThemeData(color: Colors.grey.shade500),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10)
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      hintStyle: TextStyle(  
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade500,
      ),
  
    ),
    textTheme: TextTheme(  
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Colors.grey.shade800,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey.shade800,  
        overflow: TextOverflow.ellipsis,   

      ), 
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade800,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.grey.shade800,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
  ); 
}