import 'package:todo_example/domain/entity/todo.dart';
import 'package:todo_example/notifier/todo_list_notifier.dart';
import 'package:mockito/mockito.dart';

class TodoListNotifierMock extends TodoListNotifier with Mock {
  @override
  List<Todo> build() {
    return [
      Todo(
        priority: TodoPriority.low,
        content: 'Mocked Todo',
        isDone: false,
      ),
    ];
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
