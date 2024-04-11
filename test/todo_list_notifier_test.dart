import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_example/di.dart';
import 'package:todo_example/domain/entity/todo.dart';
import 'mock/todo_list_notifier_mock.dart';
import 'utils/create_container.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = createContainer(
      overrides: [
        todoListProvider.overrideWith(TodoListNotifierMock.new),
      ],
    );
  });


  test('add todo', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier.add(
      Todo(
        priority: TodoPriority.low,
        content: 'New Todo',
        isDone: false,
      ),
    );

    expect(notifier.state.length, 2);
  });

  test('remove todo', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier.remove(0);

    expect(notifier.state.length, 0);
  });

  test('toggle done todo', () {
    final notifier = container.read(todoListProvider.notifier);
    notifier.toggleDone(0);

    final todo = notifier.state[0];

    expect(notifier.state.length, 1);
    expect(todo.isDone, true);
  });
}
