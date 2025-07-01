import random

ZZ = IntegerRing()
F2 = GF(2)

# p is the prime, k is key length and n is block length
p = 2^(130)-5; k = 128; n = 128; 
F = GF(p)

def getKeyFromFile():
	key = []
	f = open("poly1305_speed_keyfile.txt","r")
	s = f.readline()
	for i in range(k):
		key.append(s[i])
	f.close()	 
	return key
	
def getMsgFromFile():
	f = open("poly1305_speed_msgfile.txt","r")
	msg = []
	s = f.readline()
	l = len(s)
	for i in range(l):
		msg.append(s[i])
	f.close()
	return msg,l
	
def getKeyFldElt(key,k):

	c = F(0);
	for i in range(k):
		c = 2*c + F(key[i])
	return c
 
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

def printMsgLst(msgEltsLst):

	m = len(msgEltsLst)
	for i in range(0,m):
		print("\t%032x"%msgEltsLst[i])
	return
	return val
 
def HornerHash(keyFldElt, msgEltsLst):
	
	m = len(msgEltsLst)
	if (m == 0):
		return F(0)
	val = keyFldElt*msgEltsLst[0]
	for i in range(1,m):
		val = keyFldElt * (val + msgEltsLst[i])
	return val

def testSpeedCase():
	
	f = open("poly1305_speed_s_output.txt", "w")	
	key = getKeyFromFile()
	keyFldElt = getKeyFldElt(key,k)
	msg,msgLen = getMsgFromFile()
	msgEltsLst = []
	m = formatMsgHorner(msg,msgLen,msgEltsLst,n)
	digest = HornerHash(keyFldElt,msgEltsLst)  
	res = int(digest) % (2^128)
	f.write("%032x\n"%res)
	
testSpeedCase()
