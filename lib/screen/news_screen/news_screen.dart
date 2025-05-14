import 'package:flutter/material.dart';
import 'package:medicine_reminder/components/bottom_nav_bar.dart';
import 'package:medicine_reminder/components/settings_widget.dart';
import 'package:medicine_reminder/screen/news_screen/data/news_api.dart';
import 'package:medicine_reminder/screen/news_screen/news_detail.dart';
import 'package:medicine_reminder/screen/news_screen/news_service/news_service.dart';
import 'package:medicine_reminder/screen/settings/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/models/news_article.dart';
import '../../core/theme/themes.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late Future<List<NewsArticle>> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = _loadNews();
  }

  Future<List<NewsArticle>> _loadNews() async {
    final apiKey = await NewsApi.loadApiKey();
    final newsService = NewsService(apiKey: apiKey);
    return newsService.fetchHealthNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsNotifier>(builder: (context, provider, __) {
      Color scaffoldColor = provider.isDarkMode
          ? Themes.kDarkScaffoldColor
          : Themes.kLightScaffoldColor;

      Color primaryColor = provider.isDarkMode
          ? Themes.kDarkPrimaryColor
          : Themes.kLightPrimaryColor;
      return Scaffold(
        backgroundColor: Themes.kLightPrimaryColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "News About Health",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          centerTitle: true,
          actions: [
            SettingsWidget(primaryColor: primaryColor)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryColor, scaffoldColor])),
          child: SafeArea(
            child: FutureBuilder(
              future: _newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                        "No Internet connection. Please check your Network!"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text("No news found. Try again Later!"),
                  );
                }
                final articles = snapshot.data!;
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetail(
                              title: article.title,
                              description: article.description,
                              imageUrl: article.urlToImage,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: article.urlToImage,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2)),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    article.urlToImage,
                                    width: double.infinity,
                                    height: 25.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 25.h,
                                        color: Colors.grey,
                                        child: Icon(Icons.broken_image,
                                            size: 30.sp),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                                  child: Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Themes.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBarWidget(
          settingProvider: provider,
          selectedIndex: 3,
        ),
      );
    });
  }
}
