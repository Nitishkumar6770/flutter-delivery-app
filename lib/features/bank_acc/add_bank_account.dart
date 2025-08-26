import 'package:bitebuddie_new_version/core/common/buttons/custom_elevated_button.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/widgets/my_textfield.dart';
import 'package:bitebuddie_new_version/features/profile/pages/view_activity_page.dart/activity_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({super.key});

  @override
  State<AddBankAccount> createState() => _AddBankAccountState();
}

class _AddBankAccountState extends State<AddBankAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: ColorsPalette.lightray,
        backgroundColor: ColorsPalette.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(


                context,
                PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: ViewActivityPage(),
                  duration: Duration(milliseconds: 500),
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsPalette.black,
              ),
              padding: EdgeInsets.all(8),
              child: Icon(Icons.arrow_back, color: ColorsPalette.white),
            ),
          ),
        ),
        title: Text(
          'Add Bank Account',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Account holder name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              MyTextfield(),
              SizedBox(height: 16),
              Text('Bank name', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8),
              buildBankNameTextField(),
              SizedBox(height: 16),
              Text(
                'Account number',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8),
              MyTextfield(),
              SizedBox(height: 16),
              Text('IFSC code', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 8),
              MyTextfield(),
              SizedBox(height: 32),
              CustomElevatedButton(
                buttonText: 'Submit & Link Account',
                color: ColorsPalette.red,
                onPressed: () {},
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '🛡️ Your bank details are encrypted and securely stored.',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBankNameTextField() {
  return TextField(
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: 'Enter your bank name',
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      suffixIcon: PopupMenuButton<String>(
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        onSelected: (value) {},
        itemBuilder:
            (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>( value: 'HDFC', child: Text('HDFC')),
              const PopupMenuItem<String>(value: 'SBI', child: Text('SBI')),
              const PopupMenuItem<String>(value: 'AXIS', child: Text('AXIS')),
              const PopupMenuItem<String>(value: 'ICICI', child: Text('ICICI')),
              const PopupMenuItem<String>(value: 'PNB', child: Text('PNB')),
            ],
      ),
    ),
  );
}
