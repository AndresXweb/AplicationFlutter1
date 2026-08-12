import 'package:flutter/material.dart';
import '../models/medico.dart';
import 'detalle_medico_screen.dart';

class DirectorioScreen extends StatelessWidget {
  const DirectorioScreen({super.key});

  List<Medico> _obtenerMedicos() {
    return [
      Medico(id: '1', nombre: 'Dra. Ana Gómez', especialidad: 'Cardiología', anosExperiencia: 12, precioConsulta: 150000, disponibleHoy: true),
      Medico(id: '2', nombre: 'Dr. Carlos Ruiz', especialidad: 'Pediatría', anosExperiencia: 8, precioConsulta: 120000, disponibleHoy: false),
      Medico(id: '3', nombre: 'Dra. Laura Pérez', especialidad: 'Dermatología', anosExperiencia: 15, precioConsulta: 180000, disponibleHoy: true),
      Medico(id: '4', nombre: 'Dr. Andrés Torres', especialidad: 'Ortopedia', anosExperiencia: 20, precioConsulta: 200000, disponibleHoy: true),
      Medico(id: '5', nombre: 'Dra. Sofía Ramírez', especialidad: 'Neurología', anosExperiencia: 10, precioConsulta: 170000, disponibleHoy: false),
    ];
  }

  String _inicial(String nombre) {
    final partes = nombre.split(' ');
    return partes.length > 1 ? partes[1][0] : partes[0][0];
  }

  @override
  Widget build(BuildContext context) {
    final medicos = _obtenerMedicos();

    return Scaffold(
      appBar: AppBar(title: const Text('Directorio de Médicos')),
      // MENÚ HAMBURGUESA (DRAWER LATERAL)
      // Al incluir 'drawer', Flutter dibuja automáticamente el botón hamburguesa en el AppBar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.local_hospital, color: Colors.indigo, size: 28),
                  ),
                  SizedBox(height: 10),
                  Text('Directorio de Médicos', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Consulta y agenda tu cita', style: TextStyle(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Menú Principal'),
              onTap: () => Navigator.pop(context), // Cierra el Drawer
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Acerca de la App'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer antes de abrir el diálogo
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Acerca de esta App'),
                    content: const Text('Directorio de médicos construido en Flutter con arquitectura multi-archivo y POO.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: medicos.length,
        itemBuilder: (context, index) {
          final medico = medicos[index];
          return ListTile(
            leading: CircleAvatar(child: Text(_inicial(medico.nombre))),
            title: Text(medico.nombre),
            subtitle: Text('${medico.especialidad} • ${medico.anosExperiencia} años exp.'),
            trailing: Icon(
              Icons.circle,
              size: 12,
              color: medico.disponibleHoy ? Colors.green : Colors.red,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetalleMedicoScreen(medico: medico),
                ),
              );
            },
          );
        },
      ),
    );
  }
}