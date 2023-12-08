import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../config/app_theme.dart';
import '/utils/date_utils.dart';
import '../providers/goal_deposits_provider.dart';

class GoalDepositsWidget extends StatelessWidget {
  final appStrings, lang;
  const GoalDepositsWidget(this.appStrings, this.lang, {super.key});

  @override
  Widget build(BuildContext context) {
    final depositsList =
        Provider.of<GoalDepositsProvider>(context).fetchGoalIdDepositsList;
    return Column(
      children: [
        Text(
          appStrings['goal-deposits'],
          style: appPrimaryTheme().textTheme.titleMedium,
        ),
        const SizedBox(
          height: 5,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: depositsList.length,
            itemBuilder: (context, index) {
              return Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),

                // The start action pane is the one at the left or the top side.
                startActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),

                  // A pane can dismiss the Slidable.
                  dismissible: DismissiblePane(onDismissed: () {}),

                  // All actions are defined in the children parameter.
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    /*   SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ), */
                  ],
                ),

                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    /*   SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (context) {},
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ), */
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: const Color(0xFF0392CF),
                      foregroundColor: Colors.white,
                      icon: Icons.save,
                      label: appStrings['save'],
                    ),
                  ],
                ),
                child: Card(
                  elevation: 5,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹ ${depositsList[index].depositAmount}',
                          style: appPrimaryTheme().textTheme.bodyLarge,
                        ),
                        Text(
                          DateUtil.getPrettyDate(
                              depositsList[index].depositDate),
                          style: appPrimaryTheme().textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
      ],
    );
  }
}
