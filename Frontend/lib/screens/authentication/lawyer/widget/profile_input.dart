import 'package:flutter/material.dart';
import 'package:frontend/service/lawyer_service.dart';
import 'package:frontend/widgets/my_text.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInput extends StatefulWidget {
  void Function(String) setImage;
  ProfileInput({super.key, required this.setImage});

  @override
  State<ProfileInput> createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput> {
  LawyerService lawyerService = LawyerService();
  ImagePicker imagePicker = ImagePicker();
  bool isUploading = false;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: MyText("Profile Photo", textAlign: TextAlign.start),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final imageFile = await imagePicker.pickImage(
              source: ImageSource.gallery,
            );
            isUploading = true;
            setState(() {});
            print(imageFile!.path);
            if (imageFile != null) {
              final data = await lawyerService.uploadLawyerPic(imageFile.path);
              if (data != null && data.containsKey("image")) {
                isUploading = false;
                imageUrl = data["image"];
                print(imageUrl);
                widget.setImage(imageUrl!);
                setState(() {});
              }
            }
          },
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child:
                imageUrl != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    )
                    : isUploading
                    ? Center(child: CircularProgressIndicator())
                    : Icon(
                      Icons.add_a_photo_rounded,
                      color: Theme.of(context).colorScheme.tertiaryFixed,
                    ),
          ),
        ),
      ],
    );
  }
}
