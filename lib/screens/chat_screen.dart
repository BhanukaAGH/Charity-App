import 'package:charity_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  final String imgUrl;
  final String name;
  final double price;

  ChatScreen({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    List messages = [
      {
        'name': name,
        'message': 'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
      },
      {
        'name': 'Hashan Bhanuka',
        'message':
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur.',
      },
      {
        'name': name,
        'message': 'Lorem ipsum dolor sit amet consectetur adipisicing elit.',
      },
      {
        'name': name,
        'message':
            'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur.',
      },
    ];

    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: borderColor, width: 1),
      borderRadius: BorderRadius.circular(12),
    );

    final focusBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  width: 1,
                  color: borderColor,
                ),
              ),
              selected: true,
              leading: CircleAvatar(
                maxRadius: 24,
                backgroundColor: borderColor,
                backgroundImage: NetworkImage(
                  imgUrl,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: name,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' has donated ',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: greyTextColor,
                      ),
                    ),
                    TextSpan(
                      text: '\$${price.toInt()}',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...messages
                          .map(
                            (message) => Row(
                              mainAxisAlignment: message['name'] == name
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(bottom: 8),
                                  decoration: BoxDecoration(
                                    color: message['name'] == name
                                        ? primaryColor
                                        : messageColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: borderColor, // red as border color
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message['message'],
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: message['name'] == name
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Text(
                                          textAlign: TextAlign.end,
                                          '10.30',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: message['name'] == name
                                                ? Colors.white
                                                : Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
            TextField(
              style: GoogleFonts.urbanist(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: paginationColor,
              ),
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: primaryColor,
                    ),
                  ),
                  hintText: 'Type message ....',
                  hintStyle: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: borderColor,
                  ),
                  fillColor: Colors.black,
                  border: inputBorder,
                  focusedBorder: focusBorder,
                  enabledBorder: inputBorder,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16)),
              keyboardType: TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
