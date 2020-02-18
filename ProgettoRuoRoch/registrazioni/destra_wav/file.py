file_out = open("PDM_89.txt","w")
file_in_sx = open("PDM_SINISTRA.txt", "r").readlines()
file_in_dx = open("PDM_DESTRA.txt", "r").readlines()

i = 0
while i < len(file_in_dx):
    file_out.write(file_in_dx[i])
    file_out.write(file_in_sx[i])
    i = i + 1

file_out.close()
