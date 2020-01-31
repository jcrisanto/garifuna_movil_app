import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesFragment extends StatelessWidget {
    
  Function(String) navigateToCategory; 

  var categories = [
    'Animals',
    'Colors',
    'Months',
    'Phrases',
    'Numbers',
    'Family',
    'Pronouns',
    'Days'
  ];

  CategoriesFragment(this.navigateToCategory) {
      
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 8,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => navigateToCategory(categories[index]),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/icons/pollo.svg',
                  width: 80.0, height: 80.0),
              Text(categories[index]),
            ],
          ),
        );
      },
    );
  }
}
