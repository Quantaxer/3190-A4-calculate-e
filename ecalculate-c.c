#include <stdio.h>
#include <stdlib.h>
#include <math.h>

//The calculation function
//Param: n: The number of digits to be calculated
//Param: arr: The resulting array after calculations are done
void ecalculation(int n, int arr[]) {
	int m = 4;
	float test = (n + 1) * 2.30258509;
	while (m * (log(m) - 1.0) + 0.5 * log(6.2831852 * m) <= test) {
    	m = m + 1;
	}

	int coef[m];

	for (int j = 2; j < m; j++) {
	    coef[j] = 1;
	}

	arr[0] = 2;

	for (int i = 1; i <= n; i++) {
		int carry = 0;
		for (int j = m - 1; j > 1; j--) {
			int temp = coef[j] * 10 + carry;
			carry = temp / j;
			coef[j] = temp - carry * j;
		}
		arr[i] = carry;
	}
}

//Main program loop
int main() {
	FILE *fp;
	int numOfItems = 1;

	//Get user input and run the calculations for e
	printf("Enter a positive number of decimal points to calculate for e\n");
	scanf("%d", &numOfItems);
	int *arrayOfDigits = malloc((numOfItems + 1) * sizeof(int));
	ecalculation(numOfItems, arrayOfDigits);

	//Write the results to a user-inputted filename
	char fileName[50];
	printf("Enter the name of the file to store the value of e (Max 50 characters)\n");
	scanf("%s", fileName);

	fp = fopen(fileName, "wb");
	for (int i = 0; i < numOfItems + 1; i++) {
		//Print the decimal place
		if (i == 0) {
			fprintf(fp, "%d.", arrayOfDigits[i]);
		}
		else {
			fprintf(fp, "%d", arrayOfDigits[i]);
		}
	}
	//Free any allocated memory at the end
	fclose(fp);
	free(arrayOfDigits);

	return 0;
}