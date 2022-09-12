import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/data/models/weight.dart';

abstract class WeightsRepository {
  Stream<List<Weight>> getWeights();
  Future<Weight> addEditWeight(Weight weight, {bool isEdit = false});
  Future<Weight> deleteWeight(Weight weight);
  Stream<Weight?> getLatestWeight();
  void disposeGetWeightsStreams();
  void disposeLatestWeightStreams();
}

class WeightsRepositoryImpl implements WeightsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  WeightsRepositoryImpl(this.firestore, this.firebaseAuth);

  final CollectionReference _weightsCollectionReference =
      FirebaseFirestore.instance.collection('weigths');

  //weights stream
  StreamSubscription<QuerySnapshot<Object?>>? weightStreamSubscription;
  late StreamController<List<Weight>> weightsController;

  //latest weights stream
  late StreamController<Weight?> latestWeightsController;
  StreamSubscription<QuerySnapshot<Object?>>? latestWeightStreamSubscription;

  @override
  Stream<List<Weight>> getWeights() {
    weightsController = StreamController<List<Weight>>.broadcast();
    try {
      final userId = firebaseAuth.currentUser?.uid;

      if (userId == null) throw Exception('User id not found');

      weightStreamSubscription = _weightsCollectionReference
          .orderBy("createdDate", descending: true)
          .where('userId', isEqualTo: userId)
          .snapshots()
          .listen((weightsSnapshot) {
        if (weightsSnapshot.docs.isNotEmpty) {
          var weight = weightsSnapshot.docs
              .map((snapshot) => Weight.fromJson(
                  snapshot.data() as Map<String, dynamic>, snapshot.id))
              .toList();

          weightsController.add(weight);
        } else {
          weightsController.add(<Weight>[]);
        }
      }, onError: (e) {
        log("Error ------ $e");
      });

      return weightsController.stream;
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }

  @override
  void disposeGetWeightsStreams() {
    weightStreamSubscription?.cancel();
    weightsController.close();
  }

  @override
  Future<Weight> addEditWeight(Weight weight, {bool isEdit = false}) async {
    try {
      final userId = firebaseAuth.currentUser?.uid;

      if (userId == null) throw Exception('User id not found');

      weight = weight.copyWith(userId: userId);

      if (isEdit) {
        weight = weight.copyWith(
            updatedDate: Timestamp.now().millisecondsSinceEpoch);
        await _weightsCollectionReference
            .doc(weight.documentId)
            .update(weight.toJson());
      } else {
        weight = weight.copyWith(
            createdDate: Timestamp.now().millisecondsSinceEpoch);

        await _weightsCollectionReference.add(weight.toJson());
      }
      return weight;
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Future<Weight> deleteWeight(Weight weight) async {
    try {
      await _weightsCollectionReference.doc(weight.documentId).delete();
      return weight;
    } catch (e) {
      throw Exception('$e');
    }
  }

  @override
  Stream<Weight?> getLatestWeight() {
    try {
      latestWeightsController = StreamController<Weight?>.broadcast();
      final userId = firebaseAuth.currentUser?.uid;

      if (userId == null) throw Exception('User id not found');

      latestWeightStreamSubscription = _weightsCollectionReference
          .orderBy("createdDate", descending: true)
          .where('userId', isEqualTo: userId)
          .limit(1)
          .snapshots()
          .listen((weightsSnapshot) {
        if (weightsSnapshot.docs.isNotEmpty) {
          final doc = weightsSnapshot.docs.first;

          if (doc.exists) {
            final weight =
                Weight.fromJson(doc.data() as Map<String, dynamic>, doc.id);
            if (!latestWeightsController.isClosed) {
              latestWeightsController.add(weight);
            }
          } else {
            latestWeightsController.add(null);
          }
        } else {
          latestWeightsController.add(null);
        }
      });
    } catch (e) {
      throw Exception('$e');
    }

    return latestWeightsController.stream;
  }

  @override
  void disposeLatestWeightStreams() {
    latestWeightsController.close();
    latestWeightStreamSubscription?.cancel();
  }
}
