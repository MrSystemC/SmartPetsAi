import 'package:flutter/material.dart';

import '../../domain/pet.dart';

class PetCard extends StatelessWidget {
  const PetCard(this.pet, {super.key});

  final Pet pet;

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
                CircleAvatar(radius: 24, child: Text(pet.name.isNotEmpty ? pet.name[0] : '?')),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    pet.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Chip(label: Text(pet.type)),
                Chip(label: Text(pet.breed)),
                Chip(label: Text(pet.age)),
                Chip(label: Text(pet.weight)),
              ],
            ),
            const SizedBox(height: 12),
            Text(pet.about),
          ],
        ),
      ),
    );
  }
}
