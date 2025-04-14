import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/utils/theme.dart';

import '../../cubits/searchBarCubit.dart';

class SearchBarTextField extends StatelessWidget {
  final VoidCallback? onCameraTap;

  const SearchBarTextField({super.key, this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        onChanged: (value) => context.read<SearchCubit>().updateQuery(value),
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          prefixIcon: const Icon(Icons.search, color: textColorPrimary),

          // 👇 Add your camera icon here
          suffixIcon: IconButton(
            icon: const Icon(Icons.camera_alt_outlined, color: textColorPrimary),
            onPressed: onCameraTap ?? () {
              // Default action (optional)
              debugPrint("📸 Camera search coming soon!");
            },
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
