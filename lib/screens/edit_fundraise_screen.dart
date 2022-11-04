import 'package:charity_app/utils/colors.dart';
import 'package:charity_app/utils/utils.dart';
import 'package:charity_app/widgets/common/action_button.dart';
import 'package:charity_app/widgets/common/form_field_date.dart';
import 'package:charity_app/widgets/common/form_field_dropdown.dart';
import 'package:charity_app/widgets/common/form_field_input.dart';
import 'package:charity_app/widgets/create_fundraise/image_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditFundraiseScreen extends StatefulWidget {
  final snap;
  const EditFundraiseScreen({super.key, required this.snap});

  @override
  State<EditFundraiseScreen> createState() => _EditFundraiseScreenState();
}

class _EditFundraiseScreenState extends State<EditFundraiseScreen> {
  final _fundraiseFormKey = GlobalKey<FormState>();
  final _recipientFormKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _goalController;
  late TextEditingController _dateController;
  late TextEditingController _storyController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late List imgList;
  Uint8List? coverimage;
  Uint8List? image1;
  Uint8List? image2;
  Uint8List? image3;
  Uint8List? image4;
  String fundraiseCategory = 'All';
  bool termChecked = false;
  bool isCoverImageError = false;

  @override
  void initState() {
    super.initState();
    imgList = widget.snap['images'];
    fundraiseCategory = widget.snap['category'];
    _titleController = TextEditingController(text: widget.snap['title']);
    _goalController =
        TextEditingController(text: widget.snap['goal'].toString());
    _dateController =
        TextEditingController(text: widget.snap['expireDate'].toString());
    _storyController = TextEditingController(text: widget.snap['story']);
    _nameController = TextEditingController(text: widget.snap['recipientName']);
    _phoneController =
        TextEditingController(text: widget.snap['recipientPhone']);
    _emailController =
        TextEditingController(text: widget.snap['recipientEmail']);
  }

  void _selectImage(BuildContext context, int position) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Create a Fundraise',
            textAlign: TextAlign.center,
          ),
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    semanticLabel: 'Camera',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.camera);
                    setState(() {
                      switch (position) {
                        case 0:
                          coverimage = file;
                          break;
                        case 1:
                          image1 = file;
                          break;
                        case 2:
                          image2 = file;
                          break;
                        case 3:
                          image3 = file;
                          break;
                        case 4:
                          image4 = file;
                          break;
                      }
                    });
                  },
                ),
                SimpleDialogOption(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.collections_outlined,
                    semanticLabel: 'Gallery',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Uint8List file = await pickImage(ImageSource.gallery);
                    setState(() {
                      switch (position) {
                        case 0:
                          coverimage = file;
                          break;
                        case 1:
                          image1 = file;
                          break;
                        case 2:
                          image2 = file;
                          break;
                        case 3:
                          image3 = file;
                          break;
                        case 4:
                          image4 = file;
                          break;
                      }
                    });
                  },
                ),
              ],
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void clearImage() {
    setState(() {
      coverimage = null;
      image1 = null;
      image2 = null;
      image3 = null;
      image4 = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _goalController.dispose();
    _dateController.dispose();
    _storyController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
  }

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
          'Edit Fundraise',
          style: GoogleFonts.urbanist(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
        actions: [
          ActionButton(
            onPressed: () {},
            icons: Icons.delete_forever,
            iconColor: redIconColor,
            lightColor: lightRedColor,
          ),
          const SizedBox(width: 12),
        ],
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
                imgUrl: imgList[0],
                imageFile: coverimage,
                width: size.width,
                inputType: 'cover',
                selectImage: () => _selectImage(context, 0),
                isError: isCoverImageError,
              ),
              const SizedBox(height: 12),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageInput(
                      imgUrl: imgList.length >= 2 ? imgList[1] : null,
                      imageFile: image1,
                      width: size.width / 5.2,
                      selectImage: () => _selectImage(context, 1),
                    ),
                    ImageInput(
                      imgUrl: imgList.length >= 3 ? imgList[2] : null,
                      imageFile: image2,
                      width: size.width / 5.2,
                      selectImage: () => _selectImage(context, 2),
                    ),
                    ImageInput(
                      imgUrl: imgList.length >= 4 ? imgList[3] : null,
                      imageFile: image3,
                      width: size.width / 5.2,
                      selectImage: () => _selectImage(context, 3),
                    ),
                    ImageInput(
                      imgUrl: imgList.length >= 5 ? imgList[4] : null,
                      imageFile: image4,
                      width: size.width / 5.2,
                      selectImage: () => _selectImage(context, 4),
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
                key: _fundraiseFormKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      top: 8, right: 2, left: 2, bottom: 4),
                  children: [
                    FormFieldInput(
                      controller: _titleController,
                      label: 'Title',
                      hintText: 'Title',
                      withAsterisk: true,
                      textInputType: TextInputType.name,
                    ),
                    FormFieldDropDown(
                      label: 'Category',
                      hintText: 'Category',
                      withAsterisk: true,
                      selectValue: fundraiseCategory,
                      onChanged: (String? value) {
                        setState(() {
                          fundraiseCategory = value!;
                        });
                      },
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
                      label: 'Choose Donations Expiration Date',
                      hintText: 'Select Date',
                      withAsterisk: true,
                    ),
                    FormFieldInput(
                      controller: _storyController,
                      label: 'Story',
                      hintText: 'Story of the donation reciepient',
                      withAsterisk: true,
                      textInputType: TextInputType.multiline,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 6),
              const Divider(
                thickness: 0.8,
                color: borderColor,
              ),
              const SizedBox(height: 6),
              Text(
                'Donation Recipient Details',
                textAlign: TextAlign.start,
                style: GoogleFonts.urbanist(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Form(
                key: _recipientFormKey,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  children: [
                    FormFieldInput(
                      controller: _nameController,
                      label: 'Name of Recipients',
                      hintText: 'Name',
                      withAsterisk: true,
                      textInputType: TextInputType.name,
                    ),
                    FormFieldInput(
                      controller: _phoneController,
                      label: 'Contact Number of Recipients',
                      hintText: 'Contact Number',
                      withAsterisk: true,
                      textInputType: TextInputType.phone,
                      suffixIcon: const Icon(
                        Icons.phone,
                      ),
                    ),
                    FormFieldInput(
                      controller: _emailController,
                      label: 'Contact Email of Recipients',
                      hintText: 'Contact Email',
                      withAsterisk: true,
                      textInputType: TextInputType.emailAddress,
                      suffixIcon: const Icon(
                        Icons.alternate_email,
                      ),
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      dense: true,
                      title: Text(
                        "By checking this, you agree to the term & conditions that apply to us.",
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      value: termChecked,
                      onChanged: (newValue) {
                        setState(() {
                          termChecked = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
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
                      size: 20,
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
                    disabledBackgroundColor: disabledButtonColor,
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
