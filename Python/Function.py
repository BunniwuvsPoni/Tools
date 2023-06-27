# Creating and calling a function

# Basic function
def main():
    userInput = input("What is your input?")
    print("Your input is: ", userInput)

# Function that accepts arguments
def functionWithArguents(arg1, arg2):
    print(arg1," ",arg2)

# Function that returns a value
def functionReturns(x):
    return x * x * x

# Function with a default value for an argument
def functionPower(num, x=1):
    result = 1
    for i in range(x):
            result = result * num
    return result

# Function with a variable number of arguments
def functionMultipleArguments(*args):
    result = 0
    for x in args:
          result = result + x
    return result

# Calling a function
if __name__ == "__main__":
    main()
    functionWithArguents("input 1","input 2")
    print(functionReturns(5))
    print(functionPower(2))
    print(functionPower(2,3))
    print(functionMultipleArguments(1,3,6))
