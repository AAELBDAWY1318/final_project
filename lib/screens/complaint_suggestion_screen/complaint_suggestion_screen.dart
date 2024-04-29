import 'dart:developer';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/complaint_bloc/complaint_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/screens/complaint_suggestion_details_screen/complaint_suggestion_screen.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/case_ticket.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:complaint_repository/complaint_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintSuggestionScreen extends StatelessWidget {
  const ComplaintSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocale.of(context).loadLang();
    return BlocProvider<ComplaintBloc>(
      create: (context) =>
          ComplaintBloc(complaintRepository: FirebaseComplaintRepository())
            ..add(
              const GetComplaint(),
            ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Back(),
                  SecondDefaultText(text: getLang(context, "complaints")!),
                  BlocBuilder<ComplaintBloc, ComplaintState>(
                    builder: (context, state) {
                      if (state is GetComplaintProcess) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: MyColors.myBlue,
                          ),
                        );
                      } else if (state is GetComplaintSuccess) {
                        if (state.complaints.isNotEmpty) {
                          log("${state.complaints}");
                          return ListView.separated(
                            shrinkWrap: true,
                              physics:const ScrollPhysics(),
                              itemBuilder: (context , index){
                                return CaseTicket(
                                  name: state.complaints[index].title,
                                  id: state.complaints[index].phone,
                                  description: state.complaints[index].description,
                                  onTap: (){
                                    Complaint complaint = state.complaints[index];
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=> ComplaintSuggestionDetailsScreen(complaint: complaint,))
                                    );
                                  },
                                );
                              },
                              separatorBuilder: (context , index)=> const SizedBox(height: 5.0,),
                              itemCount: state.complaints.length);
                        } else {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(70.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/empty.png',
                                    height: 100,
                                  ),
                                  const SizedBox(height: 20.0,),
                                  Text(
                                    getLang(context, "empty")!,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        return Center(
                          child: Image.asset(
                            'assets/images/failure.png',
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
