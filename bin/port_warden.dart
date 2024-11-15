// import 'dart:io';
import 'package:port_warden/port_warden.dart';

Future<void> main(List<String> arguments) async {
  final portWarden = PortWarden();
  await portWarden.scan('192.168.1.0/24', 1, 1024);
  portWarden.printResults();
}