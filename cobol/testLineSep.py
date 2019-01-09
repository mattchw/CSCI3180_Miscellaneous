import sys

def main(argv):
	inputFile = open(argv[1], 'r')
	line = inputFile.readline()
	while (line):
		nChar = len(line)
		print 'n: ', nChar, ", ".join([str(ord(line[i])) for i in range(nChar)])
		line = inputFile.readline()


	inputFile.close()

if __name__ == '__main__':
	main(sys.argv)
