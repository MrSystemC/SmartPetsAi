import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/feed_repository.dart';
import '../../domain/feed_post.dart';

final feedRepositoryProvider = Provider<FeedRepository>((Ref ref) {
  return FeedRepository(ref.watch(dioProvider));
});

final feedProvider = FutureProvider<List<FeedPost>>((Ref ref) async {
  return ref.watch(feedRepositoryProvider).getFeed();
});
