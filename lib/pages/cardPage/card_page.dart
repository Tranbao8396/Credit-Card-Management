import 'package:credit_management/pages/cardPage/card_page_logic.dart';
import 'package:credit_management/pages/cardPage/widgets/card_dialog.dart';
import 'package:credit_management/services/authentication_service.dart';
import 'package:credit_management/widgets/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final authInstance = AuthenticationService.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageLogic(),
      child: Consumer<HomePageLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                        child: Title(
                          color: Colors.black,
                          child: Text(
                            'Chào em, ${authInstance.userInfo?.displayName ?? 'User'}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          authInstance.signOut(context);
                        },
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: double.infinity),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                          child: Column(
                            children: [
                              if (state.cards.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Bạn chưa có thẻ nào. Hãy thêm thẻ để quản lý tài chính của bạn!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              else
                                ...state.cards.map(
                                  (card) => CreditCard(
                                    card: card,
                                    onDelete: () async {
                                      await logic.deleteCard(context, card.id!);
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () async {
                      final res = await CardDialogWidget.show(context);
                      if (res == true) {
                        await logic.getCards();
                      }
                    },
                    shape: CircleBorder(side: BorderSide(width: 3)),
                    child: Icon(Icons.add, size: 30, color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
