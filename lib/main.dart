import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criando Transferência',
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Editor(
            controlador: _controladorCampoNumeroConta,
            dica: '0000',
            rotulo: 'Número da conta'
          ),
          Editor(
            controlador: _controladorCampoValor,
            dica: '0.00',
            rotulo: 'Valor',
            icone: Icons.monetization_on
          ),
          ElevatedButton(
            onPressed: () {
              _criaTransferencia(context);
            },
            child: Text("Confirmar"),
          )
        ],
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor =
        double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Transferência criada: $transferenciaCriada"),),
      );
      debugPrint('Criando transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  const Editor({
    this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}



class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transferências',
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.00, 1000)),
          ItemTransferencia(Transferencia(200.00, 1001)),
          ItemTransferencia(Transferencia(350.00, 2000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future future = Navigator.push(
              context, MaterialPageRoute(builder: (contextt) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}