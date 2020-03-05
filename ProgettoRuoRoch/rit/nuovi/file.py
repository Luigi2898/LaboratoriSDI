file_out = open("PDM_50_DA_SINISTRA.txt","w")
file_in_sx = open("PDM_dxx_50.txt", "r").readlines()
file_in_dx = open("PDM_sxx_50.txt", "r").readlines()

i = 0
while i < len(file_in_dx):
    file_out.write(file_in_dx[i])
    file_out.write(file_in_sx[i])
    i = i + 1

file_out.close()
