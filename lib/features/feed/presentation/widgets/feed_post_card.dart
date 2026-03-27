import 'package:flutter/material.dart';

import '../../../../core/extensions/date_time_x.dart';
import '../../domain/feed_post.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard(this.post, {super.key});

  final FeedPost post;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(child: Text(post.authorName.isNotEmpty ? post.authorName[0] : '?')),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(post.authorName, style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text('${post.petName} • ${post.createdAt.toDisplayDate()}', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(post.text),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                const Icon(Icons.favorite_border, size: 18),
                const SizedBox(width: 6),
                Text('${post.likes}'),
                const SizedBox(width: 18),
                const Icon(Icons.chat_bubble_outline, size: 18),
                const SizedBox(width: 6),
                Text('${post.comments}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
