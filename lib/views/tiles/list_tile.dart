import 'package:flutter/material.dart';

import '../../models/edition.dart';

class EditionTile extends StatelessWidget {
  final Edition edition;
  final Function(Edition) onPressed;
  final Function(Edition) onDeleted;
  const EditionTile(
      {super.key,
      required this.edition,
      required this.onPressed,
      required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${edition.city} ${edition.year}'),
      onTap: (() => onPressed(edition)),
      trailing: IconButton(
          onPressed: (() => onDeleted(edition)),
          icon: const Icon(Icons.delete)),
    );
  }
}
