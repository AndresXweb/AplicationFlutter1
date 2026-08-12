import 'package:flutter/material.dart';

class EncuestaFeedbackScreen extends StatefulWidget {
  const EncuestaFeedbackScreen({super.key});

  @override
  State<EncuestaFeedbackScreen> createState() =>
      _EncuestaFeedbackScreenState();
}

class _EncuestaFeedbackScreenState extends State<EncuestaFeedbackScreen> {
  double _calificacion = 5.0;

  final Map<String, bool> _aspectos = {
    'Velocidad': false,
    'Amabilidad': false,
    'Calidad del producto': false,
  };

  String _canalSeleccionado = 'Presencial';

  List<String> get _aspectosMarcados =>
      _aspectos.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuesta de Feedback'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Calificación (1 - 10)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Slider(
            value: _calificacion,
            min: 1.0,
            max: 10.0,
            divisions: 9,
            label: _calificacion.round().toString(),
            activeColor: Colors.green,
            onChanged: (double val) {
              setState(() => _calificacion = val);
            },
          ),
          Center(
            child: Text(
              _calificacion.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Aspectos Destacados',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ..._aspectos.keys.map((aspecto) {
            return CheckboxListTile(
              title: Text(aspecto),
              value: _aspectos[aspecto],
              activeColor: Colors.green,
              onChanged: (val) =>
                  setState(() => _aspectos[aspecto] = val ?? false),
            );
          }),
          const SizedBox(height: 20),
          const Text(
            'Canal de Atención',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Presencial', 'Virtual', 'Telefónico'].map((canal) {
              return ChoiceChip(
                label: Text(canal),
                selected: _canalSeleccionado == canal,
                selectedColor: Colors.green.shade200,
                onSelected: (_) =>
                    setState(() => _canalSeleccionado = canal),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.green, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RESUMEN REGISTRADO',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Calificación: ${_calificacion.round()}/10'),
                  const SizedBox(height: 4),
                  Text(
                    _aspectosMarcados.isEmpty
                        ? 'Aspectos destacados: ninguno seleccionado'
                        : 'Aspectos destacados: ${_aspectosMarcados.join(", ")}',
                  ),
                  const SizedBox(height: 4),
                  Text('Canal de atención: $_canalSeleccionado'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}