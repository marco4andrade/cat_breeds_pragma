import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String label;
  final String value;
  final ThemeData theme;
  const InfoText({
    required this.label,
    required this.value,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(
        '$label: $value',
        style: theme.textTheme.bodyLarge,
      ),
    );
  }
}
