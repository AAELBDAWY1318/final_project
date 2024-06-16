import 'dart:developer';
import 'dart:io';

import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/ml_bloc/ml_bloc.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/ml_model/ml_model.dart';
import 'package:charity/widgets/animated_text.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/camera_component.dart';
import 'package:charity/widgets/default_material_button.dart';
import 'package:charity/widgets/failure_dialog.dart';
import 'package:charity/widgets/loading_dialog.dart';
import 'package:charity/widgets/second_default_text.dart';
import 'package:charity/widgets/show_image_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class FakeIdDetection extends StatefulWidget {
  const FakeIdDetection({super.key});

  @override
  State<FakeIdDetection> createState() => _FakeIdDetectionState();
}

class _FakeIdDetectionState extends State<FakeIdDetection> {
  String imagePath = '';
  late String prediction;

  bool flag = false;

  Future<String> _pickImage(ImageSource source) async {
    String imagePath = '';
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      }
    });
    return imagePath;
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: MyColors.myBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () async {
                    imagePath = await _pickImage(ImageSource.camera);
                    log(imagePath);
                    setState(() {});
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 50.0,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    imagePath = await _pickImage(ImageSource.gallery);
                    log(imagePath);
                    setState(() {});
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Icon(
                      Icons.photo,
                      size: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MlBloc>(
      create: (context) => MlBloc(mlLogic: MLLogic()),
      child: BlocConsumer<MlBloc, MlState>(
        listener: (context, state) {
          if (state is IDDetectionProcessing) {
            showDialog(
                context: context, builder: (context) => const LoadingDialog());
          } else if (state is IDDetectionFailure) {
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) => FailureDialog(onPressed: () {
                      Navigator.pop(context);
                    }));
          } else if (state is IDDetectionSuccess) {
            int x = state.prediction;
            if (x == 0) {
              prediction = getLang(context, "f")!;
              flag = false;
            } else {
              prediction =getLang(context, "r")!;
              flag = true;
            }
            Navigator.pop(context);
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 200.0,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/ai.png',
                            height: 100.0,
                          ),
                          const SizedBox(height: 10.0,),
                          AnimatedTextWriter(
                            text: prediction,
                            onTextWritingDone: (flag){},
                            color: flag == true ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            imagePath = '';
                          });
                        },
                        child:
                        Text(getLang(context, "OK")!),
                      ),
                    ],
                  );
                });
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40.0,
                            ),
                            SecondDefaultText(
                              text: getLang(context, "test")!,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            imagePath.isEmpty
                                ? Center(
                                    child: CameraComponent(
                                      text: getLang(context, "image")!,
                                      onTap: () {
                                        showBottomSheet(context);
                                      },
                                    ),
                                  )
                                : Center(
                                    child:
                                        ShowImageFile(file: File(imagePath))),
                            const SizedBox(
                              height: 10.0,
                            ),
                            DefaultMaterialButton(
                              text: getLang(context, "Continue")!,
                              textColor: Colors.white,
                              buttonColor: MyColors.myBlue,
                              function: () {
                                if (imagePath.isNotEmpty) {
                                  context.read<MlBloc>().add(
                                        DetectFakeIdEvent(
                                          imageFile: File(imagePath),
                                        ),
                                      );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(getLang(
                                              context, "select image")!),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child:
                                                  Text(getLang(context, "OK")!),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Center(
                              child: Container(
                                height: 250.0,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [MyColors.myBlue , Colors.white],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: Image.asset(
                                  'assets/images/ai.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Back(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
