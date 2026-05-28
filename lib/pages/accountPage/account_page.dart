import 'package:credit_management/pages/accountPage/widget/account_edit_dialog.dart';
import 'package:credit_management/services/authentication_service.dart';
import 'package:credit_management/widgets/card_button.dart';
import 'package:credit_management/widgets/info_card.dart';
import 'package:credit_management/widgets/lined_title.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  static final authInstance = AuthenticationService.instance;

  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                userInfo: authInstance.userInfo,
                cardColor: const Color.fromARGB(255, 54, 255, 87),
                onSettingsPressed: () async {
                  await AccountEditDialogWidget.show(context);
                },
              ),
              SizedBox(height: 5),
              CardButton(
                text: 'Muốn tốt hơn thì cho mình xin tí bồi bổ',
                onPressed: () {},
              ),
              SizedBox(height: 20),
              LinedTitle(title: 'Đóng góp ý kiến'),
              SizedBox(height: 5),
              CardButton(
                text: 'Có gì thì bạn cứ đóng góp, đừng ngại',
                onPressed: () {},
                buttonColor: Colors.amber,
                fontSize: 16,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
