import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garifuna_movil_app/models/selection.dart';

class CategoriesFragment extends StatelessWidget {
  final Function(String, String) navigateToCategory;

  final List<Selection> categories = [
    Selection('Animals', 'Animal'),
    Selection('Colors', 'Color'),
    Selection('Months', 'Month'),
    Selection('Phrases', 'Phrase'),
    Selection('Numbers', 'Number'),
    Selection('Family', 'Family'),
    Selection('Pronouns', 'Pronoun'),
    Selection('Days', 'Day')
  ];

  CategoriesFragment(this.navigateToCategory);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => navigateToCategory(
                categories[index].title, categories[index].group),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: SvgPicture.asset('assets/icons/pollo.svg')),
                Text(categories[index].title),
              ],
            ),
          ),
        );
      },
    );
  }
}
