import 'package:credit_management/src/models/card_model.dart';
import 'package:credit_management/src/subpages/card_detail/card_detail_page.dart';
import 'package:credit_management/src/widgets/confirm_dialog.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final CardModel card;
  final VoidCallback onDelete;
  const CreditCard({super.key, required this.card, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    String dateTimeString = card.expiryDate != null
        ? "${card.expiryDate!.month.toString().padLeft(2, '0')}/${card.expiryDate!.year.toString().substring(2)}"
        : 'MM/YY';

    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: Container(
            decoration: BoxDecoration(
              // Phải khớp bo góc với Card bên trong
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
                side: BorderSide(width: 4),
              ),
              clipBehavior: Clip
                  .antiAlias, // Giúp hình ảnh bên trong cũng được bo góc theo Card
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CardDetailPage(card: card),
                    ),
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nội dung văn bản
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        10.0,
                        16.0,
                        10.0,
                      ),
                      child: Stack(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: double.infinity,
                              minHeight: 140,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Title(
                                  color: Colors.black,
                                  child: Text(
                                    '${card.bankName} ${card.cardName}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      card.number ?? '**** **** **** 4444',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      "Valid: $dateTimeString",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                    if (card.cardService != null &&
                                        card.cardService == 'Visa')
                                      Image.asset(
                                        'assets/icon/visa.png',
                                        width: 50,
                                      ),
                                    if (card.cardService != null &&
                                        card.cardService == 'Mastercard')
                                      Image.asset(
                                        'assets/icon/mastercard.png',
                                        width: 50,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: IconButton(
                              onPressed: () {
                                ConfirmDialogWidget.show(
                                  context,
                                  title: 'Xác nhận xóa thẻ',
                                  message:
                                      'Bạn có chắc chắn muốn xóa thẻ này không?',
                                  onConfirm: onDelete,
                                );
                              },
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: const Color.fromARGB(255, 133, 19, 19),
                                size: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
