import 'package:flutter/material.dart';

class CotizadorEnviosScreen extends StatefulWidget {
  const CotizadorEnviosScreen({super.key});

  @override
  State<CotizadorEnviosScreen> createState() => _CotizadorEnviosScreenState();
}

class _CotizadorEnviosScreenState extends State<CotizadorEnviosScreen> {
  final TextEditingController _pesoController = TextEditingController();

  // Costo base según la ciudad de destino.
  final Map<String, double> _ciudades = {
    'Bogotá': 8000,
    'Medellín': 12000,
    'Cali': 14000,
  };

  // Recargo según la velocidad del envío.
  final Map<String, double> _tiposEnvio = {
    'Estándar': 0,
    'Express': 5000,
    'Super Express': 10000,
  };

  String? _ciudadSeleccionada;
  String _tipoEnvioSeleccionado = 'Estándar';
  bool _incluyeSeguro = false;
  double? _totalCotizado;

  @override
  void dispose() {
    _pesoController.dispose();
    super.dispose();
  }

  void _calcularEnvio() {
    final double? peso =
        double.tryParse(_pesoController.text.replaceAll(',', '.'));

    if (peso == null || peso <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingresa un peso válido en kilogramos')),
      );
      return;
    }

    if (_ciudadSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una ciudad de destino')),
      );
      return;
    }

    final double costoCiudad = _ciudades[_ciudadSeleccionada]!;
    final double costoVelocidad = _tiposEnvio[_tipoEnvioSeleccionado]!;
    final double costoSeguro = _incluyeSeguro ? 3000 : 0;

    // Total = CostoCiudad + (Peso * 2000) + CostoVelocidad + (Seguro ? 3000 : 0)
    final double total =
        costoCiudad + (peso * 2000) + costoVelocidad + costoSeguro;

    setState(() => _totalCotizado = total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotizador de Envíos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _pesoController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Peso en Kilogramos',
              hintText: 'Ej: 3.5',
              prefixIcon: Icon(Icons.scale),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            initialValue: _ciudadSeleccionada,
            decoration: const InputDecoration(
              labelText: 'Ciudad de destino',
              prefixIcon: Icon(Icons.location_city),
              border: OutlineInputBorder(),
            ),
            items: _ciudades.entries.map((entry) {
              return DropdownMenuItem(
                value: entry.key,
                child: Text('${entry.key} (\$${entry.value.toStringAsFixed(0)})'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _ciudadSeleccionada = val),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tipo de Envío',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ..._tiposEnvio.entries.map((entry) {
            final String etiqueta = entry.value == 0
                ? '${entry.key} (+ \$0)'
                : '${entry.key} (+ \$${entry.value.toStringAsFixed(0)})';
            return RadioListTile<String>(
              title: Text(etiqueta),
              value: entry.key,
              groupValue: _tipoEnvioSeleccionado,
              onChanged: (val) =>
                  setState(() => _tipoEnvioSeleccionado = val!),
            );
          }),
          const Divider(),
          SwitchListTile(
            title: const Text('Incluir Seguro de Mercancía'),
            subtitle: const Text('+ \$3.000 adicionales'),
            value: _incluyeSeguro,
            onChanged: (val) => setState(() => _incluyeSeguro = val),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _calcularEnvio,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular Envío'),
            ),
          ),
          const SizedBox(height: 20),
          if (_totalCotizado != null)
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.blue, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'VALOR TOTAL COTIZADO',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${_totalCotizado!.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
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