import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/transaction_cubit.dart';
import '../repository/transaction_repository.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TransactionCubit(TransactionRepository())
            ..fetchTransactions(query: category),
      child: _CategoryDetailView(category: category),
    );
  }
}

class _CategoryDetailView extends StatefulWidget {
  final String category;
  const _CategoryDetailView({required this.category});

  @override
  State<_CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<_CategoryDetailView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      final query = _searchController.text.trim();
      if (query.length >= 3) {
        context.read<TransactionCubit>().fetchTransactions(query: query);
      } else {
        context.read<TransactionCubit>().fetchTransactions(
          query: widget.category,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3ED),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 16,
                right: 8,
                bottom: 0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF6C63FF),
                      size: 32,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    category[0] + category.substring(1).toLowerCase(),
                    style: const TextStyle(
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Color(0xFF6C63FF),
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F6),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _isSearchFocused
                        ? const Color(0xFF5E56E7)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.search,
                      color: Color(0xFFBDBDBD),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontFamily: 'Montserrat-Regular',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xFFBDBDBD),
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Grid of books
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BlocBuilder<TransactionCubit, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TransactionError) {
                      return Center(child: Text(state.message));
                    } else if (state is TransactionSuccess) {
                      final books = state.data;
                      if (books.isEmpty) {
                        return const Center(child: Text('No books found.'));
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.45,
                            ),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          final book = books[index];



                          final formats = book['formats'] as Map<String, dynamic>;


// Find all keys containing 'html'
                          
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

                           print('bookUrl: ${bookUrl ?? 'No URL found'}');

                          final coverUrl =
                              formats['image/jpeg'] as String?;
                          final title = book['title'] as String? ?? '';
                          final authors = book['authors'] as List? ?? [];

                          final authorName = authors.isNotEmpty
                              ? (authors[0] as Map<String, dynamic>)['name']
                              : '';
                  

                          return GestureDetector(
                            onTap: () async {
                              if (bookUrl != null) {
                                await launchUrl(Uri.parse(bookUrl), mode: LaunchMode.externalApplication);
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
                                        color: const Color.fromRGBO(
                                          211,
                                          209,
                                          238,
                                          0.5,
                                        ),
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
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                                      Icons.broken_image,
                                                    ),
                                          ),
                                        )
                                      : const Icon(
                                          Icons.book,
                                          size: 48,
                                          color: Color(0xFFBDBDBD),
                                        ),
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
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
