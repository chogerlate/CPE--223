#include <stdio.h>
int fib(int n)
{
    int a = 0, b = 1, c, i; 
    if (n == 0)
        return a; // base case
    for (i = 2; i <= n; i++) { // loop until i = n  
        c = a + b;
        a = b;
        b = c;
    }
    return b;
}
 
int main()
{
    int n = 44; // Fibonacci number at nth  
    printf("%d", fib(n)); // print
    return 0;
}