# 3190-A4-calculate-e

This program calculates e to a certain number of digits and saves it to a file. Done in Python, C, Ada and Fortran.

Note that Python should be the correct version, ie not 2.7

## HOW TO COMPILE AND RUN EACH PROGRAM:
- Fortran:    
	- gfortran -Wall ecalculate-fortran.f95 
	- ./a.out

- Ada:
	- gnatmake -Wall ecalculateada.adb
	- ./ecalculateada

- C:
	- gcc -Wall -std=c11 -c ecalculate-c.c -o ecalculate-c.o -lm
	- gcc ecalculate-c.o -o ecalculatec -lm
	- ./ecalculatec

- Python: 
	- python3 ecalculate-python.py



## TODO:
- Do user input error checking
