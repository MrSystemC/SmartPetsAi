import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_async_value_view.dart';
import '../../../core/widgets/section_title.dart';
import 'providers/feed_provider.dart';
import 'widgets/feed_post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Лента'),
        actions: <Widget>[
          IconButton(
            onPressed: () => ref.invalidate(feedProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(feedProvider);
          await ref.read(feedProvider.future);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppAsyncValueView(
            value: feed,
            data: (posts) {
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: posts.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: SectionTitle('Рекомендованное для вас'),
                    );
                  }
                  return FeedPostCard(posts[index - 1]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
