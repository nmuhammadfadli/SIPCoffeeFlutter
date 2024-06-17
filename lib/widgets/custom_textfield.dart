import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final bool readOnly;
  final bool isTextInput;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.controller,
    this.readOnly = false,
    this.isTextInput = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: isTextInput ? TextInputType.text : TextInputType.number,
      style: const TextStyle(
        color: Colors.white, // Mengatur warna teks menjadi putih
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white, 
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white, 
          fontSize: 27,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, 
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, 
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white, 
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
