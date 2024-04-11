import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_example/di.dart';
import 'package:todo_example/domain/entity/todo.dart';
import 'package:todo_example/main.dart';

void main() {
  testWidgets('empty content guard', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    expect(find.text('Add Todo'), findsOneWidget);
  });

  testWidgets('add new todo widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MyApp()),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.text('Add Todo'), findsOneWidget);

    await tester.enterText(
      find.byKey(
        const Key('contentTextField'),
      ),
      'New Todo',
    );

    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    expect(find.text('New Todo'), findsOneWidget);
  });

  testWidgets('toggle checkbox', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // add todo
    final element = tester.element(find.byType(MyApp));
    final container = ProviderScope.containerOf(element);
    container.read(todoListProvider.notifier).add(
          Todo(
            priority: TodoPriority.low,
            content: 'Mocked Todo',
            isDone: false,
          ),
        );
    // wait for the UI to update
    await tester.pump(const Duration(seconds: 1));

    // tap on the checkbox
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    final checkbox = tester.widget(find.byType(Checkbox)) as Checkbox;
    expect(checkbox.value, true);
  });

  testWidgets('remove todo widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    // add a new todo
    final element = tester.element(find.byType(MyApp));
    final container = ProviderScope.containerOf(element);
    container.read(todoListProvider.notifier).add(
          Todo(
            priority: TodoPriority.low,
            content: 'Mocked Todo',
            isDone: false,
          ),
        );
    // wait for the UI to update
    await tester.pump(const Duration(seconds: 1));

    // swipe to delete
    await tester.drag(find.byType(Dismissible), const Offset(-1000, 0));
    await tester.pumpAndSettle();

    expect(find.text('No Todo'), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });
}
