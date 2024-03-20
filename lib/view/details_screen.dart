import 'package:covid_19_app/view/worlds_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DetailScreen extends StatefulWidget {
  String name,image;
  int totalCases,totalRecovered,totalDeaths,active,critical,todayRecovered,test;
   DetailScreen({super.key,
    required this.name,
    required this.todayRecovered,
    required this.critical,
    required this.active,
    required this.image,
    required this.test,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B2A2B),
appBar: AppBar(
  leading: InkWell(
    onTap: (){
      Navigator.pop(context);
    },
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: const Icon(CupertinoIcons.left_chevron,color: Colors.white,size: 30,),
      )),
  automaticallyImplyLeading: false,
  actions: [

  ],
  title: Padding(
    padding:  EdgeInsets.only(left: 3),
    child: Text(widget.name,style: const TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      fontFamily: AutofillHints.creditCardExpirationDate,
      fontStyle: FontStyle.normal
    ),),
  ),
  centerTitle: true,
  backgroundColor: Color(0xff2B2A2B),
),
      body:  SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:EdgeInsets.only(top: MediaQuery.of(context).size.height *.067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableRow( title: 'Cases',value: widget.totalCases.toString(),),
                        ReusableRow( title: 'Active',value: widget.active.toString(),),
                        ReusableRow( title: 'Recovered',value: widget.totalRecovered.toString(),),
                        ReusableRow( title: 'Death',value: widget.totalDeaths.toString(),),
                        ReusableRow( title: 'Critical',value: widget.critical.toString(),),
                        ReusableRow( title: 'Today Recovered',value: widget.totalRecovered.toString(),),

                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
