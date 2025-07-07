import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/home/presentation/screens/details_screen.dart';
import 'package:news/features/search/presentation/providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final query = ref.read(searchQueryProvider);
    _controller = TextEditingController(text: query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String shortenAuthor(String? author) {
    if (author == null || author.isEmpty) return "Unknown";
    return author.length <= 10 ? author : "${author.substring(0, 10)}...";
  }

  String shortenCategory(String? sourceName) {
    if (sourceName == null || sourceName.isEmpty) return "News";
    return sourceName;
  }

  String getTimeAgo(DateTime publishedAt) {
    final difference = DateTime.now().difference(publishedAt);
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inHours}h ago";
    return "${difference.inDays}d ago";
  }

  @override
  Widget build(BuildContext context) {
    // final query = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: TextFormField(
          controller: _controller,
          // initialValue: query,
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).state = value;
          },
          cursorColor: AppColors.grey,
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "SFPro",
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lightGrey,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: SvgPicture.asset(
                AppIcons.search,
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
                color: AppColors.grey,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _controller.clear();
                ref.read(searchQueryProvider.notifier).state = '';
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 18),
                child: SvgPicture.asset(
                  AppIcons.cancel,
                  width: 24,
                  height: 24,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(width: 0, style: BorderStyle.none),
            ),
          ),
        ),
      ),
      body: searchResults.when(
        data: (articles) {
          if (articles.isEmpty) {
            return const Center(child: Text('No results found'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                final news = articles[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(news: news),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          news.imageUrl ??
                              "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png",
                          width: 137,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.lightGrey,
                            width: 137,
                            height: 140,
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                news.title ?? "No title",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontFamily: "SFPro",
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "By ${shortenAuthor(news.author)}",
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "SFPro",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    shortenCategory(news.sourceName),
                                    style: const TextStyle(
                                      color: AppColors.blue,
                                      fontFamily: "SFPro",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("•"),
                                  const SizedBox(width: 6),
                                  Text(
                                    news.publishedAt != null
                                        ? getTimeAgo(news.publishedAt!)
                                        : "Just now",
                                    style: const TextStyle(
                                      color: AppColors.grey,
                                      fontFamily: "SFPro",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  SvgPicture.asset(
                                    AppIcons.menu,
                                    width: 24,
                                    height: 24,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return Divider(color: AppColors.lightGrey);
              },
              itemCount: articles.length,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
