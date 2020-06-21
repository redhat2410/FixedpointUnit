
scale = 28

def fixed2Double(num):
    return num / float(1 << scale)

def double2Fixed(num):
    return int(num * ( 1 << scale ))

def add(a, b):
    return a + b

def sub(a, b):
    return a - b

def mul(a, b):
    return (a * b) >> scale

def div(a, b):
    return (a << scale) / b

def inputFunc(num):
    value = []
    for i in range(num):
        temp = input("Enter a value  " + str(i) + " :")
        value.append(temp)
    return value


print("-------------Fixed Point-----------")
print("1.Addition")
print("2.Subtraction")
print("3.Multiplication")
print("4.Division")
print("5.Double to Fixed")
print("6.Fixed to Double")
print("7.Exit")
#selec operator + - * / ...
sel = 0
while sel != 7:
    sel = input("Enter a operator: ")
    #convert double to fixed-point
    if sel == 1 or sel == 2 or sel == 3 or sel ==4 :
        l_value = inputFunc(2)
        A = double2Fixed(l_value[0])
        B = double2Fixed(l_value[1])
        print("Input: " + str(hex(A)) + " (hex)")
        print("Input: " + str(hex(B)) + " (hex)")
        result = 0
        if sel == 1:
            result = add(A, B)
        elif sel == 2:
            result = sub(A, B)
        elif sel == 3:
            result = mul(A, B)
        elif sel == 4:
            result = div(A, B)
        else:
            pass
        ###########################
        print("Result: " + str(hex(result)) + " (hex)")
        print("Result: " + str(fixed2Double(result)) + " (float)")
    elif sel == 5 or sel == 6:
        l_value = inputFunc(1)
        if sel == 5:
            print("Result: " + str(double2Fixed(l_value[0])) + " (dec)" )
            print("Result: " + str(hex(double2Fixed(l_value[0]))) + " (hex)")
        elif sel == 6:
            print("Result: " + str(fixed2Double(l_value[0])) + " (float)")
        else:
            pass
    else:
        pass

