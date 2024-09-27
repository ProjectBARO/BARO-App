import 'dart:developer';
import 'package:baro_project/screen/youtube/provider/youtube_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPreview extends ConsumerWidget {
  const VideoPreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(youtubeProvider).when(
      data: (videos) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(videos[index].thumbnailUrl),
                  ),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        log(error.toString());
        log(stackTrace.toString());
        return const Center(child: Text("동영상을 불러오는데 실패했습니다."));
      }
    );
  }
}
