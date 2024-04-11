import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_example/domain/entity/todo.dart';

abstract class TodoListNotifier extends Notifier<List<Todo>> {
  void add(Todo? todo);
  void remove(int index);
  void toggleDone(int index);
}

class TodoListNotifierImpl extends TodoListNotifier {
  @override
  build() {
    return [];
  }

  @override
  void add(Todo? todo) {
    if (todo == null) {
      return;
    }
    state = [...state, todo];
  }

  @override
  void remove(int index) {
    state = [...state..removeAt(index)];
  }

  @override
  void toggleDone(int index) {
    state = [
      ...state..[index] = state[index].copyWith(isDone: !state[index].isDone)
    ];
  }
}
