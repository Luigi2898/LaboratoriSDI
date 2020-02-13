file_out = open("PDM.txt","w")
file_in_sx = open("PDMsx.txt", "r").readlines()
file_in_dx = open("PDM_dx.txt", "r").readlines()

i = 0
while i < len(file_in_dx):
    if file_in_dx[i] == -1:
        file_out.write("0")
    else:
        file_out.write(file_in_dx[i])
    if file_in_sx[i] == -1:
        file_out.write("0")
    else:
        file_out.write(file_in_sx[i])
    i = i + 1

file_out.close()
