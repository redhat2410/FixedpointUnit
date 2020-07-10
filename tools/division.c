#include <stdio.h>

int divide(long long divdend, long long divisor){
    int sign = ((divdend < 0) ^ (divisor < 0)) ? -1 : 1;
    long long t_dividend = abs(divdend);
    long long t_divisor = abs(divisor);

    long long quotient = 0, temp = 0;
    for(int i = 31; i >= 0; --i){
        if(temp + (t_divisor << i) <= t_dividend){
            temp += t_divisor << i;
            quotient |= 1LL << i;
        }
    }
    return sign * quotient;
}

int main(){
    int a = 10, b = 3;
    printf("%d\n", divide(a, b));
    a = 43, b = -8;
    printf("%d\n", divide(a, b));
}