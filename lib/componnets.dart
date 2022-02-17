import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Componnets {
 textInput(TextEditingController name,String labe,bool obscure, {Function? fun}) {
    return InkWell(
      child: TextFormField(
          
           obscureText: obscure,
          controller: name,
          keyboardType: TextInputType.name,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          
          
          decoration:  InputDecoration(
            
            
            border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.green,width: 4.0)),
            labelText: labe ,
          )));

}
myContainer(double w, double h, double m, String text,
   ) {
    return Container(
      width: w,
      height: h,
      
      margin: EdgeInsets.all(m),
      child: Center(
          child: Text(
        text,
     
        
      )),
    );
  }
}

