import 'package:flutter/material.dart';
import 'profile.dart';

class ShowTripPage extends StatefulWidget {
  const ShowTripPage({super.key});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  String selectedCategory = 'ทั้งหมด';
  
  List<Map<String, dynamic>> trips = [
    {
      'title': 'อันซีนสวิตเซอร์แลนด์',
      'subtitle': 'ประเทศสวิตเซอร์แลนด์\nระยะเวลา 10 วัน\nราคา 119900 บาท',
      'price': 'ราคา 119900 บาท',
      'image': 'assets/images/switzerland.jpg',
      'category': 'ยุโรป',
    },
    {
      'title': 'สิงคโปร์ SENTOSA ยูนิเวอร์แซล',
      'subtitle': 'ประเทศสิงคโปร์\nระยะเวลา 4 วัน\nราคา 22999 บาท',
      'price': 'ราคา 22999 บาท',
      'image': 'assets/images/singapore.jpg',
      'category':'เอเชีย',
    },
    {
      'title': 'ดานัง ฮอยอัน เว้ พักบนบานาฮิลล์',
      'subtitle': 'ประเทศเวียดนาม\nระยะเวลา 4 วัน\nราคา 13899 บาท',
      'price': 'ราคา 13899 บาท',
      'image': 'assets/images/danang.jpg',
      'category':'เอเชีย',
    },
    {
      'title': 'หลวงพระบาง',
      'subtitle': 'ประเทศลาว\nระยะเวลา 3 วัน\nราคา 8900 บาท',
      'price': 'ราคา 8900 บาท',
      'image': 'assets/images/laos.jpg',
      'category':'เอเชีย',
    },
    {
      'title': 'กําแพงเบอร์ลิน',
      'subtitle': 'ประเทศเยอรมัน\nระยะเวลา 3 วัน\nราคา 39999 บาท',
      'price': 'ราคา 39999 บาท',
      'image': 'assets/images/germany.jpg',
      'category': 'ยุโรป',
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTrips = trips.where((trip) {
      if (selectedCategory == 'ทั้งหมด') {
        return true;
      }
      return trip['category'] == selectedCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
                if (value == 'profile') {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                    ),
                  );
               } else if (value == 'logout') {
                  Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ปลายทาง',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCategoryButton('ทั้งหมด'),
                  const SizedBox(width: 8),
                  buildCategoryButton('เอเชีย'),
                  const SizedBox(width: 8),
                  buildCategoryButton('ยุโรป'),
                  const SizedBox(width: 8),
                  buildCategoryButton('อาเซียน'),
                  const SizedBox(width: 8),
                  buildCategoryButton('อเมริกา'),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: filteredTrips.length,
                itemBuilder: (context, index) {
                  return buildTripCard(filteredTrips[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    bool isSelected = selectedCategory == category;
    return FilledButton(
      onPressed: () {
        setState(() {
          selectedCategory = category;
        });
      },
      style: FilledButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.grey[300],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(category),
    );
  }

  Widget buildTripCard(Map<String, dynamic>trip) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/switzerland.jpg',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(trip['subtitle']!),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'รายละเอียดเพิ่มเติม',
                        style: TextStyle(color: Colors.white, fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';

class ShowTripPage extends StatefulWidget {
  const ShowTripPage({super.key});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
      ),
      body: Container(),
    );
  }
}*/