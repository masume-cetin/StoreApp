import 'package:flutter/material.dart';

class GenericTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  String? Function(String?, BuildContext) validation;
  String? labelText;
  Icon? icon;
  TextInputType textInputType;
  bool? isObscureText;
  GenericTextField(
      {super.key,
      required this.controller,
      required this.validation,
      this.labelText,
      this.icon,
      required this.textInputType,
      this.isObscureText});
  @override
  _GenericTextFieldState createState() => _GenericTextFieldState();
}

class _GenericTextFieldState extends State<GenericTextField> {
  // Create a controller for the TextField

  final labelText = "";

  @override
  /*void dispose() {
    // Dispose of the controller when the widget is removed
    widget.controller.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isObscureText ?? false,
      decoration: InputDecoration(
        labelText: widget.labelText ?? "",
        prefixIcon: widget.icon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        disabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: widget.textInputType,
      validator: (value) => widget.validation(value, context),
    );
  }
}
