file_out = open("PDM.txt","w")
file_in_sx = open("PDMs.txt", "r").readlines()
file_in_dx = open("PDMd.txt", "r").readlines()

i = 0
while i < len(file_in_dx):
    file_out.write(file_in_sx[i])
    file_out.write(file_in_dx[i])
    i = i + 1

file_out.close()
