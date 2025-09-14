import 'package:flutter/cupertino.dart';

class ReusableInfoText extends StatelessWidget {
  const ReusableInfoText({
    super.key,
    required this.keyText,
    required this.value,
  });
  final String keyText;
  final String value;
  @override
  Widget build(BuildContext context) {
    return value == ''
        ? const SizedBox()
        : Row(
      children: [
        Text(
          '$keyText: ',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
