import 'package:flutter/material.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;

  const BackgroundWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height,
      width: mediaQuery.size.width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/main-background.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            theme.colorScheme.primary.withOpacity(0.68),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: child,
    );
  }
}
