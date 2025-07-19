import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookCard extends StatelessWidget {
  final Map<String, dynamic> book;
  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final formats = book['formats'] as Map<String, dynamic>;
    String? bookUrl;

    // Priority: HTML > PDF > TEXT
    final htmlKey = formats.keys.firstWhere(
      (key) => key.contains('html'),
      orElse: () => '',
    );
    final pdfKey = formats.keys.firstWhere(
      (key) => key.contains('pdf'),
      orElse: () => '',
    );
    final textKey = formats.keys.firstWhere(
      (key) => key.contains('text'),
      orElse: () => '',
    );
    if (htmlKey.isNotEmpty) {
      bookUrl = formats[htmlKey];
    } else if (pdfKey.isNotEmpty) {
      bookUrl = formats[pdfKey];
    } else if (textKey.isNotEmpty) {
      bookUrl = formats[textKey];
    }
    final coverUrl = formats['image/jpeg'] as String?;
    final title = book['title'] as String? ?? '';
    final authors = book['authors'] as List? ?? [];
    final authorName = authors.isNotEmpty
        ? (authors[0] as Map<String, dynamic>)['name']
        : '';

    return GestureDetector(
      onTap: () async {
        if (bookUrl != null) {
          await launchUrl(
            Uri.parse(bookUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No viewable version available.')),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(211, 209, 238, 0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            height: 162,
            width: double.infinity,
            child: coverUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  )
                : const Icon(Icons.book, size: 48, color: Color(0xFFBDBDBD)),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFF2D2D2D),
            ),
          ),
          Text(
            authorName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Color(0xFFA0A0A0),
            ),
          ),
        ],
      ),
    );
  }
}
