import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/custom_tag.dart';
import '../../../widgets/image_container.dart';
import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  final ArticleController uiController = Get.put(ArticleController());

  final String title;
  final String description;
  final String publishedAt;
  final String author;
  final String imageUrl;
  final String content;
  ArticleView({
    super.key,
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.author,
    required this.imageUrl,
    required this.content,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleController>(
      builder: (uiController) {
        return ImageContainer(
          width: double.infinity,
          imageUrl: imageUrl,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            extendBodyBehindAppBar: true,
            body: ListView(
              children: [
                _NewsHeadLine(
                  title: title,
                  description: description,
                  publishedAt: publishedAt,
                  author: author,
                  imageUrl: imageUrl,
                  content: content,
                ),
                _NewsBody(
                  title: title,
                  description: description,
                  publishedAt: publishedAt,
                  author: author,
                  imageUrl: imageUrl,
                  content: content,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NewsBody extends StatelessWidget {
  final String title;
  final String description;
  final String publishedAt;
  final String author;
  final String imageUrl;
  final String content;
  const _NewsBody({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.author,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArticleController>(
      builder: (uiController) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CustomTag(backgroundColor: Colors.black, children: [
                    const CircleAvatar(
                      radius: 10,
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      author.length > 10
                          ? '${author.substring(0, 10)}...'
                          : author,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    )
                  ]),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTag(backgroundColor: Colors.grey.shade200, children: [
                    const Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        publishedAt.length > 5
                            ? '${publishedAt.substring(0, 10)}...'
                            : publishedAt,
                        style: Theme.of(context).textTheme.bodyMedium!)
                  ]),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Text(content,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(height: 1.5)),
              const SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 2,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: uiController.isGridView.value ? 2 : 1,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  return ImageContainer(
                    width: MediaQuery.of(context).size.width *
                        (uiController.isGridView.value ? 0.42 : 0.84),
                    imageUrl: imageUrl,
                    margin: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NewsHeadLine extends StatelessWidget {
  final ArticleController uiController = Get.find<ArticleController>();
  final String title;
  final String description;
  final String publishedAt;
  final String author;
  final String imageUrl;
  final String content;
  _NewsHeadLine(
      {required this.title,
      required this.description,
      required this.publishedAt,
      required this.author,
      required this.imageUrl,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                author,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.25,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  uiController.isGridView.toggle();
                },
                child: Text(
                  uiController.isGridView.value
                      ? 'Switch to List'
                      : 'Switch to Grid',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
