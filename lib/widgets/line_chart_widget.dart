import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LineChart(
      LineChartData(
        // Configuración de la línea principal
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 10), // Enero
              FlSpot(1, 20), // Febrero
              FlSpot(2, 30), // Marzo
              FlSpot(3, 25), // Abril
            ],
            isCurved: true,
            color: theme.primaryColor, // Usa el color primario del tema
            barWidth: 3,
            dotData: const FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: theme.primaryColor.withOpacity(0.1),
            ),
          ),
        ],

        // Configuración de los títulos
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value % 10 == 0) {
                  return Text(
                    '\$${value.toInt()}k',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey.shade500,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('Jan', style: TextStyle(fontSize: 12));
                  case 1:
                    return const Text('Feb', style: TextStyle(fontSize: 12));
                  case 2:
                    return const Text('Mar', style: TextStyle(fontSize: 12));
                  case 3:
                    return const Text('Apr', style: TextStyle(fontSize: 12));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),

        // Configuración de las líneas de cuadrícula
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.primaryColorLight.withOpacity(0.3),
              strokeWidth: 1,
            );
          },
        ),

        // Configuración del borde
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: theme.primaryColorLight.withOpacity(0.5),
          ),
        ),

        // Espaciado entre los puntos
        minX: 0,
        maxX: 3,
        minY: 0,
        maxY: 50,
      ),
      duration: const Duration(milliseconds: 300), // Animación de transición
      curve: Curves.easeInOut, // Curva de animación
    );
  }
}
