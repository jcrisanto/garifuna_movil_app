import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesFragment extends StatelessWidget {
    
  final Function(String, String) navigateToCategory; 

  final categories = [
    {'title':'Animals', 'group':'Animal'},
    {'title':'Colors', 'group':'Color'},
    {'title':'Months', 'group':'Month'},
    {'title':'Phrases', 'group':'Phrase'},
    {'title':'Numbers', 'group':'Number'},
    {'title':'Family', 'group':'Family'},
    {'title':'Pronouns', 'group':'Pronoun'},
    {'title':'Days', 'group':'Day'}
  ];

  CategoriesFragment(this.navigateToCategory);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 8,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => navigateToCategory(categories[index]['title'], categories[index]['group']),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/icons/pollo.svg',
                  width: 80.0, height: 80.0),
              Text(categories[index]['title']),
            ],
          ),
        );
      },
    );
  }
}
