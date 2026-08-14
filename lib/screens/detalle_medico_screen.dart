import 'package:flutter/material.dart';
import '../models/medico.dart';

class DetalleMedicoScreen extends StatefulWidget {
  final Medico medico;

  const DetalleMedicoScreen({super.key, required this.medico});

  @override
  State<DetalleMedicoScreen> createState() => _DetalleMedicoScreenState();
}

class _DetalleMedicoScreenState extends State<DetalleMedicoScreen> {
  DateTime? _fechaSeleccionada;
  String _modalidad = 'Presencial';

  Future<void> _elegirFecha() async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (fecha != null) {
      setState(() => _fechaSeleccionada = fecha);
    }
  }

  void _reservarCita() {
    final fecha = _fechaSeleccionada;
    if (fecha == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selecciona una fecha antes de reservar')),
      );
      return;
    }

    final hoy = DateTime.now();
    final esHoy = fecha.year == hoy.year && fecha.month == hoy.month && fecha.day == hoy.day;

    if (esHoy && !widget.medico.disponibleHoy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Este médico no está disponible hoy, elige otra fecha')),
      );
      return;
    }

    final fechaTexto = '${fecha.day}/${fecha.month}/${fecha.year}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Cita reservada con ${widget.medico.nombre} el $fechaTexto ($_modalidad)',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medico = widget.medico;

    return Scaffold(
      appBar: AppBar(title: Text(medico.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Especialidad: ${medico.especialidad}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Años de experiencia: ${medico.anosExperiencia}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Precio consulta: \$${medico.precioConsulta.toStringAsFixed(0)}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              medico.disponibleHoy ? 'Disponible hoy' : 'No disponible hoy',
              style: TextStyle(
                fontSize: 16,
                color: medico.disponibleHoy ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Modalidad de la consulta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ['Presencial', 'Virtual'].map((opcion) {
                return ChoiceChip(
                  label: Text(opcion),
                  selected: _modalidad == opcion,
                  onSelected: (_) => setState(() => _modalidad = opcion),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _elegirFecha,
              icon: const Icon(Icons.calendar_today),
              label: Text(
                _fechaSeleccionada == null
                    ? 'Elegir fecha de la cita'
                    : 'Fecha: ${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}',
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _reservarCita,
                child: const Text('Reservar Cita'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
