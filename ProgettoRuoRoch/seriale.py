import serial
from serial import Serial
out_file = open("test.txt","w")
porta = serial.Serial("COM5", 9600, 8, "N", 1, timeout=1)
porta.write(b'test')
while porta.is_open:
    out_file.write(porta.read().decode("utf-8"))
porta.close()
out_file.close()
if porta.is_closed:
    print("Ho chiuso file e com :)")
