import 'package:covid_19_app/services/states_services.dart';
import 'package:covid_19_app/view/details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStatesViewModel worldStatesViewModel = WorldStatesViewModel();
    return Scaffold(
      backgroundColor: Color(0xff2B2A2B),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 340),
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
                child: const Icon(CupertinoIcons.left_chevron,size: 30,color: Colors.white,)),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xff2B2A2B),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                style: const TextStyle(
                  color: Colors.white
                ),
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: 'Search with country name',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                  prefixIcon: const Icon(CupertinoIcons.search,size: 30,color: Colors.white,),
                ),

              ),
            ),
            Expanded(child: FutureBuilder(
              future: worldStatesViewModel.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context,index){
                        return Shimmer.fromColors(
                             baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(

                                leading: Container(
                                  height: 50,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 50,
                                  color: Colors.white,
                                )
                              ),
                            ],
                          )
                        );

                      });
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                      String name = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],

                                )));
                        },
                              child: ListTile(

                                leading: Image(
                                  height:50,
                                  width: 50,
                                  image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag']
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'],style: TextStyle(
                                    color: Colors.white
                                ),),
                                subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          ],
                        );

                      }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country'],
                                  active: snapshot.data![index]['active'],
                                  critical: snapshot.data![index]['critical'],
                                  test: snapshot.data![index]['tests'],
                                  todayRecovered: snapshot.data![index]['todayRecovered'],
                                  totalCases: snapshot.data![index]['cases'],
                                  totalDeaths: snapshot.data![index]['deaths'],
                                  totalRecovered: snapshot.data![index]['recovered'],

                                )));
                        },
                              child: ListTile(

                                leading: Image(
                                  height:50,
                                  width: 50,
                                  image: NetworkImage(
                                      snapshot.data![index]['countryInfo']['flag']
                                  ),
                                ),
                                title: Text(snapshot.data![index]['country'],style: TextStyle(
                                    color: Colors.white
                                ),),
                                subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(
                                    color: Colors.white
                                ),),
                              ),
                            ),
                          ],
                        );

                      }
                      else{
                        return Container();

                      }

                  });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
