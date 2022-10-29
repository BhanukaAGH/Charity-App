import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/widgets/common/form_field_date.dart';
import 'package:charity_app/widgets/common/form_field_dropdown.dart';
import 'package:charity_app/widgets/common/form_field_input.dart';
import 'package:charity_app/widgets/create_fundraise/image_input.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateFundraiseScreen extends StatefulWidget {
  const CreateFundraiseScreen({super.key});

  @override
  State<CreateFundraiseScreen> createState() => _CreateFundraiseScreenState();
}

class _CreateFundraiseScreenState extends State<CreateFundraiseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
          'Create New Fundraise',
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
        width: size.width,
        height: size.height - kToolbarHeight - 24,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageInput(
                width: size.width,
                inputType: 'cover',
              ),
              const SizedBox(height: 12),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageInput(
                      width: size.width / 5.2,
                    ),
                    ImageInput(
                      width: size.width / 5.2,
                    ),
                    ImageInput(
                      width: size.width / 5.2,
                    ),
                    ImageInput(
                      width: size.width / 5.2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Divider(
                thickness: 0.8,
                color: borderColor,
              ),
              const SizedBox(height: 6),
              Text(
                'Fundraising Details',
                textAlign: TextAlign.start,
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Form(
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  children: [
                    FormFieldInput(
                      controller: _titleController,
                      label: 'Title',
                      hintText: 'Title',
                      withAsterisk: true,
                      textInputType: TextInputType.name,
                    ),
                    const FormFieldDropDown(
                      label: 'Category',
                      hintText: 'Category',
                      withAsterisk: true,
                    ),
                    FormFieldInput(
                      controller: _goalController,
                      label: 'Total Donations Required',
                      hintText: 'Your starting goal',
                      withAsterisk: true,
                      textInputType: TextInputType.number,
                      suffixIcon: const Icon(Icons.attach_money),
                    ),
                    FormFieldDateInput(
                      controller: _dateController,
                      label: 'Total Donations Required',
                      hintText: 'Your starting goal',
                      withAsterisk: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 64,
          padding: const EdgeInsets.only(bottom: 4),
          alignment: Alignment.center,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                color: borderColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: primaryColor,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    icon: const Icon(
                      Icons.save,
                      color: primaryColor,
                    ),
                    label: Text(
                      'Save',
                      style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Create & Submit',
                    style: GoogleFonts.urbanist(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
