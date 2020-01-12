import serial
from serial import Serial
out_file = open("out1.txt","w")
<<<<<<< HEAD
porta = serial.Serial("COM5", 9600, 8, "N", 1)
i = 1
while i:
    try:
        out_file.write(porta.read().decode("utf-8"))
=======
porta = serial.Serial("COM5", 9600, 8, "N", 1, timeout = 1)
print("Apro la seriale")
i = 1
while i:
    try:
        r = porta.read().decode("utf-8")
        out_file.write(r)
        if r != "":
            print(r)
>>>>>>> d30787381ca5218a4775b79ab4a2516091391e2d
    except KeyboardInterrupt:
        print("Esco dal ciclo ;)")
        i = 0
porta.close()
out_file.close()
if not(porta.is_open):
    print("Ho chiuso file e com :)")
