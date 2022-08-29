import 'package:disasteravert/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:disasteravert/services/sensordata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




Stream<List<GasSensor>> readData()=> FirebaseFirestore.instance.collection('SensorData').orderBy("time",descending: true).limit(5)
.snapshots().map((snapshot) =>
snapshot.docs.map((doc) {
  //print(doc.data());
  return GasSensor.fromJson(doc.data());}).toList());

class loading extends StatefulWidget {
  const loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}





int flag=0;
class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<GasSensor>>(
          stream: readData(),
          builder: (context,snapshot)
          {
            if(snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            }
            else if (snapshot.hasData && snapshot.data!.length>0) {
              String output_message;
              final data=snapshot.data![0];
              //print(data.SensorData);
              //print('hellooooooooooooooooo');
              if(data.SensorData <400) {

                  flag=0;

                output_message = 'Everything looks fine at the moment';
              }
              else {


                  flag=1;

                output_message =
                'Some dangerous gas is leaking at your place. Please take immediate action.';
              }
              String bgImage=flag==0?'safe.jpg':'gasleak.jpg';
              //print(bgImage);
              return Scaffold(
                  backgroundColor: Colors.grey[300],
                  appBar: AppBar(
                    title:Text('Your Gas Sensor'),
                    centerTitle: true,
                    backgroundColor: flag==0?Colors.blue[600]:Colors.red[900],
                  ),
                  body: Padding(
                          padding: EdgeInsets.fromLTRB(8, 12, 6, 0),
                            child: Column(
                              children:<Widget>[
                                Text(
                                '$output_message',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: flag==0?FontWeight.normal:FontWeight.bold,
                                  color: flag==1?Colors.red[800]:Colors.black,
                                ),
                              ),
                                SizedBox(height: 15,),
                                Text(
                                    'The last 5 recorded data from the sensor is',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 20),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                    itemBuilder: (context , index){
                                      //print(snapshot.data![index].SensorData);
                                      //print((snapshot.data![index].SensorData*255)~/350);
                                    return Padding(

                                      padding: EdgeInsets.symmetric(vertical: 2,horizontal: 6),
                                      child: Card(
                                        child: ListTile(
                                          leading: ClipRRect(
                                            child: Container(
                                              height: 30.0,
                                              width: 30.0,
                                              color: snapshot.data![index].SensorData <350?Color.fromRGBO(0,(snapshot.data![index].SensorData*255)~/350 , 0, 0.9):
                                              Color.fromRGBO((snapshot.data![index].SensorData*255)~/750,0 , 0, 0.9)
                                              ,

                                            ),
                                          ),
                                          title: Text(
                                              '${snapshot.data![index].SensorData}',
                                          ),
                                          subtitle: Text('${DateTime.fromMillisecondsSinceEpoch(snapshot.data![index].time * 1000)}'),
                                        ),
                                      ),
                                    );
                                    }
                                )




                    ]
                            )
                        ),




                );

            }
            else{
              return Center(

                child: Container(
                  color: Colors.blue[400],
                  child: SpinKitRotatingCircle(
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              );

            }
          },

        );

  }
}

class GasSensor{
  int SensorData;
  int time;
  GasSensor({ required this.SensorData, required this.time });

  static GasSensor fromJson(Map<String,dynamic> json) =>
      GasSensor(
        SensorData:json['SensorData'],
        time: json['time']
      );
}