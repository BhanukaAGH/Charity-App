import 'package:flutter/cupertino.dart';
import '../home/fundraiserSearch_card.dart';

class SearchResultsTab extends StatelessWidget {
  final data;
  final keyword;
  const SearchResultsTab({
    super.key,
    required this.data,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...data
                .map((e) => FundraiserSearchCard(
                      data: e,
                      imageUrl: e["images"][0],
                      title: e['title'],
                      goal: e['goal'],
                      // raisedAmount: 20,
                      // donatorsCount: 2,
                      // daysLeft: 10,
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
