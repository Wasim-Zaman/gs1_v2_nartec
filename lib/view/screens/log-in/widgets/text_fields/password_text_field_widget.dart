import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    required this.controller,
    this.label,
    this.focusNode,
    this.prefixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? label;
  final FocusNode? focusNode;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode ?? FocusNode(),
        obscureText: obscureText,
        onFieldSubmitted: (value) => widget.focusNode?.nextFocus(),
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.keyboardType ?? TextInputType.visiblePassword,
        validator: widget.validator ?? (value) => null,
        decoration: InputDecoration(
          hintText: widget.label ?? "Password",
          prefixIcon: const Icon(Ionicons.lock_closed_outline),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Ionicons.eye_outline : Ionicons.eye_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
