import 'package:flutter/material.dart';
import 'package:personal_finance/config/app_theme.dart';
import 'package:personal_finance/settings/providers/accounts_type_provider.dart';
import 'package:provider/provider.dart';

class AccountsTypeWidget extends StatefulWidget {
  const AccountsTypeWidget({super.key});

  @override
  AccountsTypeWidgetState createState() => AccountsTypeWidgetState();
}

class AccountsTypeWidgetState extends State<AccountsTypeWidget> {
  // final currenciesList = AppCurrencies.currencies;

  @override
  Widget build(BuildContext context) {
    final accountTypeList =
        Provider.of<AccountsTypeProvider>(context).fetchAccountTypesList;
    return accountTypeList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          accountTypeList[index].accountTypeName,
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        Text(
                          accountTypeList[index].accountIconName,
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        //Text(String.fromCharCodes(a3)),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            itemCount: accountTypeList.length,
          )
        : Container();
  }
}
