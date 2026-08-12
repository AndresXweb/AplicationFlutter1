import 'package:flutter/material.dart';

class PropinasScreen extends StatefulWidget {
  const PropinasScreen({super.key});

  @override
  State<PropinasScreen> createState() => _PropinasScreenState();
}

class _PropinasScreenState extends State<PropinasScreen> {
  final TextEditingController _cuentaController = TextEditingController();
  int _propinaSeleccionada = 10;
  int _personas = 1;

  @override
  void dispose() {
    _cuentaController.dispose();
    super.dispose();
  }

  double get _cuenta =>
      double.tryParse(_cuentaController.text.replaceAll(',', '.')) ?? 0;

  // MontoPersona = (Cuenta * (1 + Propina/100)) / Personas
  double get _montoPorPersona {
    if (_cuenta <= 0 || _personas <= 0) return 0;
    return (_cuenta * (1 + _propinaSeleccionada / 100)) / _personas;
  }

  void _incrementarPersonas() => setState(() => _personas++);

  void _decrementarPersonas() {
    if (_personas > 1) setState(() => _personas--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Propinas y División'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _cuentaController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Total de la cuenta',
              prefixIcon: Icon(Icons.attach_money),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Propina sugerida',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 10, label: Text('10%')),
              ButtonSegment(value: 15, label: Text('15%')),
              ButtonSegment(value: 20, label: Text('20%')),
            ],
            selected: {_propinaSeleccionada},
            onSelectionChanged: (Set<int> nuevaSeleccion) {
              setState(() => _propinaSeleccionada = nuevaSeleccion.first);
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Número de personas',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _decrementarPersonas,
                icon: const Icon(Icons.remove),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.all(14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '$_personas',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: _incrementarPersonas,
                icon: const Icon(Icons.add),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.all(14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.purple.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.purple, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'PAGA CADA PERSONA',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_montoPorPersona.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}