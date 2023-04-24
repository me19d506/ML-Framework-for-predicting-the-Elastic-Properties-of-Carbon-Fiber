# Code written by PV Divakar Raju and Neeraj mishra, IIT Tirupati May 2022

# This code automatically runs all the scripts in ABAQUS one-by-one 

import os
f = 700 #  provide the no. of files here
for i in range(1,f+1,1):
    # provide python script location to run
    command_    = r'abaqus cae -noGUI "C:\Users\user\Desktop\New folder\python files\{}.py(path accordingly)"'.format(i) 
    os.system(command_)
    
    # saving result file
    fileHandle  = open('Model-1_elastic_properties(easycopy).txt', "r")
    texts       = fileHandle.readlines()
    fileHandle.close()
    
    # providing result file a location
    fileHandle  = open('target/'+str(i)+'.txt', "w")
    for s in texts:
        fileHandle.write(s)
    fileHandle.close()
