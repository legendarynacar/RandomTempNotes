#!/usr/bin/python3
'''
Bu kod, eksik impacket modullerini tespit eder ve /usr/bin/ altina, olanlardaki gibi sembolik link ile ekler.
Tekrar tekrar calistirmanin zarari yok gibi.
'''
import os

notInstalled = []
Impackets = []
Installed = []

for i in sorted(os.listdir('/usr/share/doc/python3-impacket/examples/')):
    if '.py' in i:
        #print(i)
        Impackets.append(i.split('.')[0])

print("\nEXAMPLES DONE\n")
print(Impackets)
print('\n')

for j in sorted(os.listdir('/usr/bin/')):
    if 'impacket' in j:
        #print(j)
        Installed.append(j.split('impacket-')[1])

print("INSTALLED DONE\n")
print(Installed)
print('\n')


for k in Impackets:
    if k not in Installed:
        #print(k)
        notInstalled.append(k)

print("notINSTALLED DONE\n")
print(notInstalled)
print('\n')

print("Impackets count = "+ str(len(Impackets)))
print("Installed count = "+ str(len(Installed)))
print("Not Installed count = "+ str(len(notInstalled)))

with open("missingExamples.txt", 'w') as file:
    for z in notInstalled:
        file.writelines(z+'\n')

print("\nFor the record, I wrote a list of missing modules of impacket into a file for a log\n")
print("If you ran this code for the first time, better change the name to prevent a loss of overwrite")

print("\nCreating Symbolic Links!\n")


for x in notInstalled:
    if x is not "":
        print("impacket-"+x+" is created!")
        src='../share/impacket/script'
        dst='/usr/bin/impacket-'+x
        os.symlink(src, dst)
        print(os.system('ls -l /usr/bin/impacket-'+x))
