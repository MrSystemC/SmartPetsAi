import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/ai_assistant_repository.dart';
import '../../domain/ai_message.dart';

final aiAssistantRepositoryProvider = Provider<AiAssistantRepository>((Ref ref) {
  return AiAssistantRepository(ref.watch(dioProvider));
});

class AssistantState {
  const AssistantState({
    this.messages = const <AiMessage>[
      AiMessage(
        text: 'Привет! Я AI-помощник Petsgram. Могу помочь с уходом, контентом и структурой профиля питомца.',
        isUser: false,
      ),
    ],
    this.isLoading = false,
    this.error,
  });

  final List<AiMessage> messages;
  final bool isLoading;
  final String? error;

  AssistantState copyWith({
    List<AiMessage>? messages,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AssistantState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}

class AssistantController extends StateNotifier<AssistantState> {
  AssistantController(this._repository) : super(const AssistantState());

  final AiAssistantRepository _repository;

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;

    final updated = <AiMessage>[
      ...state.messages,
      AiMessage(text: text.trim(), isUser: true),
    ];
    state = state.copyWith(messages: updated, isLoading: true, clearError: true);

    try {
      final reply = await _repository.sendMessage(text.trim());
      state = state.copyWith(
        isLoading: false,
        messages: <AiMessage>[
          ...updated,
          AiMessage(text: reply, isUser: false),
        ],
      );
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }
}

final assistantControllerProvider = StateNotifierProvider<AssistantController, AssistantState>((Ref ref) {
  return AssistantController(ref.watch(aiAssistantRepositoryProvider));
});
