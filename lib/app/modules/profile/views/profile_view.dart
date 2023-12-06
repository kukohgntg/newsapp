// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:newsapp/app/utils/appwrite_constant.dart';

// import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create article'),
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: controller.obx(
        (state) => ListView.separated(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 10,
              color: Colors.grey,
            );
          },
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      '${AppwriteConstants.endPoint}/storage/buckets/${AppwriteConstants.employeeBucketId}/files/${state[index].image}/view?project=${AppwriteConstants.projectID}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
              title: Text(
                state[index].name,
                style: const TextStyle(fontSize: 16),
              ),
              subtitle: Text(
                state[index].departement,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.moveToEditEmpoyee(state[index]);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        controller.deleteEmployee(state[index]);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            );
          },
          itemCount: state!.length,
        ),
        onLoading: const Center(
          child: CircularProgressIndicator(),
        ),
        onError: (error) => Center(
          child: Text(error!),
        ),
        onEmpty: const Center(
          child: Text('No Employee Found'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          controller.moveToCreateEmpoyee();
        },
      ),
    );
  }
}
