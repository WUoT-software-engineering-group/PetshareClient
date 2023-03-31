import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pet_share/announcementPage/labeled_icon.dart';
import 'package:pet_share/utils/app_colors.dart';

class PetTile extends StatefulWidget {
  final int index;

  const PetTile(this.index, {Key? key}) : super(key: key);

  @override
  State<PetTile> createState() => _PetTileState();
}

class _PetTileState extends State<PetTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5, horizontal: 25),
      child: Slidable(
        // delete and edit action on tile
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: null,
              icon: Icons.delete,
              backgroundColor: (AppColors.smallElements['reddish'])!,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            SlidableAction(
              onPressed: null,
              icon: Icons.edit,
              backgroundColor: AppColors.tile[0],
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            )
          ],
        ),

        child: Material(
          elevation: 6,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              height: 300,
              child: Column(
                children: [
                  // picture of animal
                  Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/pupic.jpg'))),
                      )),

                  // description of announcement
                  const Expanded(
                    flex: 2,
                    child: DescriptionTile(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionTile extends StatelessWidget {
  const DescriptionTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 12, 25, 5),
      child: Row(
        children: [
          /* 1 */
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* 2 */
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        const TextSpan(
                          text: 'Reksio',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '    3 years old',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColors.smallElements['reddish'],
                        size: 15,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '20 March 2023',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: const [
                      LabeledIcon(Icons.male, 'Male'),
                      LabeledIcon(Icons.sports_baseball_outlined, 'Sporty'),
                    ],
                  )
                ],
              )),
          VerticalDivider(
            thickness: 2,
            indent: 10,
            endIndent: 10,
            color: Colors.grey[300],
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mail_outline,
                    size: 30, color: AppColors.smallElements['reddish']),
                const Text('0', style: TextStyle(fontSize: 16))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
