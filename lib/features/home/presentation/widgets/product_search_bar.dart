import 'package:flutter/material.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  OutlineInputBorder get _outlineInputBorder => OutlineInputBorder(borderSide: .none, borderRadius: BorderRadius.circular(12));

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder,
      ),
    );
  }
}