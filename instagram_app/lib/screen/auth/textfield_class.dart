import 'package:flutter/material.dart';

class BorderInput extends StatelessWidget {
  const BorderInput({
    Key? key,
    required this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.obsecurity,
    this.contoller,
    this.validator,
  }) : super(key: key);
  final Icon prefixIcon;
  final Icon? suffixIcon;
  final String hintText;
  final bool obsecurity;
  final TextEditingController? contoller;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      height: 60,
      child: TextFormField(
        validator: validator,
        obscureText: obsecurity,
        controller: contoller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          labelText: hintText,
          prefixIcon: prefixIcon, // Use the provided prefixIcon directly
          suffixIcon: suffixIcon, // Use the provided suffixIcon directly
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: const TextStyle(
            color: Colors.black, // Set the color of the hint text when focused
          ),
        ),
      ),
    );
  }
}
