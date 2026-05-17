import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  final ValueChanged<String>? onChanged; // AJOUTÉ

  const SearchInput({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.black26 : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: onChanged, // AJOUTÉ
        style: TextStyle(color: isDark ? Colors.white : Colors.black87),
        decoration: const InputDecoration(
          hintText: "Rechercher...",
          prefixIcon: Icon(Icons.search, color: Color(0xFF2B88F0)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}