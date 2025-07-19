import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Add import for the new screen
import 'category_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3ED),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                // Title and subtitle as per design
                const Text(
                  'Gutenberg',
                  style: TextStyle(
                    fontFamily: 'Montserrat-SemiBold',
                    fontWeight: FontWeight.w700,
                    fontSize: 48,
                    color: Color(0xFF6C63FF),
                    height: 1.0,
                  ),
                ),
                const Text(
                  'Project',
                  style: TextStyle(
                    fontFamily: 'Montserrat-SemiBold',
                    fontWeight: FontWeight.w700,
                    fontSize: 48,
                    color: Color(0xFF6C63FF),
                    height: 0.9,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'A social cataloging website that allows you to freely search its database of books, annotations, and reviews.',
                  style: TextStyle(
                    fontFamily: 'Montserrat-SemiBold',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,

                    /// In attached file it is 30 but seems large so i have adjusted it to 24.
                    color: Color(0xFF2D2D2D),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                _CategoryCard(
                  label: 'FICTION',
                  iconPath: 'assets/icons/lFiction.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'FICTION'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'DRAMA',
                  iconPath: 'assets/icons/lDrama.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'DRAMA'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'HUMOR',
                  iconPath: 'assets/icons/lHumour.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'HUMOR'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'POLITICS',
                  iconPath: 'assets/icons/lPolitics.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'POLITICS'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'PHILOSOPHY',
                  iconPath: 'assets/icons/lPhilosophy.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'PHILOSOPHY'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'HISTORY',
                  iconPath: 'assets/icons/lHistory.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'HISTORY'),
                      ),
                    );
                  },
                ),
                _CategoryCard(
                  label: 'ADVENTURE',
                  iconPath: 'assets/icons/lAdventure.svg',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CategoryDetailScreen(category: 'ADVENTURE'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback? onTap;

  const _CategoryCard({
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
