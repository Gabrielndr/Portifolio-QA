import 'package:flutter/material.dart';

// Credenciais fixas do app de estudo. Os testes Robot usam os mesmos valores.
const usuarioValido = 'qa@portfolio.dev';
const senhaValida = 'Senha@123';

void main() => runApp(const QaTarefasApp());

/// Cria um nó de acessibilidade próprio com um identificador estável.
///
/// No iOS, o `identifier` vira o `accessibilityIdentifier`, que o Appium
/// encontra com `accessibility_id`. O `container: true` impede que o
/// identificador seja mesclado no nó do widget pai.
class Id extends StatelessWidget {
  const Id(this.id, {super.key, required this.child});

  final String id;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(identifier: id, container: true, child: child);
  }
}

class QaTarefasApp extends StatelessWidget {
  const QaTarefasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QA Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usuario = TextEditingController();
  final _senha = TextEditingController();
  String? _erro;

  @override
  void dispose() {
    _usuario.dispose();
    _senha.dispose();
    super.dispose();
  }

  void _entrar() {
    final usuario = _usuario.text.trim();
    final senha = _senha.text;

    String? erro;
    if (usuario.isEmpty) {
      erro = 'Informe o usuário';
    } else if (senha.isEmpty) {
      erro = 'Informe a senha';
    } else if (usuario != usuarioValido || senha != senhaValida) {
      erro = 'Usuário ou senha inválidos';
    }

    if (erro != null) {
      setState(() => _erro = erro);
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => TarefasPage(usuario: usuario)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Id('titulo_login', child: Text('Login'))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                key: const Key('campo_usuario'),
                controller: _usuario,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: const InputDecoration(labelText: 'Usuário'),
              ),
              const SizedBox(height: 16),
              TextField(
                key: const Key('campo_senha'),
                controller: _senha,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 24),
              Id(
                'botao_entrar',
                child: FilledButton(
                  onPressed: _entrar,
                  child: const Text('Entrar'),
                ),
              ),
              if (_erro != null) ...[
                const SizedBox(height: 16),
                Id(
                  'mensagem_erro',
                  child: Text(
                    _erro!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class Tarefa {
  Tarefa(this.titulo);

  final String titulo;
  bool concluida = false;
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key, required this.usuario});

  final String usuario;

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  final _novaTarefa = TextEditingController();
  final _tarefas = <Tarefa>[];
  String? _erro;

  int get _pendentes => _tarefas.where((t) => !t.concluida).length;

  @override
  void dispose() {
    _novaTarefa.dispose();
    super.dispose();
  }

  void _adicionar() {
    final titulo = _novaTarefa.text.trim();
    setState(() {
      if (titulo.isEmpty) {
        _erro = 'Informe o título da tarefa';
        return;
      }
      _erro = null;
      _tarefas.add(Tarefa(titulo));
      _novaTarefa.clear();
    });
  }

  void _sair() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Id('titulo_tarefas', child: Text('Tarefas')),
        actions: [
          Id(
            'botao_sair',
            child: IconButton(
              tooltip: 'Sair',
              icon: const Icon(Icons.logout),
              onPressed: _sair,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Id('saudacao', child: Text('Olá, ${widget.usuario}')),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      key: const Key('campo_tarefa'),
                      controller: _novaTarefa,
                      decoration: const InputDecoration(labelText: 'Nova tarefa'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Id(
                    'botao_adicionar',
                    child: FilledButton(
                      onPressed: _adicionar,
                      child: const Text('Adicionar'),
                    ),
                  ),
                ],
              ),
              if (_erro != null) ...[
                const SizedBox(height: 8),
                Id(
                  'mensagem_erro',
                  child: Text(
                    _erro!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Id('contador_pendentes', child: Text('Pendentes: $_pendentes')),
              const SizedBox(height: 8),
              Expanded(
                child: _tarefas.isEmpty
                    ? const Center(
                        child: Id(
                          'lista_vazia',
                          child: Text('Nenhuma tarefa cadastrada'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tarefas.length,
                        itemBuilder: (context, index) {
                          final tarefa = _tarefas[index];
                          return ListTile(
                            leading: Id(
                              'concluir_$index',
                              child: Checkbox(
                                value: tarefa.concluida,
                                onChanged: (valor) => setState(
                                  () => tarefa.concluida = valor ?? false,
                                ),
                              ),
                            ),
                            title: Id(
                              'tarefa_$index',
                              child: Text(
                                tarefa.titulo,
                                style: tarefa.concluida
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : null,
                              ),
                            ),
                            trailing: Id(
                              'remover_$index',
                              child: IconButton(
                                tooltip: 'Remover',
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () =>
                                    setState(() => _tarefas.removeAt(index)),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
