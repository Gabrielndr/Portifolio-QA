import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qa_tarefas/main.dart';

// Testes de widget rápidos, rodados com `flutter test` antes da suíte Appium.
void main() {
  Future<void> entrar(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('campo_usuario')), usuarioValido);
    await tester.enterText(find.byKey(const Key('campo_senha')), senhaValida);
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
  }

  testWidgets('bloqueia login com credenciais inválidas', (tester) async {
    await tester.pumpWidget(const QaTarefasApp());

    await tester.enterText(find.byKey(const Key('campo_usuario')), 'qa@portfolio.dev');
    await tester.enterText(find.byKey(const Key('campo_senha')), 'errada');
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('Usuário ou senha inválidos'), findsOneWidget);
  });

  testWidgets('adiciona, conclui e remove uma tarefa', (tester) async {
    await tester.pumpWidget(const QaTarefasApp());
    await entrar(tester);

    expect(find.text('Nenhuma tarefa cadastrada'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('campo_tarefa')), 'Revisar bug');
    await tester.tap(find.text('Adicionar'));
    await tester.pump();
    expect(find.text('Revisar bug'), findsOneWidget);
    expect(find.text('Pendentes: 1'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(find.text('Pendentes: 0'), findsOneWidget);

    await tester.tap(find.byTooltip('Remover'));
    await tester.pump();
    expect(find.text('Nenhuma tarefa cadastrada'), findsOneWidget);
  });
}
