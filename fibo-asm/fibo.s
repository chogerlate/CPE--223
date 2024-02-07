// for x86-64 gcc 
fib:
        // setup stack frame
        push    rbp 
        mov     rbp, rsp
        mov     DWORD PTR [rbp-20], edi // store edi which is the input parameter of nth Fibonacci 
        
        // initial value of Fibonacci sequence
        mov     DWORD PTR [rbp-4], 0 // a
        mov     DWORD PTR [rbp-8], 1 // b
        
        cmp     DWORD PTR [rbp-20], 0  // compare input with 0 (n)
        jne     .L2                    // if n  != 0 jump to .L2
        mov     eax, DWORD PTR [rbp-4] // Loads the first Fibonacci number into eax
        jmp     .L3                    // jump to .L3 
.L2:
        mov     DWORD PTR [rbp-12], 2  //  If n is not 0, initializes a loop counter i to 2
        jmp     .L4 //jump to .L4
.L5:
        mov     edx, DWORD PTR [rbp-4]  //  Loads the current value of b into the edx register
        mov     eax, DWORD PTR [rbp-8]  //  Loads the current value of a into the eax register
        add     eax, edx                // Calculates the next Fibonacci number a + b and stores it in eax
        mov     DWORD PTR [rbp-16], eax // Stores the new a value in memory at [rbp-16]
        mov     eax, DWORD PTR [rbp-8]  // Moves the old a value from eax to rbp-8 to prepare for the next iteration
        mov     DWORD PTR [rbp-4], eax  // Updates the value of b with the old a
        mov     eax, DWORD PTR [rbp-16] // Moves the newly calculated a from [rbp-16] to eax
        mov     DWORD PTR [rbp-8], eax  // Updates the value of a with the new a
        add     DWORD PTR [rbp-12], 1   // Increments the loop counter i
.L4: // comppare current Fibonaccinumber index with the input parameter
        mov     eax, DWORD PTR [rbp-12]
        cmp     eax, DWORD PTR [rbp-20] // Compares the current i (stored in eax) with n
        jle     .L5 // if true continue loop .L5
        mov     eax, DWORD PTR [rbp-8] // Loads the final value of a (the nth Fibonacci number) into eax
.L3: // Marks the end of the loop and the return point
        pop     rbp                    // Restores the caller's base pointer from the stack
        ret                            // Returns from the fib function, passing the nth Fibonacci number in eax
.LC0:
        .string "%d"
main:
        push    rbp  // Saves the caller's base pointer (rbp) onto the stack
        mov     rbp, rsp // Copies the current stack pointer (rsp) to rbp, marking the base of this function's stack frame
        
        sub     rsp, 16 // Allocates 16 bytes on the stack 
        mov     DWORD PTR [rbp-4], 44 // Moves the desired Fibonacci index (44 in this case) into memory at [rbp-4]
        mov     eax, DWORD PTR [rbp-4] // Loads the Fibonacci index from [rbp-4] into eax
        mov     edi, eax // Makes eax the first argument (input) for the fib function
        call    fib // call the fib function
        // print result
        mov     esi, eax // move the result to esi
        mov     edi, OFFSET FLAT:.LC0 // load format string
        mov     eax, 0 
        call    printf
        mov     eax, 0
        leave
        ret
