import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hint,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.isHidden = false,
  });

  final String title;
  final String hint;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool isHidden;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {

  late bool obscure = widget.isHidden;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: obscure,
          validator: widget.validator,
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.blue.withAlpha(80),
            filled: true,
            enabledBorder: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            suffixIcon: widget.isHidden ? IconButton(
              icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  obscure = !obscure;
                });
              },
            ) : null,
          ),
        ),
      ],
    );
  }
}
