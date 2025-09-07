import wmi

w = wmi.WMI(namespace="root\OpenHardwareMonitor")

temperature_infos = w.Sensor()
for sensor in temperature_infos:
    if sensor.SensorType == 'Temperature' and 'CPU' in sensor.Name:
        print(f"{sensor.Name}: {sensor.Value} °C")


# NON FUNZIONA DA RIVEDERE 