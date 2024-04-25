import 'package:charity/blocs/request_bloc/request_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/request_details_screen/request_details_screen.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';

class BrowseRequests extends StatelessWidget {
  const BrowseRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestBloc>(
      create: (BuildContext context) => RequestBloc(
        requestRepository: FirebaseRequestRepository(),
      )..add(GetRealRequests()),
      child:BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state){
          if(state is GetRealRequestsProcess){
            return Center(
              child: CircularProgressIndicator(
                color: MyColors.myBlue,

              ),
            );
          }else if(state is GetRealRequestsSuccess){
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
    SizeConfig sizeConfig = SizeConfig()..init(context);
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
        child: Image.asset(
          'assets/images/empty.png',
          fit: BoxFit.cover,
          width: sizeConfig.screenWidth! *0.3,
        ),
      );
    }
  }
}

