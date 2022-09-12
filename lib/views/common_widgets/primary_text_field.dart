import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final String initialValue;
  final String label;
  final void Function(String?) onSaved;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;

  const PrimaryTextField(
      {Key? key,
      required this.initialValue,
      required this.label,
      required this.onSaved,
      this.validator,
      this.inputFormatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: validator,
            onSaved: onSaved,
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
            ),
            inputFormatters: inputFormatter,
          ),
        ],
      ),
    );
  }
}
