import base64
import sys

class RC4:

	def KSA(self, key):
		keylength = len(key)
		S = range(256)
		j = 0
		for i in range(256):
			j = (j + S[i] + key[i % keylength]) % 256
			S[i], S[j] = S[j], S[i]
		return S
	
	def PRGA(self, S):
		i = 0
		j = 0
		while True:
			i = (i + 1) % 256
			j = (j + S[i]) % 256
			S[i], S[j] = S[j], S[i] 

			K = S[(S[i] + S[j]) % 256]
			yield K

	def Encrypt(self, plaintext, key):
		output = ""
		key = [ord(c) for c in key]
		S = self.KSA(key)
		keystream = self.PRGA(S)
		for c in plaintext:
			output = output + chr(ord(c) ^ keystream.next())
		return output

if __name__ == '__main__':
	rc4 = RC4()
	key = sys.argv[1]
	data = base64.b64decode(sys.argv[2])
	cipher = base64.b64encode(rc4.Encrypt(data, key))

	print cipher