import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback? onTap;

  const CategoryCard({
    required this.label,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 50, // Set height to 50px
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ), // Set horizontal padding to 10px
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4), // Set border radius to 4px
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(
              211,
              209,
              238,
              0.5,
            ), // rgba(211, 209, 238, 0.5)
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Remove default ListTile padding
        leading: SvgPicture.asset(iconPath, width: 24, height: 24),
        title: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Montserrat-Regular',
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF2D2D2D),
            letterSpacing: 0.2,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Color(0xFF6C63FF),
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
}
