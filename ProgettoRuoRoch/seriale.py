import serial
from serial import Serial
out_file = open("out1.txt","w")
porta = serial.Serial("COM5", 9600, 8, "N", 1, timeout=1)
i = 1
while i:
    try:
        out_file.write(porta.read().decode("utf-8"))
    except KeyboardInterrupt:
        print("Esco dal ciclo")
        i = 0
porta.close()
out_file.close()
if not(porta.is_open):
    print("Ho chiuso file e com :)")
