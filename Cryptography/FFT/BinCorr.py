def myF(Xin):
    x1 = int(Xin[0])
    x2 = int(Xin[1])
    x3 = int(Xin[2])
    x4 = int(Xin[3])
    result=( x3*x4 + x2 + x2*x4 + x1*x4 + x1*x3 + x1*x3*x4 + x1*x2 + x1*x2*x4 + x1*x2*x3 ) % 2
    return result

def myBTS(str1, str2):
    result=[]
    for i in range(4):
        result.append( int(str1[i]) + int(str2[i]) )
    return result

Xv=[]
Fv=[]

for i in range(16):
    test=bin(i)
    test=test[2:len(test)]
    test='0'*(4-len(test)) + str(test)
    Xv.append(test)

for i in range(16):
    Fv.append(myF(Xv[i]))
    print(Fv[i])

array=[]
for i in range(16):
    array.append([0]*16)

total=[]

for x in range(16):
    for s in range(16):
        degree=myF(Xv[x]) + myF( myBTS( Xv[x], Xv[s] ) )
        array[x][s]=(-1)**degree


total=[]
for s in range(16):
    sum=0
    for x in range(16):
        sum=sum+array[x][s]
    total.append(abs(sum))


for s in range(16):
    print(array[s][0:15])

print(total)
print(max(total))

