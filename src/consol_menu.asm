section .data
 msg: db 10,10,"[Hello and welcome to my programme]",10
     db "[You have in front of you 4 options each onr will give you an encrypted sting",10
     db "your goal is to desencrypte all these strings and get the user_input]",10
 msglen: equ $-msg

 options: db 10,"1 - Talk to a friend",10
          db "2 - how is your day going",10
          db "3 - i hope all is well",10
          db "4 - the finale", 10
          db "5 - Check to see if the user_input is correct",10
          db "6 - Exit",10
          db ">> ",0
 optionslen: equ $-options

 msg_error: db 10,"What were you trying to do?"
 msg_error_length: equ $-msg_error

 ;Ascii
 op1: db "97 53 53 51 109 98 108 121 95", 10
 op1len: equ $-op1

 ;Base 65
 op2: db "MXNf", 10
 op2len: equ $-op2

;Base 13
 op3: db "gu3_", 10
 op3len: equ $-op3

;HEX
 op4: db "62 33 35 74", 10
 op4len: equ $-op4

 op5: db "Well done you have won", 10
 op5len: equ $-op5

 op6: db "I hope you enjoyed", 10
 op6len: equ $-op6

 delay: dq 1, 400000000

section .bss
 choix resb 8

 user_input resb 24


section .text
 global _start

_start:
 jmp .main

.main:

 call .message
 call .options
 call .get_option
 call .wait

 jmp .main

.error:
 mov rax, 1
 mov rdi, 1

 mov rsi, msg_error
 mov rdx, msg_error_length
 syscall

 mov rax, 60
 mov rdi, 0
 syscall
 ret

.message:
 mov rax, 1
 mov rdi, 1

 mov rsi, msg
 mov rdx, msglen
 syscall
 ret

.options:
 mov rax, 1
 mov rdi, 1

 mov rsi, options
 mov rdx, optionslen
 syscall
 ret 

.get_option:
 mov rax, 0
 mov rdi, 0

 mov rsi, choix
 mov rdx, 8
 syscall
 

 cmp byte [choix], "1"
 je .option1

 cmp byte [choix], "2"
 je .option2

 cmp byte [choix], "3"
 je .option3

 cmp byte [choix], "4"
 je .option4

 cmp byte [choix], "5"
 je .option5

 cmp byte [choix], "6"
 je .option6

 jne .error

 ret

.option1:
 mov rax, 1
 mov rdi, 1

 mov rsi, op1
 mov rdx, op1len

 syscall
 ret  

.option2:
 mov rax, 1
 mov rdi, 1

 mov rsi, op2
 mov rdx, op2len

 syscall
 ret 

.option3:
 mov rax, 1
 mov rdi, 1

 mov rsi, op3
 mov rdx, op3len

 syscall
 ret 

.option4:
 mov rax, 1
 mov rdi, 1

 mov rsi, op4
 mov rdx, op4len

 syscall
 ret 

.option5:
 mov rdi, 0
 mov rax, 0

 mov rsi, user_input
 mov rdx, 24
 syscall
 jmp .check
 ret 

.check:
 cmp byte[user_input], "a553mbly_1s_th3_b35t"
 je .win
 ret

.option6:
 mov rax, 1
 mov rdi, 1

 mov rsi, op6
 mov rdx, op6len
 syscall

 mov rax, 60
 mov rdi, 0
 syscall
 ret 

.win: 
 mov rax, 1
 mov rdi, 1

 mov rsi, op5
 mov rdx, op5len
 syscall

 mov rax, 60
 mov rdi, 0
 syscall

 ret

.wait:
 mov rax, 35
 mov rdi, delay
 mov rsi, 1
 syscall
 ret
