import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;

  final VoidCallback onPress;
  final bool loading;

  const RoundButton({
    super.key,
    required this.title,
    required this.onPress,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(color: Colors.white12,)
              : Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
