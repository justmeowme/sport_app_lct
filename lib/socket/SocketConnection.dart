// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class SocketConnection {
//    static IO.Socket? _socket;
//
//    static IO.Socket getConnection() {
//       if (SocketConnection._socket != null) {
//          return SocketConnection._socket!;
//       }
//
//       return SocketConnection._initConnection();
//    }
//
//    static _initConnection() {
//       _socket = IO.io('http://sport-plus.sorewa.ru:8080/', <String, dynamic>{
//          'transports': ['websocket'],
//          'forceNew': true,
//          'reconnection': true,
//       });
//
//       _socket?.on('connect', (_) {
//          print('connected');
//       });
//
//       _socket?.on('disconnect', (_) {
//          print('disconnected');
//       });
//
//       // Handle connection errors
//       _socket?.on('connect_error', (error) {
//          print('Connection error: $error');
//       });
//
//       // Handle connection timeout
//       _socket?.on('connect_timeout', (timeout) {
//          print('Connection timeout: $timeout');
//       });
//
//       // Handle other errors
//       _socket?.on('error', (error) {
//          print('General error: $error');
//       });
//
//       return _socket;
//    }
// }