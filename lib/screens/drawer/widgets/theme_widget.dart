import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../theme/bloc/theme_bloc.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>(); // Access the ThemeBloc

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = (state is ThemeChanged && state.isDarkMode);
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 20,
            ),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: isDarkMode
                        ? () {
                            themeBloc.add(
                                ToggleThemeEvent()); // Trigger light theme only if currently in dark mode
                          }
                        : null, // Disable tap if already in light mode,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.transparent : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.sun_1, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Light'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: !isDarkMode
                        ? () {
                            themeBloc.add(
                                ToggleThemeEvent()); // Trigger dark theme only if currently in light mode
                          }
                        : null, // Disable tap if already in dark mode,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: !isDarkMode ? Colors.transparent : Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.moon, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Dark'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
