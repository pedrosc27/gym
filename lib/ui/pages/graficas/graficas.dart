import 'package:flutter/material.dart';
import 'package:gym/data/preferences.dart';
import 'package:gym/domain/models/sales.dart';
import 'package:gym/domain/repository/users_repository.dart';
import 'package:gym/ui/pages/graficas/graficas_provider.dart';
import 'package:gym/ui/pages/graficas/myhome.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Graficas extends StatefulWidget {
  const Graficas._();

  static Widget init() => ChangeNotifierProvider(
        lazy: false,
        create: (context) => GraficasProvider(
          personRepository: context.read<UserRepository>(),
        )..loadGraficas,
        child: const Graficas._(),
      );

  @override
  State<Graficas> createState() => _Graficas();
}

class _Graficas extends State<Graficas> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final Size size = data.size;
    final _width = size.width;
    final SharedPreferences prefs = LocalStorage.prefs;
    final nombre = prefs.getString("nombre") ?? "";
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
          stream: context.read<GraficasProvider>().loadGraficas(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!;
            if (data.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/pregunta.png"),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "No tienes datos suficientes para generar las Estadísticas",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'NeoRegular',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              );
            }
            List<SalesData> listSales = [
              SalesData('Jan', 35),
              SalesData('Feb', 28),
              SalesData('Mar', 34),
              SalesData('Apr', 32),
              SalesData('May', 40)
            ];

            final Grafica grafica = Grafica(listSales, "Prueba de Grafica");
            List<SalesData> pesoSales = [];
            List<SalesData> grasaImpidenciaSales = [];
            List<SalesData> masaImpidenciaSales = [];
            List<SalesData> cinturaSales = [];
            List<SalesData> perimetroAbdominalSales = [];
            List<SalesData> caderaSales = [];
            List<SalesData> pBrazoRelajadoSales = [];
            List<SalesData> pBrazoContraidoSales = [];
            List<SalesData> pMusloSales = [];
            List<SalesData> pPiernaSales = [];
            List<SalesData> plBicepsSales = [];
            List<SalesData> plTricepsSales = [];
            List<SalesData> pSubescapularSales = [];
            List<SalesData> pIleocretalSales = [];
            List<SalesData> pSupraespinalSales = [];
            List<SalesData> pAbdominalSales = [];
            List<SalesData> plMusloSales = [];
            List<SalesData> plPiernaSales = [];
            List<SalesData> porcentajeGrasaSales = [];

            Grafica peso = Grafica(pesoSales, "Peso");
            Grafica grasaImpidencia = Grafica(grasaImpidenciaSales, "Grasa por impedancia");
            Grafica masaImpidencia = Grafica(masaImpidenciaSales, "Masa muscular por impedancia");
            Grafica cintura = Grafica(cinturaSales, "Cintura");
            Grafica perimetroAbdominal =
                Grafica(perimetroAbdominalSales, "Perímetro abdomina");
            Grafica cadera = Grafica(caderaSales, "Cadera");
            Grafica pBrazoRelajado = Grafica(pBrazoRelajadoSales, "Perímetro Brazo Relajado");
            Grafica pBrazoContraido = Grafica(pBrazoContraidoSales, "Perímetro Brazo Contraído");
            Grafica pMuslo = Grafica(pMusloSales, "Perímetro Muslo");
            Grafica pPierna = Grafica(pPiernaSales, "Perímetro Pierna");
            Grafica plBiceps = Grafica(plBicepsSales, "Pliegues de bíceps");
            Grafica plTriceps = Grafica(plTricepsSales, "Pliegues de tríceps");
            Grafica pSubescapular = Grafica(pSubescapularSales, "Pliegues subescapular");
            Grafica pIleocretal = Grafica(pIleocretalSales, "Pliegue ileocretal");
            Grafica pSupraespinal = Grafica(pSupraespinalSales, "Pliegues supraespinal");
            Grafica pAbdominal = Grafica(pAbdominalSales, "Pliegue abdominal");
            Grafica plMuslo = Grafica(plMusloSales, "Pliegue muslo");
            Grafica plPierna = Grafica(plPiernaSales, "Pliegue pierna");
            Grafica porcentajeGrasa = Grafica(porcentajeGrasaSales, "Porcentaje de grasa");

            for (var index = 0; index < data.length; index++) {
              pesoSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].peso)));
              grasaImpidenciaSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].grasaImpidencia)));
              masaImpidenciaSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].masaImpidencia)));
              cinturaSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].cintura)));
              perimetroAbdominalSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].perimetroAbdominal)));
              caderaSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].cadera)));
              pBrazoRelajadoSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pBrazoRelajado)));
              pBrazoContraidoSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pBrazoContraido)));
              pMusloSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].pMuslo)));
              pPiernaSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].pPierna)));
              plBicepsSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].plBiceps)));
              plTricepsSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].plTriceps)));
              pSubescapularSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pSubescapular)));

                  
              pIleocretalSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pIleocretal)));
              pSupraespinalSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pSupraespinal)));


              pAbdominalSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].pAbdominal)));
              plMusloSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].plMuslo)));
              plPiernaSales.add(SalesData(
                  (index + 1).toString(), double.parse(data[index].plPierna)));
              porcentajeGrasaSales.add(SalesData((index + 1).toString(),
                  double.parse(data[index].porcentajeGrasa)));
            }
            List<Grafica> graficas = [
              peso,
              grasaImpidencia,
              masaImpidencia,
              cintura,
              perimetroAbdominal,
              cadera,
              pBrazoRelajado,
              pBrazoContraido,
              pMuslo,
              pPierna,
              plBiceps,
              plTriceps,
              pSubescapular,
              pIleocretal,
              pSupraespinal,
              pAbdominal,
              plMuslo,
              plPierna,
              porcentajeGrasa
            ];
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Estadísticas",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'NeoMedium',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //MyHomePage(),
                    
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: graficas.length,
                      itemBuilder: (context, index) {
                        final graficaIndex = graficas[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: degradado),
                          child: ChartPage(
                            grafica: graficaIndex,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
