import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_async_value_view.dart';
import '../../../core/widgets/section_title.dart';
import 'providers/pets_provider.dart';
import 'widgets/pet_card.dart';

class PetsScreen extends ConsumerWidget {
  const PetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pets = ref.watch(petsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Питомцы'),
        actions: <Widget>[
          IconButton(
            onPressed: () => ref.invalidate(petsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(petsProvider);
          await ref.read(petsProvider.future);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AppAsyncValueView(
            value: pets,
            data: (items) {
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: SectionTitle('Карточки питомцев'),
                    );
                  }
                  return PetCard(items[index - 1]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
