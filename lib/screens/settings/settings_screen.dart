import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/image/media_file.dart';
import 'package:admin/screens/media_library/media_library_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../components/forms/custom_text_field.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Settings',
        actions: [
          IconButton(
            icon: Icon(settingsController.saving.value
              ? LineIcons.circle
              : LineIcons.checkCircle,
              color: Colors.indigoAccent
            ),
            onPressed: settingsController.save,
          )
        ],
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 150),
          children: [
            CustomField.fieldGroup(
                label: 'General',
                content: Column(
                  children: [
                    CustomField.text(
                      controller: settingsController.titleField.value,
                      hint: 'Summarize this config',
                      label: 'Title'
                    ),
                    CustomField.text(
                      controller: settingsController.subtitleField.value,
                      hint: 'Insert some words',
                      label: 'Subtitle',
                      minLines: 3,
                      maxLines: 5
                    ),
                    CustomField.text(
                      controller: settingsController.copyrightField.value,
                      hint: '© 2018-2023',
                      label: 'Copyright',
                      margin: EdgeInsets.zero
                    ),
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'Address & Contact',
                content: Column(
                  children: [
                    CustomField.text(
                      controller: settingsController.emailField.value,
                      hint: 'my@mail.com',
                      label: 'Email',
                    ),
                    CustomField.text(
                      controller: settingsController.phoneField.value,
                      hint: '62857320000',
                      label: 'Phone',
                    ),
                    CustomField.text(
                      controller: settingsController.whatsappLinkField.value,
                      hint: 'https://wa.me/6289720000?text=Hello',
                      label: 'WhatsApp Link',
                      minLines: 1,
                      maxLines: 3
                    ),
                    CustomField.text(
                      controller: settingsController.openingHoursField.value,
                      hint: 'Senin - Sabtu. 10.00-16.00',
                      label: 'Opening Hours',
                    ),
                    CustomField.text(
                        controller: settingsController.addressField.value,
                        hint: 'Address',
                        label: 'Address',
                        minLines: 3,
                        maxLines: 5,
                        margin: EdgeInsets.zero
                    ),
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'Google Map',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField.text(
                      controller: settingsController.zoomField.value,
                      hint: '8 - 18',
                      label: 'Zoom',
                    ),
                    CustomField.text(
                      controller: settingsController.placeholderField.value,
                      hint: 'https://placehold.co/600x400@2x.jpg',
                      label: 'Placeholder Image URL',
                    ),
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9/2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12
                      ),
                      children: [
                        CustomField.chip(
                            label: 'Draggable',
                            enable: settingsController.draggable.value,
                            onTap: settingsController.draggable.toggle
                        ),
                        CustomField.chip(
                            label: 'Scale Control',
                            enable: settingsController.scaleControl.value,
                            onTap: settingsController.scaleControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Rotate Control',
                            enable: settingsController.rotateControl.value,
                            onTap: settingsController.rotateControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Zoom Control',
                            enable: settingsController.zoomControl.value,
                            onTap: settingsController.zoomControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Map Type Control',
                            enable: settingsController.mapTypeControl.value,
                            onTap: settingsController.mapTypeControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Street View Control',
                            enable: settingsController.streetViewControl.value,
                            onTap: settingsController.streetViewControl.toggle
                        ),
                        CustomField.chip(
                            label: 'Full Screen Control',
                            enable: settingsController.fullScreenControl.value,
                            onTap: settingsController.fullScreenControl.toggle
                        ),
                      ],
                    )
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'Google Map Markers',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField.text(
                      controller: settingsController.markerLabelField.value,
                      hint: 'Marker title goes here',
                      label: 'Label',
                    ),
                    CustomField.text(
                      controller: settingsController.markerDescriptionField.value,
                      hint: 'Insert some words',
                      label: 'Description',
                    ),
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 9/2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      children: [
                        CustomField.text(
                          controller: settingsController.markerLatitudeField.value,
                          hint: '-7.40000',
                          label: 'Latitude',
                          margin: EdgeInsets.zero
                        ),
                        CustomField.text(
                          controller: settingsController.markerLongitudeField.value,
                          hint: '112.50000',
                          label: 'Longitude',
                          margin: EdgeInsets.zero
                        ),
                        CustomField.chip(
                            label: 'Clickable',
                            enable: settingsController.markerClickable.value,
                            onTap: settingsController.markerClickable.toggle
                        ),
                        CustomField.chip(
                            label: 'Draggable',
                            enable: settingsController.markerDraggable.value,
                            onTap: settingsController.markerDraggable.toggle
                        ),
                      ],
                    )
                  ],
                )
            ),
            const SizedBox(height: 40),
            CustomField.fieldGroup(
                label: 'SEO',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomField.text(
                      controller: settingsController.metaTitleField.value,
                      hint: 'Site title goes here',
                      label: 'Meta Title (Applied to Meta Social)',
                    ),
                    CustomField.text(
                      controller: settingsController.metaDescriptionField.value,
                      hint: 'Describe your site here',
                      label: 'Meta Description (Applied to Meta Social)',
                      minLines: 1,
                      maxLines: 2
                    ),
                    CustomField.text(
                      controller: settingsController.canonicalURLField.value,
                      hint: 'https://site.com/page',
                      label: 'Canonical URL',
                    ),
                    CustomField.text(
                      controller: settingsController.metaKeywordsField.value,
                      hint: 'Insert some keywords (comma separated)',
                      label: 'Meta Keywords',
                      minLines: 1,
                      maxLines: 5
                    ),
                    AspectRatio(
                      aspectRatio: 7/4,
                      child: InkWell(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              settingsController.metaImage.value.hasURL ? Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 14),
                                    height: 180,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                settingsController.metaImage.value.url
                                            ),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 15,
                                    child: IconButton(
                                      icon: const CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: Icon(FeatherIcons.trash2,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        settingsController.metaImage.value = MediaFile.dummy();
                                      },
                                    ),
                                  )
                                ],
                              ) : Column(
                                children: const [
                                  Icon(FeatherIcons.uploadCloud),
                                  SizedBox(height: 8),
                                  Text('Upload image or choose from library'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text('Meta Image', style: Get.textTheme.titleMedium),
                            ],
                          ),
                        ),
                        onTap: () async {
                          MediaFile? media = await Get.to(() => MediaLibraryScreen(
                            enableSelection: true,
                          ));
                          if (media != null) {
                            settingsController.metaImage.value = media;
                          }
                        },
                      ),
                    )
                    // meta image goes here
                  ],
                )
            ),
          ],
        )
    ));
  }
}
