import serial
from serial import Serial
porta = serial.Serial("COM5", 9600, 8, "N", 1, timeout=1)
porta.write(b'test')
porta.close()
