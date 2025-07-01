import random

ZZ = IntegerRing()
F2 = GF(2)

# p is the prime, k is key length and n is block length
p = 2^(130)-5; k = 128; n = 128; 
F = GF(p)

def getKeyRandom(k):

	key = []
	f = open("poly1305_speed_record_test_cases_keyfile.txt", "w")
	for i in range(k): 
		bit = F2.random_element()
		key.append(bit)
		f.write(str(bit))
	f.close()	 
	return key

def getKeyFldElt(key,k):

	c = F(0);
	for i in range(k):
		c = 2*c + F(key[i])
	return c;
 
def formatMsgHorner(msg,msgLen,msgEltsLst,n):
# outputs pad1(format(msg))

	if (msgLen == 0):
		m = 0
		msgEltsLst = []
		return m
	r = ZZ(mod(msgLen,n))
	if (r == 0):
		m = msgLen/n
		lastlen = n
	else:
		m = 1 + floor(msgLen/n)
		lastlen = r

	for i in range(m-1):
		c = F(1)
		for j in range(n):
			c = 2*c + F(msg[i*n+j])
		msgEltsLst.append(c)
	c = F(1)
	for j in range(lastlen):
		c = 2*c + F(msg[(m-1)*n+j])
	msgEltsLst.append(c)
	return m
	
def formatMsgHorner1(msg,msgLen,msgEltsLst,n):
# outputs pad1(format(msg))

	if (msgLen == 0):
		m = 0
		msgEltsLst = []
		return m
	r = ZZ(mod(msgLen,n))
	if (r == 0):
		m = msgLen/n
		lastlen = n
	else:
		m = 1 + floor(msgLen/n)
		lastlen = r

	for i in range(m-1):
		c = F(0)
		for j in range(n):
			c = 2*c + F(msg[i*n+j])
		msgEltsLst.append(c)
	if (lastlen == n): 
		c = F(0)
	else:
		c = F(1)	
	for j in range(lastlen):
		c = 2*c + F(msg[(m-1)*n+j])
	msgEltsLst.append(c)
	return m	

def printMsgLst(msgEltsLst):

	m = len(msgEltsLst)
	for i in range(0,m):
		print("\t%032x"%msgEltsLst[i])
	return

def Horner(keyFldElt, msgEltsLst):
	
	m = len(msgEltsLst)
	if (m == 0):
		return F(0)
	val = msgEltsLst[0]
	for i in range(1,m):
		val = keyFldElt * val + msgEltsLst[i]
	return val
 
def HornerHash(keyFldElt, msgEltsLst):
	
	m = len(msgEltsLst)
	if (m == 0):
		return F(0)
	val = keyFldElt*msgEltsLst[0]
	for i in range(1,m):
		val = keyFldElt * (val + msgEltsLst[i])
	return val	
	
def getRandomString(n):
     
	s = ""
	for i in range(1,n+1):
         
		b = random.randint(0,1)
		s += str(b)
	return s

	
def genSpeedTestCases():

	key = getKeyRandom(k)
	keyFldElt = getKeyFldElt(key,k)
    	
	f = open("poly1305_speed_record_test_cases.txt", "w")
	start = 128
	stop = 25600+128
	step = 128
	for msgLen in range(start,stop,step):	
		for i in range(1,2):
			msg = getRandomString(msgLen)
			msgEltsLst = []
			m=formatMsgHorner(msg,msgLen,msgEltsLst,n)
			
			msgEltsLst1 = []
			m=formatMsgHorner1(msg,msgLen,msgEltsLst1,n)			
			
			m=len(msgEltsLst1)
			for j in range(0,m):
				f.write("%032x"%msgEltsLst1[j])
			f.write(" ")
			f.write("%d"%msgLen)
			f.write("\n")
			
	start = 32000
	stop = 64000+128
	step = 6400
	for msgLen in range(start,stop,step):	
		for i in range(1,2):
			msg = getRandomString(msgLen)
			msgEltsLst = []
			m=formatMsgHorner(msg,msgLen,msgEltsLst,n)
			
			msgEltsLst1 = []
			m=formatMsgHorner1(msg,msgLen,msgEltsLst1,n)			
			
			m=len(msgEltsLst1)
			for j in range(0,m):
				f.write("%032x"%msgEltsLst1[j])
			f.write(" ")
			f.write("%d"%msgLen)
			f.write("\n")
	f.close()
	
genSpeedTestCases()
