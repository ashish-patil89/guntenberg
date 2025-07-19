import 'package:flutter/material.dart';
import '../detail/category_detail_screen.dart';
import 'category_card.dart';

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
                CategoryCard(
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
                CategoryCard(
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
                CategoryCard(
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
                CategoryCard(
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
                CategoryCard(
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
                CategoryCard(
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
                CategoryCard(
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
