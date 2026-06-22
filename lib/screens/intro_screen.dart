import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final Color textColor;
  final Widget? footer;

  const IntroScreen({
    super.key,
    required this.title,
    this.titleWidget,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    required this.textColor,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 32),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 220,
                      height: 220,
                      child: Center(
                        child: Image.asset(
                          imageAsset,
                          width: 170,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (titleWidget != null)
                      titleWidget!
                    else
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor.withOpacity(0.9),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              if (footer != null) footer!,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
