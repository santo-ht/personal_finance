import 'package:flutter/material.dart';
import 'package:personal_finance/accounts/providers/accounts_provider.dart';
import 'package:provider/provider.dart';

class AccountsWidget extends StatefulWidget {
  final appStrings, lang;
  const AccountsWidget(this.appStrings, this.lang, {super.key});

  @override
  State<AccountsWidget> createState() => AccountsWidgetState();
}

class AccountsWidgetState extends State<AccountsWidget> {
  @override
  Widget build(BuildContext context) {
    final accountsList =
        Provider.of<AccountsProvider>(context).fetchAccountsQueryList;
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
      child: ListView.builder(
          itemCount: accountsList.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: Colors.black87,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountsList[index].accountName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            accountsList[index].accountTypeName,
                            style: const TextStyle(
                              color: Colors.white,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        accountsList[index].balanceAmount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            );
          }),
    ));
  }
}
