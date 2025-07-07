import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:news/features/home/data/models/news_model.dart';

class DetailsScreen extends ConsumerWidget {
  final NewsModel news;
  const DetailsScreen({super.key, required this.news});

  String getTimeAgo(DateTime publishedAt) {
    final diff = DateTime.now().difference(publishedAt);
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  String shortenAuthor(String? author) {
    if (author == null || author.isEmpty) return "Unknown";
    return author.length > 20 ? author.substring(0, 20) : author;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(bookmarkProvider).contains(news);
    final imageUrl =
        news.imageUrl ??
        "https://cpworldgroup.com/wp-content/uploads/2021/01/placeholder.png";
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            AppIcons.back,
            width: 6,
            height: 12,
            fit: BoxFit.scaleDown,
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 16),
        actions: [
          GestureDetector(
            onTap: () {
              ref.read(bookmarkProvider.notifier).toggleBookmark(news);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isSaved ? 'Removed from bookmarks' : 'Saved to bookmarks',
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              isSaved ? AppIcons.bookmarkSelected : AppIcons.bookmark,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 20),
          SvgPicture.asset(
            AppIcons.share,
            width: 24,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 230,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 230,
                color: AppColors.lightGrey,
                child: const Icon(Icons.broken_image),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              news.title ?? "No title",
              style: TextStyle(
                color: AppColors.black,
                fontFamily: "SFPro",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                CircleAvatar(radius: 26),
                Text(
                  "By ${shortenAuthor(news.author)}",
                  style: const TextStyle(
                    fontFamily: "SFPro",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
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
              ],
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Text(
                    news.description ??
                        "No description available for this article.",
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "SFPro",
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
