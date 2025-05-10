import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.onSaved,
    this.validator,
    this.value,
  });

  final String hintText;
  final List<String> items;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.9,
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 18,
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (onSaved != null) {
            onSaved!(newValue);
          }
        },
        validator: validator ?? (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      ),
    );
  }
} 