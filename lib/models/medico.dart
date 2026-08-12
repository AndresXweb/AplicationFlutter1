class Medico {
  final String id;
  final String nombre;
  final String especialidad;
  final int anosExperiencia;
  final double precioConsulta;
  final bool disponibleHoy;

  Medico({
    required this.id,
    required this.nombre,
    required this.especialidad,
    required this.anosExperiencia,
    required this.precioConsulta,
    required this.disponibleHoy,
  });
}