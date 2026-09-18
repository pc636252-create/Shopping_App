import 'package:danger_now/View/Favourite/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Favorites extends StatelessWidget {
   Favorites({super.key});

  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOVL6hB9YFj5iXpQHGfNi3FpkPzpMqnJffZsCJdsEY5g&s=10',
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtQuQT9rwEYK_0JmB0OSq6VU1wEcZP9qptoCAs3h3jvg&s=10"
     "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_mZOg6I9aF9g2Xex6SVSL8f2hiEiQZL88fnSrj8rbhw&s=10"
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN_jJlx0_LpMlvC-Q4UQl1QDvoskdJqxJtyQIsatc7dQ&s=10"
  ];

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.put(FavoriteController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(20)),
              const SizedBox(height: 15),
              Text("What you do want"),
              const SizedBox(height: 15),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CarouselSlider.builder(
                        itemCount: imgList.length,
                        options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            controller.updateIndex(index);
                          },
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: DecorationImage(
                                image: NetworkImage(imgList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: controller.currentIndex.value == index ? 20.0 : 8.0,
                          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: controller.currentIndex.value == index
                                ? BoxShape.rectangle
                                : BoxShape.circle,
                            borderRadius: controller.currentIndex.value == index
                                ? BorderRadius.circular(8.0)
                                : null,
                            color: controller.currentIndex.value == index
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),

              // const ImageSection(),
              const TitleSection(
                name: 'Oeschinen Lake Campground',
                location: 'Kandersteg, Switzerland',
              ),
              const ButtonSection(),
              const TextSection(
                description:
                'Lake Oeschinen lies at the foot of the Blüemlisalp in the '
                    'Bernese Alps. Situated 1,578 meters above sea level, it '
                    'is one of the larger Alpine Lakes. A gondola ride from '
                    'Kandersteg, followed by a half-hour walk through pastures '
                    'and pine forest, leads you to the lake, which warms to 20 '
                    'degrees Celsius in the summer. Activities enjoyed here '
                    'include rowing, and riding the summer toboggan run.',
              ),
            ],
          ),
        ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(location, style: TextStyle(color: Colors.grey[500])),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const Text('41'),
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.call),color: color,),Text("CALL",style:TextStyle(color: color)),
            ],
          ),
          Column(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.near_me),color: color),Text("ROUTE",style:TextStyle(color: color)),
            ],
          ),
          Column(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.share),color: color),Text("Share",style:TextStyle(color: color)),
            ],
          ),
        ],
      ),
    );
  }
}

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Text(description, softWrap: true),
    );
  }
}

class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  // final String image;

  @override
  Widget build(BuildContext context) {
    return Image.network("https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8=",
        width: MediaQuery.of(context).size.width,
        height: Get.height* 0.3,
        fit: BoxFit.cover);
  }
}

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          child: IconButton(
            padding: const EdgeInsets.all(0),
            alignment: Alignment.center,
            icon: (_isFavorited
                ? const Icon(Icons.star)
                : const Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(width: 18, child: SizedBox(child: Text('$_favoriteCount'))),
      ],
    );
  }
}
