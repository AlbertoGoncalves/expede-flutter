import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:expede/src/core/exceptions/repository_exception.dart';
import 'package:expede/src/core/fp/either.dart';
import 'package:expede/src/core/fp/nil.dart';
import 'package:expede/src/core/rest_client/rest_cliente_mqtt.dart';
import 'package:expede/src/repositories/device/device_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final MqttRestClient mqttRestClient;
  DeviceRepositoryImpl({
    required this.mqttRestClient,
  });

  @override
  Future<Either<RepositoryException, Nil>> ledHigh(
      ({
        String clientIdentifier,
      }) mqttClient) async {
    /// Set the correct MQTT protocol for mosquito
    mqttRestClient.setProtocolV311();
    mqttRestClient.logging(on: false);
    mqttRestClient.keepAlivePeriod = 2;
    mqttRestClient.onDisconnected = onDisconnected;
    mqttRestClient.onSubscribed = onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(mqttClient.clientIdentifier)
        // If you set this you must set a will message
        .withWillTopic(mqttClient.clientIdentifier)
        .withWillMessage('11')
        .startClean(); // Non persistent session for testing
        // .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto mqttRestClient connecting....');
    mqttRestClient.connectionMessage = connMess;

    try {
      await mqttRestClient.connect();
    } on DioException catch (e, s) {
      log('EXAMPLE::mqttRestClient exception - $e', error: e, stackTrace: s);
      mqttRestClient.disconnect();
      return Failure(
          RepositoryException(message: 'EXAMPLE::mqttRestClient exception'));
    }

    /// Check we are connected
    if (mqttRestClient.connectionStatus!.state ==
        MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto mqttRestClient connected');
      // mqttRestClient.disconnect();
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto mqttRestClient connection failed - disconnecting, state is ${mqttRestClient.connectionStatus!.state}');
      mqttRestClient.disconnect();
      // exit(-1);
    }

    return Success(nil);
  }

  @override
  Future<Either<RepositoryException, Nil>> ledLow(
      ({
        String clientIdentifier,
      }) mqttClient) async {
    /// Set the correct MQTT protocol for mosquito
    mqttRestClient.setProtocolV311();
    mqttRestClient.logging(on: false);
    mqttRestClient.keepAlivePeriod = 2;
    mqttRestClient.onDisconnected = onDisconnected;
    mqttRestClient.onSubscribed = onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(mqttClient.clientIdentifier)
        // If you set this you must set a will message
        .withWillTopic(mqttClient.clientIdentifier)
        .withWillMessage('10')
        .startClean(); // Non persistent session for testing
        // .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto mqttRestClient connecting....');
    mqttRestClient.connectionMessage = connMess;

    try {
      await mqttRestClient.connect();
    } on DioException catch (e, s) {
      log('EXAMPLE::mqttRestClient exception - $e', error: e, stackTrace: s);
      mqttRestClient.disconnect();
      return Failure(
          RepositoryException(message: 'EXAMPLE::mqttRestClient exception'));
    }

    /// Check we are connected
    if (mqttRestClient.connectionStatus!.state ==
        MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto mqttRestClient connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto mqttRestClient connection failed - disconnecting, state is ${mqttRestClient.connectionStatus!.state}');
      mqttRestClient.disconnect();
    }
    return Success(nil);
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  }
}




 // @override
  // Future<Either<RepositoryException, Nil>> mqttconected(
  //     ({
  //       String? server,
  //       String? clientIdentifier,
  //     }) mqttRestClient) async {
  //   try {
  //     /// Set the correct MQTT protocol for mosquito
  //     mqttRestClient.setProtocolV311();
  //     mqttRestClient.logging(on: false);
  //     mqttRestClient.keepAlivePeriod = 20;
  //     mqttRestClient.onDisconnected = onDisconnected;
  //     mqttRestClient.onSubscribed = onSubscribed;
  //     final connMess = MqttConnectMessage()
  //         .withClientIdentifier('itemsShipment001')
  //         .withWillTopic(
  //             'APPEXPESP0001') // If you set this you must set a will message
  //         .withWillMessage('Teste Alberto Conexão MQTT')
  //         .startClean() // Non persistent session for testing
  //         .withWillQos(MqttQos.atLeastOnce);
  //     print('EXAMPLE::Mosquitto mqttRestClient connecting....');
  //     mqttRestClient.connectionMessage = connMess;

  //     try {
  //       await mqttRestClient.connect();
  //     } on Exception catch (e) {
  //       print('EXAMPLE::mqttRestClient exception - $e');
  //       mqttRestClient.disconnect();
  //     }

  //     /// Check we are connected
  //     if (mqttRestClient.connectionStatus!.state ==
  //         MqttConnectionState.connected) {
  //       print('EXAMPLE::Mosquitto mqttRestClient connected');
  //     } else {
  //       print(
  //           'EXAMPLE::ERROR Mosquitto mqttRestClient connection failed - disconnecting, state is ${mqttRestClient.connectionStatus!.state}');
  //       mqttRestClient.disconnect();
  //       // exit(-1);
  //     }

  //     /// If needed you can listen for published messages that have completed the publishing
  //     /// handshake which is Qos dependant. Any message received on this stream has completed its
  //     /// publishing handshake with the broker.
  //     // ignore: avoid_types_on_closure_parameters
  //     // mqttRestClient.published!.listen((MqttPublishMessage message) {
  //     //   print(
  //     //       'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  //     // });

  //     // print('EXAMPLE:: <<<< SUBSCRIBE 1 >>>>');
  //     // const topic1 = 'APPEXPESP0001'; // Not a wildcard topic
  //     // mqttRestClient.subscribe(topic1, MqttQos.exactlyOnce);

  //     // mqttRestClient.updates!.listen((messageList) {
  //     //   final recMess = messageList[0];
  //     //   if (recMess is! MqttReceivedMessage<MqttPublishMessage>) return;
  //     //   final pubMess = recMess.payload;
  //     //   final pt =
  //     //       MqttPublishPayload.bytesToStringAsString(pubMess.payload.message);
  //     //   print(
  //     //       'EXAMPLE::Change notification:: topic is <${recMess.topic}>, payload is <-- $pt -->');
  //     //   print('');
  //     // });

  //     // final builder1 = MqttClientPayloadBuilder();
  //     // builder1.addString('Hello from mqtt_mqttRestClient topic 1');
  //     // print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
  //     // mqttRestClient.publishMessage(
  //     //     topic1, MqttQos.exactlyOnce, builder1.payload!);

  //     // print('EXAMPLE::Sleeping....');
  //     // await MqttUtilities.asyncSleep(60);

  //     // print('EXAMPLE::Unsubscribing');
  //     // mqttRestClient.unsubscribe(topic1);

  //     // await MqttUtilities.asyncSleep(2);
  //     // print('EXAMPLE::Disconnecting');
  //     // mqttRestClient.disconnect();

  //     return Success(nil);
  //   } on DioException catch (e, s) {
  //     log('Erro ao inserir Iten do carregamento', error: e, stackTrace: s);
  //     return Failure(
  //         RepositoryException(message: 'Erro ao inserir Iten do carregamento'));
  //   }
  // }