import 'package:flutter/material.dart';

import '../main_app.dart';

class HeaderDrawer extends StatelessWidget {
  const HeaderDrawer({
    super.key,
    required this.widget,
  });

  final MainApp widget;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        // color: Colors.white,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                // color: Color(0xFF0165FC),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user != null ? widget.user!.firstName : 'Guest',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    widget.user != null
                        ? widget.user!.email
                        : 'examle@gmail.com', // Null check,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
