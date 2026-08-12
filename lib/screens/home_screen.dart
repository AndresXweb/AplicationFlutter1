import 'package:flutter/material.dart';
import 'cotizador_envios_screen.dart';
import 'encuesta_feedback_screen.dart';
import 'propinas_screen.dart';
import 'citas_medicas_screen.dart';
import 'directorio_screen.dart';

/// Representa una opción del menú principal: título, descripción,
/// ícono, color y la pantalla a la que navega.
class _OpcionMenu {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final WidgetBuilder builder;

  _OpcionMenu({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.color,
    required this.builder,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<_OpcionMenu> _obtenerOpciones() {
    return [
      _OpcionMenu(
        titulo: 'Cotizador de Envíos',
        subtitulo: 'Calcula fletes según peso y destino',
        icono: Icons.local_shipping,
        color: Colors.blue,
        builder: (_) => const CotizadorEnviosScreen(),
      ),
      _OpcionMenu(
        titulo: 'Encuesta de Feedback',
        subtitulo: 'Valora el servicio de atención',
        icono: Icons.rate_review,
        color: Colors.green,
        builder: (_) => const EncuestaFeedbackScreen(),
      ),
      _OpcionMenu(
        titulo: 'Citas Médicas',
        subtitulo: 'Agenda tu cita por especialidad',
        icono: Icons.medical_services,
        color: Colors.teal,
        builder: (_) => const CitasMedicasScreen(),
      ),
      _OpcionMenu(
        titulo: 'Propinas y División',
        subtitulo: 'Calcula la propina y divide la cuenta',
        icono: Icons.receipt_long,
        color: Colors.purple,
        builder: (_) => const PropinasScreen(),
      ),
      _OpcionMenu(
        titulo: 'Directorio de Médicos',
        subtitulo: 'Consulta especialistas y reserva tu cita',
        icono: Icons.local_hospital,
        color: Colors.teal.shade800,
        builder: (_) => const DirectorioScreen(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final opciones = _obtenerOpciones();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi app con flutter'),
        backgroundColor: Colors.pink.shade600,
        foregroundColor: Colors.white,
      ),
      // MENÚ HAMBURGUESA (DRAWER LATERAL)
      // Al incluir 'drawer', Flutter dibuja automáticamente el botón
      // hamburguesa en el AppBar, sin necesidad de agregarlo a mano.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink.shade600),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.apps, color: Colors.pink, size: 28),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mi app con flutter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Retos prácticos • Semana 2',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Menú Principal'),
              onTap: () => Navigator.pop(context), // Cierra el Drawer
            ),
            const Divider(),
            // Genera un acceso directo a cada reto desde el propio Drawer.
            ...opciones.map((opcion) {
              return ListTile(
                leading: Icon(opcion.icono, color: opcion.color),
                title: Text(opcion.titulo),
                onTap: () {
                  Navigator.pop(context); // Cierra el Drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: opcion.builder),
                  );
                },
              );
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Acerca de la App'),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer antes del diálogo
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Acerca de esta App'),
                    content: const Text(
                      'App construida en Flutter con los 4 retos de la '
                      'Semana 2 (Cotizador, Encuesta, Citas y Propinas) '
                      'más el Directorio de Médicos.',
                    ),
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: opciones.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final opcion = opciones[index];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: opcion.color,
              child: Icon(opcion.icono, color: Colors.white),
            ),
            title: Text(
              opcion.titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(opcion.subtitulo),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: opcion.builder),
              );
            },
          );
        },
      ),
    );
  }
}