import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

OutlineInputBorder borders(){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultRadius-15),
      borderSide: BorderSide(
          color: secondaryColor
      )
  );
}

OutlineInputBorder errorBorders(){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(defaultRadius-15),
      borderSide: BorderSide(
          color: Colors.redAccent
      )
  );
}
