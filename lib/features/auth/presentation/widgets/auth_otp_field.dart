import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthOtpField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final Function(String)? onChanged;

  const AuthOtpField({
    super.key,
    required this.controllers,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    assert(controllers.length == 4, "AuthOtpField needs exactly 4 controllers");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 64,
          height: 64,
          child: TextFormField(
            controller: controllers[index],
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              if (onChanged != null) {
                onChanged!(controllers.map((c) => c.text).join());
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Color(0xFF82C8FF), // Light blue color as in design
            ),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFF3F3F5), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF2D9CFF), width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF9F9F9),
            ),
          ),
        );
      }),
    );
  }
}
