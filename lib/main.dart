import 'package:flutter/material.dart';

void main() {
  runApp(const MeuPortfolio());
}

class MeuPortfolio extends StatelessWidget {
  const MeuPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PaginaInicial(),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final TextEditingController _nomeController = TextEditingController(text: "Seu Nome Aqui");
  
  final List<String> experiencias = [];
  final List<String> projetos = [];
  final List<String> escolaridade = [];

  Widget _botaoRetangular(String titulo, List<String> lista, IconData icone) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.centerLeft,
            backgroundColor: Colors.blue.shade50,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaDetalhes(
                  titulo: titulo,
                  itens: lista,
                  onAdicionar: (novoItem) => setState(() => lista.add(novoItem)),
                ),
              ),
            );
          },
          icon: Icon(icone),
          label: Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meu Perfil"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _nomeController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: "Nome do Usuário",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage("assets/matheus.jpeg"),
              ),
            ),
            const SizedBox(height: 40),
            _botaoRetangular("Experiência", experiencias, Icons.work_outline),
            _botaoRetangular("Projetos", projetos, Icons.code),
            _botaoRetangular("Escolaridade", escolaridade, Icons.school_outlined),
          ],
        ),
      ),
    );
  }
}

class PaginaDetalhes extends StatefulWidget {
  final String titulo;
  final List<String> itens;
  final Function(String) onAdicionar;

  const PaginaDetalhes({
    super.key,
    required this.titulo,
    required this.itens,
    required this.onAdicionar,
  });

  @override
  State<PaginaDetalhes> createState() => _PaginaDetalhesState();
}

class _PaginaDetalhesState extends State<PaginaDetalhes> {
  void _exibirDialogo() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Novo item em ${widget.titulo}"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Digite os detalhes..."),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Sair")),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() => widget.onAdicionar(controller.text));
                Navigator.pop(context);
              }
            },
            child: const Text("Adicionar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: widget.itens.isEmpty
          ? const Center(child: Text("Lista vazia. Toque no + para adicionar."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.itens.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_right),
                    title: Text(widget.itens[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _exibirDialogo,
        child: const Icon(Icons.add),
      ),
    );
  }
}