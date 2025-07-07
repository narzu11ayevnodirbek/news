import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/core/utils/app_colors.dart';
import 'package:news/core/utils/app_icons.dart';
import 'package:news/features/home/presentation/providers/news_provider.dart';
import 'package:news/features/home/presentation/screens/details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String getTimeAgo(DateTime publishedAt) {
    final difference = DateTime.now().difference(publishedAt);
    if (difference.inMinutes < 60) return "${difference.inMinutes}m ago";
    if (difference.inHours < 24) return "${difference.inMinutes}h ago";
    return "${difference.inDays}d ago";
  }

  String shortenCategory(String? category) {
    if (category == null || category.isEmpty) return "World";
    return category.length > 5 ? category.substring(0, 5) : category;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsListProvider(null));

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            SvgPicture.asset(
              AppIcons.logo,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
            Text(
              "News 24",
              style: TextStyle(
                color: AppColors.black,
                fontFamily: "SFPro",
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SvgPicture.asset(
              AppIcons.notificationAlert,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: newsAsync.when(
          data: (newsList) => ListView.separated(
            itemBuilder: (context, index) {
              final news = newsList[index];
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
                    spacing: 10,
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    news.title ?? "No title",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontFamily: "SFPro",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "By ${news.author ?? "Unknown"}",
                              style: TextStyle(
                                color: AppColors.grey,
                                fontFamily: "SFPro",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  shortenCategory(news.sourceName),
                                  style: TextStyle(
                                    color: AppColors.blue,
                                    fontFamily: "SFPro",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("•"),
                                Text(
                                  news.publishedAt != null
                                      ? getTimeAgo(news.publishedAt!)
                                      : "Just now",
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontFamily: "SFPro",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 80),
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
            itemCount: newsList.length,
          ),
          error: (error, _) => Center(
            child: Text(
              "Failed to load news\n$error",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
