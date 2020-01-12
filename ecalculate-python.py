import math

# The calculation function
# Param: n: The number of digits to be calculated
# Return: The array of calculated values
def ecalculation(n):
  # Initialize return array with n + 1 digits (to account for beginning 2), add 1 to input because decimal points
  n = n + 1
  d = [None] * (n + 1)
  m = 4
  test = (n + 2) * 2.30258509

  while m * (math.log(m) - 1.0) + 0.5 * math.log(6.2831852 * m) <= test:
    m = m + 1

  # Initialize coef array, fill it with 1s (first 2 elements will not be reached and are None)
  coef = [None] * m
  for j in range (2, m):
    coef[j] = 1

  d[0] = 2
  # Calculate each value individually
  for i in range (1, n + 1):
    carry = 0
    # Note that array indices cause me to sub 1 from the bounds
    for j in range (m - 1, 1, -1):
      temp = coef[j] * 10 + carry
      carry = temp // j
      coef[j] = temp - carry * j
    d[i] = carry
  return d

# Get user input
arrayOfDigits = ecalculation(int(input("Enter a positive number of decimal points to calculate for e ")))
filename = input("Enter the name of the file to store the value of e ")

# Push results to the user-inputted filename
f = open(filename, "w")
for i in range (0, len(arrayOfDigits) - 1):
    if i == 0:
        # include decimal place
        f.write(str(arrayOfDigits[i]) + ".")
    else:
        f.write(str(arrayOfDigits[i]))
f.close()