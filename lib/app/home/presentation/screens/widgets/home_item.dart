import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    required this.label,
    required this.header,
    this.onTap
  }) : super(key: key);

  final Widget header;
  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: size.width * 0.4,
        width: size.width * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: MaterialButton(
          onPressed: onTap ?? () {

          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              header,
              const SizedBox(height: 16),
              Text(
                label,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}