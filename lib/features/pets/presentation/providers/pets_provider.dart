import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/pets_repository.dart';
import '../../domain/pet.dart';

final petsRepositoryProvider = Provider<PetsRepository>((Ref ref) {
  return PetsRepository(ref.watch(dioProvider));
});

final petsProvider = FutureProvider<List<Pet>>((Ref ref) async {
  return ref.watch(petsRepositoryProvider).getPets();
});
