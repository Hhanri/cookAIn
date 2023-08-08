import 'package:cookain/core/utils/regexp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends TextFormField {

  final MyTextFieldParameters params;

  MyTextField({super.key, required this.params, required super.controller}) : super(
    expands: params.expands,
    maxLines: params.maxLines,
    inputFormatters: params.inputFormatters,
    enabled: params.enabled,
    autofocus: params.autoFocus,
    readOnly: params.readOnly,
    decoration: InputDecoration(
      hintText: params.label,
      errorText: params.error,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      )
    ),
    validator: params.validator,
    keyboardType: params.keyboardType
  );

}

abstract class MyTextFieldParameters {

  final String? label;
  final String? error;

  final bool expands;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool autoFocus;
  final bool readOnly;

  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  MyTextFieldParameters({
    this.label,
    this.error,
    this.expands = false,
    this.maxLines = 1,
    this.inputFormatters,
    this.enabled = true,
    this.autoFocus = false,
    this.readOnly = false,
    this.validator,
    this.keyboardType,
  });

}

class NumbersTextFieldParameters extends MyTextFieldParameters {
  NumbersTextFieldParameters({
    required super.label,
  }) : super(
    error: "Not a number",
    validator: (value) {
      if (value?.isValidNumber() ?? false) return null;
      return "Not a number";
    },
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)(\.\d{1,2})?')),
    ],
    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false)
  );
}

class TextTextFieldParameters extends MyTextFieldParameters {
  TextTextFieldParameters({
    required super.label,
  }) : super(
    keyboardType: TextInputType.text,
    maxLines: 3,
  );
}