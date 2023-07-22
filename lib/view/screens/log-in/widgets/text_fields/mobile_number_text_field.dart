import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class MobileNumberTextField extends StatefulWidget {
  const MobileNumberTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  State<MobileNumberTextField> createState() => _MobileNumberTextFieldState();
}

class _MobileNumberTextFieldState extends State<MobileNumberTextField> {
  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: "Enter Mobile Number",
          border: InputBorder.none,
          prefixIcon: CountryCodePicker(
            initialSelection: 'HK',
            showCountryOnly: true,
            showOnlyCountryWhenClosed: true,
            alignLeft: false,
            hideMainText: true,
            onInit: (value) {
              widget.controller.text = value!.dialCode.toString();
            },
            onChanged: (value) =>
                widget.controller.text = value.dialCode.toString(),
          ),
        ),
      ),
    );
  }
}
