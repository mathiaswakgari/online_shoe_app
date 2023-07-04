import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shoe_app/views/shared/app_style.dart';

class ShoeCard extends StatefulWidget {
  const ShoeCard(
      {
        Key? key,
        required this.price,
        required this.category,
        required this.id,
        required this.name,
        required this.image}) : super(key: key);

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ShoeCard> createState() => _ShoeCardState();
}

class _ShoeCardState extends State<ShoeCard> {
  bool selected = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 29, 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0XFFEBEEEF),
                  spreadRadius: 1,
                  blurRadius: 0.6,
                  offset: Offset(1, 1)
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(widget.image))
                      ),
                    ),
                    Positioned(
                      right: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: (){},
                          child: const Icon(CupertinoIcons.heart),
                        ))
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: appStyleTwo(16, 1.1, Colors.black, FontWeight.bold)),
                        Text(widget.category, style: appStyleTwo(18, 1.5, Colors.grey, FontWeight.bold)),
                      ],
                    ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          widget.price,
                          style: appStyle(30, Colors.black, FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "Color",
                            style: appStyle(18, Colors.grey, FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ChoiceChip(
                              label: const Text(""),
                              selected: selected,
                              visualDensity: VisualDensity.compact,
                              selectedColor: Colors.black,
                          )
                        ],
                      )

                    ],
                  ),

                )
              ],
            ),
          ),
        ),
    );
  }
}
