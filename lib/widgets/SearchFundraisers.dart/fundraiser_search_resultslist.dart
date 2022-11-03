import 'package:flutter/cupertino.dart';
import '../home/fundraiserSearch_card.dart';

class SearchResultsTab extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: const [
            FundraiserSearchCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1467307983825-619715426c70?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1077&q=80',
              title: 'African Children Beauty Charity Volunteer Hope',
              goal: 4800,
              raisedAmount: 3200,
              donatorsCount: 1240,
              daysLeft: 10,
            ),
            FundraiserSearchCard(
              imageUrl:
                  'https://images.unsplash.com/flagged/photo-1555251255-e9a095d6eb9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
              title: 'African Children Beauty Charity Volunteer Hope',
              goal: 4800,
              raisedAmount: 3200,
              donatorsCount: 1240,
              daysLeft: 10,
            ),
            FundraiserSearchCard(
              imageUrl:
                  'https://images.unsplash.com/photo-1507427254987-7be33d0321d3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
              title: 'African Children Beauty Charity Volunteer Hope',
              goal: 4800,
              raisedAmount: 3200,
              donatorsCount: 1240,
              daysLeft: 10,
            ),
            FundraiserSearchCard(
              imageUrl:
                  'https://images.unsplash.com/flagged/photo-1555251255-e9a095d6eb9d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
              title: 'African Children Beauty Charity Volunteer Hope',
              goal: 4800,
              raisedAmount: 3200,
              donatorsCount: 1240,
              daysLeft: 10,
            ),
          ],
        ),
      ),
    );
  }
}
