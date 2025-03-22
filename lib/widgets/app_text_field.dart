import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.title,
    required this.hint,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.obscure = false,
  });

  final String title;
  final String hint;
  final String? initialValue;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final bool obscure;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isHidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          obscureText: isHidden,
          validator: widget.validator,
          onChanged: widget.onChanged,
          initialValue: widget.initialValue,
          decoration: InputDecoration(
            hintText: widget.hint,
            contentPadding: const EdgeInsets.all(16),
            fillColor: Colors.blue.withAlpha(80),
            filled: true,
            enabledBorder: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      isHidden ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(
                        () {
                          isHidden = !isHidden;
                        },
                      );
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
