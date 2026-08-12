import 'package:flutter/material.dart';

class CitasMedicasScreen extends StatefulWidget {
  const CitasMedicasScreen({super.key});

  @override
  State<CitasMedicasScreen> createState() => _CitasMedicasScreenState();
}

class _CitasMedicasScreenState extends State<CitasMedicasScreen> {
  final List<String> _especialidades = [
    'Medicina General',
    'Odontología',
    'Pediatría',
  ];

  String? _especialidadSeleccionada;
  DateTime? _fechaSeleccionada;
  String? _ticketGenerado;

  Future<void> _elegirFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
        _ticketGenerado = null; // si cambia la fecha, se invalida el ticket
      });
    }
  }

  String _formatearFecha(DateTime fecha) {
    final String mes = fecha.month.toString().padLeft(2, '0');
    final String dia = fecha.day.toString().padLeft(2, '0');
    return '${fecha.year}-$mes-$dia';
  }

  void _confirmarReserva() {
    if (_especialidadSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una especialidad')),
      );
      return;
    }
    if (_fechaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una fecha para la cita')),
      );
      return;
    }
    setState(() {
      _ticketGenerado =
          'Cita confirmada para $_especialidadSeleccionada el ${_formatearFecha(_fechaSeleccionada!)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas Médicas'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _especialidadSeleccionada,
            decoration: const InputDecoration(
              labelText: 'Especialidad',
              prefixIcon: Icon(Icons.medical_services_outlined),
              border: OutlineInputBorder(),
            ),
            items: _especialidades.map((esp) {
              return DropdownMenuItem(value: esp, child: Text(esp));
            }).toList(),
            onChanged: (val) => setState(() {
              _especialidadSeleccionada = val;
              _ticketGenerado = null;
            }),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: _elegirFecha,
            icon: const Icon(Icons.calendar_today),
            label: Text(
              _fechaSeleccionada == null
                  ? 'Elegir fecha de la cita'
                  : 'Fecha: ${_formatearFecha(_fechaSeleccionada!)}',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _confirmarReserva,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Confirmar Reserva'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (_ticketGenerado != null)
            Card(
              color: Colors.teal.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.teal, width: 1.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'TICKET VIRTUAL GENERADO',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(_ticketGenerado!, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}