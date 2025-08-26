import 'package:bitebuddie_new_version/core/common/basic_appbar.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/bloc/personalinfo_bloc.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/widgets/my_textfield.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/widgets/circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInformation extends StatefulWidget {
  const MyInformation({super.key});

  @override
  State<MyInformation> createState() => _MyInformationState();
}

class _MyInformationState extends State<MyInformation> {
  final PersonalinfoBloc personalinfoBloc = PersonalinfoBloc();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    personalinfoBloc.add(PersonalInfoFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Personal Information', style: AppTheme.text20Bold),
        backarrowBG: ColorsPalette.black,
      ),
      body: BlocBuilder<PersonalinfoBloc, PersonalinfoState>(
        bloc: personalinfoBloc,
        builder: (context, state) {
          if (state is PersonalinfoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PersonalinfoLoaded) {
            final personalInfoLoaded = state.personalInfoResponse;
            emailController.text = personalInfoLoaded.driver.email;
            phoneController.text = personalInfoLoaded.driver.phone;
            nameController.text = personalInfoLoaded.driver.name;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Center(child: ProfileAvatarPicker()),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    MyTextfield(
                      hintText: 'Enter Your Name',
                      controller: nameController,
                      onSuffixIconPressed: () {
                        nameController.clear();
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    MyTextfield(
                      hintText: 'Enter Your Email',
                      controller: emailController,
                      onSuffixIconPressed: () {
                        emailController.clear();
                      },
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Phone',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 16.h),
                    MyTextfield(
                      hintText: 'Enter Your Phone',
                      controller: phoneController,
                      onSuffixIconPressed: () => phoneController.clear(),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Aadhar Number',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    container(personalInfoLoaded.driver.adharCard),
                    SizedBox(height: 16.h),
                    Text(
                      'Driving License',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.h),
                    Image.network(personalInfoLoaded.driver.drivingLicense),
                  ],
                ),
              ),
            );
          } else if (state is PersonalinfoError) {
            return Center(child: Text(state.errormessage));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget container(String text) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsPalette.appPrime),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(text, style: AppTheme.text14Bold),
    );
  }
}

// import 'package:bitebuddie_new_version/core/common/basic_appbar.dart';
// import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
// import 'package:bitebuddie_new_version/core/theme/themes.dart';
// import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/bloc/personalinfo_bloc.dart';
// import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/my_textfield.dart';
// import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/widgets/circle_avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyInformation extends StatefulWidget {
//   const MyInformation({super.key});

//   @override
//   State<MyInformation> createState() => _MyInformationState();
// }

// class _MyInformationState extends State<MyInformation> {
//   final PersonalinfoBloc personalinfoBloc = PersonalinfoBloc();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();

//   @override
//   void initState() {
//     personalinfoBloc.add(PersonalInfoFetchEvent());
//     super.initState();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BasicAppBar(
//         title: Text('Personal Information', style: AppTheme.text20Bold),
//         backarrowBG: ColorsPalette.black,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(12.0.r),
//           child: BlocBuilder<PersonalinfoBloc, PersonalinfoState>(
//             bloc: personalinfoBloc,
//             builder: (context, state) {
//               if (state is PersonalinfoLoading) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (state is PersonalinfoLoaded) {
//                 final personalInfoLoaded = state.personalInfoResponse;
//                 emailController.text = personalInfoLoaded.driver.email;
//                 phoneController.text = personalInfoLoaded.driver.phone;
//                 nameController.text = personalInfoLoaded.driver.name;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 16.h),
//                     Center(child: ProfileAvatarPicker()),
//                     Text(
//                       'Name',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(height: 8.h),
//                     MyTextfield(
//                       controller: nameController,
//                       onSuffixIconPressed: () {},
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'Email',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(height: 8.h),
//                     MyTextfield(
//                       controller: emailController,
//                       onSuffixIconPressed: () {
//                         emailController.clear();
//                       },
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'Phone',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(height: 16.h),
//                     MyTextfield(controller: phoneController),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'Aadhar Number',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(height: 8.h),
//                     container(personalInfoLoaded.driver.adharCard),
//                     SizedBox(height: 16.h),
//                     Text(
//                       'Driving License',
//                       style: Theme.of(context).textTheme.titleMedium,
//                     ),
//                     SizedBox(height: 8.h),
//                     Image.network(personalInfoLoaded.driver.drivingLicense),
//                   ],
//                 );
//               } else if (state is PersonalinfoError) {
//                 return Center(child: Text(state.errormessage));
//               }
//               return SizedBox.shrink();
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget container(String text) {
//     return Container(
//       width: double.infinity,
//       height: 48.h,
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       alignment: Alignment.centerLeft,
//       decoration: BoxDecoration(
//         border: Border.all(color: ColorsPalette.appPrime),
//         borderRadius: BorderRadius.circular(8.r),
//       ),
//       child: Text(text, style: AppTheme.text14Bold),
//     );
//   }
// }
