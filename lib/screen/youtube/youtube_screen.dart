import 'dart:developer';

import 'package:baro_project/models/youtube_video.dart';
import 'package:baro_project/screens/youtube/provider/youtube_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YoutubeScreen extends ConsumerWidget {
  YoutubeScreen({super.key});

  final List<String> categories = ['목스트레칭', '거북목바른자세', '손목스트레칭', '허리스트레칭'];

  String convertText(String category) {
    switch (category) {
      case '목스트레칭':
        return '목 스트레칭';
      case '거북목바른자세':
        return '거북목 교정';
      case '손목스트레칭':
        return '손목 스트레칭';
      case '허리스트레칭':
        return '허리 스트레칭';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoAsyncValue = ref.watch(youtubeProvider);

    return videoAsyncValue.when(data: (videos) {
      var categoryVideos = <String, List<YoutubeVideo>>{};
      for (var category in categories) {
        categoryVideos[category] = videos.where((video) => video.category == category).toList();
      }

      var categoryList = categoryVideos.entries.map((entry) {
        var category = entry.key;
        var videos = entry.value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(convertText(category), style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: GestureDetector(
                      onTap: () => ref.read(youtubeServiceProvider).launchYoutubeVideo(videos[index].id),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                            child: Image.network(videos[index].thumbnailUrl),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Color(0xffDAEDFF),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                            child: Text(
                              videos[index].title,
                              style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
          ],
        );
      }).toList();

      return SingleChildScrollView(
        child: Column(
          children: categoryList,
        ),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    }, error: (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return const Center(child: Text("동영상을 불러오는데 실패했습니다."));
    });
  }
}
