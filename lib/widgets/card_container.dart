import 'package:auth_firebase/provider/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({super.key, required this.child});


  @override
  Widget build(BuildContext context) {

    final UiProvider uiProvider = Provider.of<UiProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(20),
        height: uiProvider.selectedMenuOpt == 0? 420 :  620,
        decoration: _createCardShape(),
        child: child,
      ),
    );
  }

  BoxDecoration _createCardShape() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15,
          offset: Offset(0, 5)
        )
      ]
    );
  }
}