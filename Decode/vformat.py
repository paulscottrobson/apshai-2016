h = open("apshai.variables")
src = h.readlines()
h.close()
for l in src:
	l = l.strip()
	if l.find(" ") >= 0:
		l = l.split()
		print("{0:16}{1:32}{2}".format(l[0],l[1]," ".join(l[2:])))
	else:
		print(l)