def foo(x):
    if(isinstance(x,int)):
        print "it is int"
    elif(isinstance(x,str)):
        print "it is string"
    elif(isinstance(x,float)):
        print "it is float"
    elif(isinstance(x,bool)):
        print "it is boolean"
    else:
        print "it is something else"
        
#foo(1)    #it is int
#foo(0.5)  #it is float
#foo(True) #it is boolean
#foo("hi") #it is string


student=[[0 for x in range(3)]for y in range(4)]
student[0]=["1155070355","Wong Cho Hin","CSCI",3,3.08]
student[1]=["1155012345","Chan Tai Man","IBBA",1,3.42]
student[2]=["1155054321","Li Siu Ming","QFIN",4,3.64]
for i in range(3):
    print student[i]