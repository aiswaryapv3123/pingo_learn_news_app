import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:pingo_learn_news/config/constants/app_sizes.dart';
import 'package:pingo_learn_news/config/constants/app_strings.dart';
import 'package:pingo_learn_news/config/extensions/app_text_styles.dart';
import 'package:pingo_learn_news/config/extensions/size_extensions.dart';
import 'package:pingo_learn_news/config/themes/app_colors.dart';
import 'package:pingo_learn_news/features/common/widgets/loader_widget.dart';
import 'package:pingo_learn_news/features/news_feeds/data/models/news_data_model.dart';
import 'package:pingo_learn_news/features/news_feeds/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  late NewsProvider newsProvider;

  @override
  void initState() {
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    getNewsData();
    super.initState();
  }

  getNewsData() {
    newsProvider.getNewsFeed('us');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: context.heightFct(0.08),
        backgroundColor: AppColors.primaryBlueDark,
        title: const Text(AppStrings.myNews),
        actions: [
          const Row(children: [
            Icon(Icons.telegram),
            Gap(AppSizes.gap7),
            Text("IN"),
            Gap(AppSizes.gap20)
          ])
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.widthFct(0.07),
            vertical: context.heightFct(0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.topHeadlines,
              style: context.bold16Black,
            ),
            const Gap(AppSizes.gap10),
            Expanded(
              child: Consumer<NewsProvider>(builder: (context, data, child) {
                if (data.newsLoading) {
                  return const Center(child: LoaderWidget());
                }
                if (data.errorMessage != null) {
                  return Center(
                    child: Text(
                      "${data.errorMessage}",
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                List<Article>? news = data.newsDataModel?.articles;
                return (news ?? []).isEmpty
                    ? const Center(child: Text(AppStrings.noDataAvailable))
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: (news ?? []).length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.zero,
                            color: AppColors.primaryWhite,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          news?[index].source?.name ?? '',
                                          style: context.bold16Black,
                                        ),
                                        const Gap(AppSizes.gap7),
                                        Text(
                                          news?[index].description ?? '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: context.mediumBlack16,
                                        ),
                                        const Gap(AppSizes.gap10),
                                        Text(
                                          news?[index].publishedAt == null
                                              ? ''
                                              : DateFormat(
                                                      'MMMM dd, yyyy, HH:mm')
                                                  .format(news![index]
                                                      .publishedAt!),
                                          style: context.regularGrey13,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(AppSizes.gap10),
                                  Container(
                                    width: context.widthFct(0.25),
                                    height: context.widthFct(0.25),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBlueLight,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        news?[index].urlToImage ?? '',
                                        errorBuilder:
                                            (context, object, stack) =>
                                                const Icon(
                                          Icons.image_not_supported_outlined,
                                          color: AppColors.greyLight,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const Gap(AppSizes.gap10),
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
