import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/world_states.dart';
class WorldsStates extends StatefulWidget {
  const WorldsStates({super.key});

  @override
  State<WorldsStates> createState() => _WorldsStatesState();
}

class _WorldsStatesState extends State<WorldsStates> with TickerProviderStateMixin{
   late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();
   @override
   void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color> [
    const Color(0xff4205F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),


  ];
  @override
  Widget build(BuildContext context) {
    WorldStatesViewModel worldStatesViewModel = WorldStatesViewModel();

    return Scaffold(
      backgroundColor: Color(0xff2B2A2B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .03,),
              FutureBuilder(future: worldStatesViewModel.fetchWorldRecords(),
                  builder: (context , AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                        size: 50.0,
                        controller: _controller,
                      )
                  );
                }
                else{
                  return Column(
                    children: [
                      PieChart(

                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          "Recovered":double.parse(snapshot.data!.recovered.toString()),
                          "Death":double.parse(snapshot.data!.deaths.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.left,
                        ),
                        animationDuration: const Duration(seconds: 4),
                        chartType: ChartType.ring,
                        colorList: colorList,

                      ),
                      //SizedBox(height: MediaQuery.of(context).size.height * .03,),
                      Padding(
                        padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .04),
                        child: Card(
                          color: Colors.grey,
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                              ReusableRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                              ReusableRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                              ReusableRow(title: 'Active',value: snapshot.data!.active.toString(),),
                              ReusableRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                              ReusableRow(title: 'Today Cases',value: snapshot.data!.todayCases.toString(),),
                              ReusableRow(title: 'Today Deaths',value: snapshot.data!.todayDeaths.toString(),),
                              ReusableRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString(),),

                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: MediaQuery.of(context).size.height * .01,),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountryListScreen()));
                    },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green.shade400,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text("Track Countries",style: TextStyle(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      )
                    ],

                  );
                }
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  String title,value;
  ReusableRow({super.key,required this.value,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 4,),
          const Divider()
        ],
      ),
    );
  }
}
