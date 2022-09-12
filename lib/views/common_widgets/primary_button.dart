import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final bool loading;
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton(
      {Key? key,
      this.loading = false,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            onPrimary: Colors.white,
          ),
          onPressed: loading ? () {} : onPressed,
          child: loading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Loading',
                    ),
                  ],
                )
              : Text(
                  text,
                )),
    );
  }
}
