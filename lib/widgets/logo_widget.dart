import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final bool showText;
  final double textSize;
  final Color? backgroundColor;
  final double borderRadius;

  const LogoWidget({
    super.key,
    this.size = 60,
    this.showText = true,
    this.textSize = 6,
    this.backgroundColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _buildLogo(),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logo.png',
      width: size * 0.8,
      height: size * 0.8,
      fit: BoxFit.contain,
      // Error handling jika gambar tidak ditemukan
      errorBuilder: (context, error, stackTrace) {
        // Fallback ke icon jika gambar tidak ada
        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.newspaper,
                size: size * 0.4,
                color: const Color(0xFF4ECCA3),
              ),
              if (showText && size > 40) ...[
                SizedBox(height: size * 0.05),
                Text(
                  'SICKNEWS',
                  style: TextStyle(
                    fontSize: textSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4ECCA3),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}