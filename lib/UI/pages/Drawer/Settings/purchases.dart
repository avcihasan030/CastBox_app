import 'package:flutter/material.dart';

// class Purchases extends StatefulWidget {
//   @override
//   _PurchasesState createState() => _PurchasesState();
// }
//
// class _PurchasesState extends State<Purchases> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   // Kredi kartı bilgilerini tutan değişkenler
//   String cardNumber = "";
//   String expiryDate = "";
//   String cardHolderName = "";
//   String cvvCode = "";
//   bool isCvvFocused = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Kredi Kartı Örneği'),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: CreditCardWidget(
//                   bankName: 'Bank of America',
//                   width: 375,
//                   height: 220,
//                   cardNumber: cardNumber,
//                   expiryDate: expiryDate,
//                   cardHolderName: cardHolderName,
//                   cvvCode: cvvCode,
//                   showBackView: isCvvFocused,
//                   onCreditCardWidgetChange: (CreditCardBrand) {},
//                   labelValidThru: 'VALID\nTHRU',
//                   // CVV kodu ekranı mı gösterilsin?
//                   ),
//             ),
//             Expanded(
//               child: CreditCardForm(
//                 onCreditCardModelChange: onCreditCardModelChange,
//                 cardNumber: '12344567897418520',
//                 cardHolderName: 'HASAN AVCI',
//                 expiryDate: '01/28',
//                 cvvCode: '825',
//                 formKey: formKey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
// }
///
// class CreditCardWidget extends StatelessWidget {
//   final String cardNumber;
//   final String cardHolder;
//   final String expiryDate;
//   final String cardType;
//
//   CreditCardWidget({
//     required this.cardNumber,
//     required this.cardHolder,
//     required this.expiryDate,
//     required this.cardType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300,
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             cardNumber,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20.0,
//               letterSpacing: 4.0,
//             ),
//           ),
//           const Spacer(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 cardHolder,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.0,
//                 ),
//               ),
//               Text(
//                 expiryDate,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16.0,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             cardType,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CreditCardWidget extends StatefulWidget {
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final String cvv;
  final String cardType;

  CreditCardWidget({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
    required this.cardType,
  });

  @override
  _CreditCardWidgetState createState() => _CreditCardWidgetState();
}

class _CreditCardWidgetState extends State<CreditCardWidget> {
  bool showFront = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showFront = !showFront;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: showFront,
              child: Text(
                widget.cardNumber,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  letterSpacing: 4.0,
                ),
              ),
            ),
            Visibility(
              visible: !showFront,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 268,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      child: Text('cvv: ${widget.cvv}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: showFront,
                  child: Text(
                    widget.cardHolder,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Visibility(
                  visible: showFront,
                  child: Text(
                    widget.expiryDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Visibility(
              visible: showFront,
              child: Text(
                widget.cardType,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Purchases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CreditCardWidget(
              cardNumber: '**** **** **** 1234',
              cardHolder: 'John Doe',
              expiryDate: '12/23',
              cardType: 'MasterCard', cvv: '825',
            ),
          ),
        ],
      ),
    );
  }
}