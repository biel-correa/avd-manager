class Device {
  String name;
  int? processId;

  Device({required this.name, this.processId});

  isRunning() {
    return processId != null;
  }
}
