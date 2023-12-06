// ignore_for_file: unnecessary_overrides

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

// import 'package:get/get.dart';

import '../utils/appwrite_constant.dart';

class AppWriteProvider  {
  Client client = Client();

  Account? account;

  Storage? storage;

  Databases? databases;

  AppWriteProvider() {
    client
        .setEndpoint(AppwriteConstants.endPoint)
        .setProject(AppwriteConstants.projectID)
        .setSelfSigned(status: true);
    account = Account(client);
    storage = Storage(client);
    databases = Databases(client);
  }

  Future<models.Account> signup(Map map) async {
    final response = account!.create(
      userId: map["userId"],
      email: map["email"],
      password: map["password"],
      name: map["name"],
    );
    return response;
  }

  Future<models.Session> login(Map map) async {
    final response = account!.createEmailSession(
      email: map["email"],
      password: map["password"],
    );
    return response;
  }

  Future<dynamic> logout(String sessionId) async {
    final response = account!.deleteSession(sessionId: sessionId);
    return response;
  }

  Future<models.File> uploadEmployeeImage(String imagePath) {
    String fileName =
        "${DateTime.now().millisecondsSinceEpoch}.${imagePath.split(".").last}";
    final response = storage!.createFile(
        bucketId: AppwriteConstants.employeeBucketId,
        fileId: ID.unique(),
        file: InputFile(path: imagePath, filename: fileName));
    return response;
  }

  Future<dynamic> deleteEmployeeImage(String fileId) {
    final response = storage!.deleteFile(
      bucketId: AppwriteConstants.employeeBucketId,
      fileId: fileId,
    );
    return response;
  }

  Future<models.Document> createEmploye(Map map) async {
    final response = databases!.createDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId,
        documentId: ID.unique(),
        data: {
          "name": map["name"],
          "departement": map["departement"],
          "createdBy": map["createdBy"],
          "image": map["image"],
          "createdAt": map["createdAt"],
        });
    return response;
  }

  Future<models.DocumentList> getEmployees() async {
    final response = databases!.listDocuments(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId);
    return response;
  }

  Future<models.Document> updateEmployee(Map map) async {
    final response = databases!.updateDocument(
        databaseId: AppwriteConstants.dbId,
        collectionId: AppwriteConstants.employeeCollectionId,
        documentId: map["documentId"],
        data: {
          "name": map["name"],
          "departement": map["departement"],
          "createdBy": map["createdBy"],
          "image": map["image"],
        });
    return response;
  }

  Future<dynamic> deleteEmployee(Map map) async {
    final response = databases!.deleteDocument(
      databaseId: AppwriteConstants.dbId,
      collectionId: AppwriteConstants.employeeCollectionId,
      documentId: map["documentId"],
    );
    return response;
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
