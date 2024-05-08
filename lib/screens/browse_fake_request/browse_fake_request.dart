import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/screens/request_details_screen/request_details_screen.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

class BrowseFakeRequests extends StatelessWidget {
  const BrowseFakeRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestBloc>(
      create: (BuildContext context) => RequestBloc(
        requestRepository: FirebaseRequestRepository(),
      )..add(GetFakeRequest()),
      child:BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state){
          if(state is GetFakeRequestsProcess){
            return const Center(
              child: LoadingAnimation(),
            );
          }else if(state is GetFakeRequestsSuccess){
            return buildSuccessCase(state.list, context);
          }else{
            return Image.asset('assets/images/failure.png');
          }
        },
      ) ,
    );
  }

  //build success loaded data method
  Widget buildSuccessCase(List<Request> requests , BuildContext context){
    if(requests.isNotEmpty){
      return ListView.separated(
        itemCount: requests.length,
        separatorBuilder: (context , index){
          return const SizedBox(height: 10.0,);
        },
        itemBuilder:(context , index)=> CaseTicket(
          name: requests[index].name,
          id: requests[index].nationalId,
          description: requests[index].description,
          onTap: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context)=>RequestDetailsScreen(
                request: requests[index],
              )),
            );
          },
        ),
      );
    }else{
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ai.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              getLang(context, "empty")!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
  }
}

