#Exercise 1: Calculate the multiplication and sum of two numbers

def multiply_and_check():
  a = int(input('Get number1 : '))
  b = int(input('Get number2 : '))
  c = a*b
  if c <= 1000:
    return c
  else:
    return a+b


#Exercise 2: Print the sum of the current number and the previous number

previous_number = 0
for i in range(10):
  current_number = i 
  sum = current_number + previous_number
  print (f'current number {current_number} previous number {previous_number} sum {sum}')
  previous_number = current_number 

#Exercise 3: Print characters from a string that are present at an even index number

str = input('Enter the value : ')

for i in range(len(str)):
  if i%2 == 0:
    print(str[i])
