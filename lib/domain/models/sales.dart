class SalesData {
  SalesData(this.year, this.sales);
  
  final String year;
  final double sales;
}

class Grafica {
  Grafica(this.listSales, this.nombre);
  
  final List<SalesData> listSales;
  final String nombre;
}
