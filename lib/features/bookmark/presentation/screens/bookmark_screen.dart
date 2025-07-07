import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:news/features/home/presentation/screens/details_screen.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  String getTimeAgo(DateTime publishedAt) {
    final difference = DateTime.now().difference(publishedAt);
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inHours}h ago";
    return "${difference.inDays}d ago";
  }

  String shortenCategory(String? category) {
    if (category == null || category.isEmpty) return "World";
    return category.length > 5 ? category.substring(0, 5) : category;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Bookmarked",
          style: TextStyle(
            color: AppColors.black,
            fontFamily: "SFPro",
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks yet"))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final news = bookmarks[index];
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
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
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
                                "By ${news.author ?? "Unknown"}",
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontFamily: "SFPro",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  const Text("•"),
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
                                  const SizedBox(width: 8),
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
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.lightGrey),
              itemCount: bookmarks.length,
            ),
    );
  }
}
