import 'package:flutter/material.dart';
import './color.dart';
import './styles.dart';

Container fryoTextInput(String hintText,
    {onTap, onChanged, onEditingComplete, onSubmitted}) {
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextField(
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: inputFieldHintTextStyle,
          focusedBorder: inputFieldFocusedBorderStyle,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          border: inputFieldDefaultBorderStyle),
    ),
  );
}
Container fryoEmailInput(String hintText,
    {TextEditingController? controller,
    String? Function(String?)? validator,
    onTap,
    onChanged,
    onEditingComplete,
    onFieldSubmitted}) {  // Update here
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,  // Update here
      keyboardType: TextInputType.emailAddress,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: inputFieldHintTextStyle,
        focusedBorder: inputFieldFocusedBorderStyle,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: inputFieldDefaultBorderStyle,
      ),
      validator: validator,
    ),
  );
}

Container fryoPasswordInput(String hintText,
    {TextEditingController? controller,
    String? Function(String?)? validator,
    onTap,
    onChanged,
    onEditingComplete,
    onFieldSubmitted}) {  // Update here
  return Container(
    margin: EdgeInsets.only(top: 13),
    child: TextFormField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,  // Update here
      obscureText: true,
      cursorColor: primaryColor,
      style: inputFieldTextStyle,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: inputFieldHintTextStyle,
        focusedBorder: inputFieldFocusedBorderStyle,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        border: inputFieldDefaultBorderStyle,
      ),
      validator: validator,
    ),
  );
}