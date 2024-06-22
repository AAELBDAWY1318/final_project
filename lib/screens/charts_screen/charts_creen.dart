import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/payment_donations_bloc/payment_donations_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/banner_item.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:donation_repository/scr/firebase_donation_repos.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> numbers = [90.0, 200.0, 30.0, 400.0, 50.0, 60.0];


    return BlocProvider<PaymentDonationsBloc>(
  create: (context) => PaymentDonationsBloc(
    FirebaseDonationRepository(),
  )..add(
      GetChartDataEvent(),
  ),
  child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
            children:[
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image.asset(
                  'assets/images/myLogo.png',
                  height:60.0,
                ),
              ),
              const SizedBox(width: 10.0,),
              Text(
                getLang(context , "help hand")!,
                style:const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SecondDefaultText(text: getLang(context, "charts")!),
              const SizedBox(height: 10.0,),
              SizedBox(
                height: 150.0,
                child: BannerItem(
                  text: getLang(context , "banner4")!,
                  image: "assets/images/banner4.png",
                ),
              ),
              const SizedBox(height: 10.0,),
              const SizedBox(height: 10.0,),
              BlocBuilder<PaymentDonationsBloc , PaymentDonationsState>(
                builder: (context , state){
                  if(state is GetChartsDataFailure){
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/failure.png',
                            height: 120.0,
                          ),
                          const SizedBox(height: 10.0,),
                          Text(
                            getLang(context , "failure")!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }else if (state is GetChartsDataSuccess){
                    numbers[0] = state.data["All"]!;
                    numbers[1] = state.data["campaigns"]!;
                    numbers[2] = state.data["Students"]!;
                    numbers[3] = state.data["Poor"]!;
                    numbers[4] = state.data["Windows"]!;
                    numbers[4] = state.data["Debtors"]!;
                    double allAmount = state.data["amount"]!;
                    return  Column(
                      children: [
                        MyBarChart(numbers),
                        Text(
                          getLang(context , "a")!,
                          style:const TextStyle(
                            fontSize:16.0,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$allAmount',
                          style:const TextStyle(
                            fontSize:16.0,
                            fontWeight:FontWeight.bold,
                            color:Colors.grey,
                          ),
                        ),
                        Row(
                          children:[
                            CircleAvatar(
                              backgroundColor: MyColors.myBlue,
                              radius: 10.0,
                            ),
                            Text(
                              '${getLang(context, "All")!} : ',
                              style:const TextStyle(
                                fontSize:16.0,
                                fontWeight:FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${numbers[0]}',
                              style:const TextStyle(
                                fontSize:16.0,
                                fontWeight:FontWeight.bold,
                                color:Colors.grey,
                              ),
                            ),
                          ]
                        ),
                        Row(
                            children:[
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 10.0,
                              ),
                              Text(
                                '${getLang(context, "campaigns")!} : ',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${numbers[1]}',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                  color:Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children:[
                              const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 10.0,
                              ),
                              Text(
                                '${getLang(context, "Students")!} : ',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${numbers[2]}',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                  color:Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children:[
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 10.0,
                              ),
                              Text(
                                '${getLang(context, "Poor")!} : ',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${numbers[3]}',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                  color:Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children:[
                              const CircleAvatar(
                                backgroundColor: Colors.purple,
                                radius: 10.0,
                              ),
                              Text(
                                '${getLang(context, "Widows")!} : ',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${numbers[4]}',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                  color:Colors.grey,
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children:[
                              const CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 10.0,
                              ),
                              Text(
                                '${getLang(context, "Debtors")!} : ',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${numbers[5]}',
                                style:const TextStyle(
                                  fontSize:16.0,
                                  fontWeight:FontWeight.bold,
                                  color:Colors.grey,
                                ),
                              ),
                            ]
                        ),
                      ],
                    );
                  }else{
                    return const Center(
                      child: LoadingAnimation(),
                    );
                  }
                },
              ),
              //MyBarChart(numbers),
            ],
          ),
        ),
      ),
    ),
);
  }

}
class MyBarChart extends StatelessWidget {
  final List<double> data;

  const MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = [MyColors.myBlue , Colors.red , Colors.green , Colors.grey , Colors.purple , Colors.amber];
    return AspectRatio(
      aspectRatio: 1.5,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: data.reduce((value, element) => value > element ? value : element) + 10,
          barTouchData: BarTouchData(
            enabled: false,
          ),

          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (value) => true,
            getDrawingHorizontalLine: (value) => const FlLine(
              color: Colors.grey,
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
          ),
          barGroups: data.asMap().entries.map((entry) {
            int index = entry.key;
            double value = entry.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(toY: value == 0? 5 : value , width: 25, color: colors[index]),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
