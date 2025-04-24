;Anas Al Sayed-1221020  | Abd Al-Rheem Yaseen-1220783

.model small
.stack 100h
.data
    ; Employee IDs (16-bit numbers)
    idArray DW 65, 148, 526, 2036, 1504, 82,112, 2840,940,1292

    ; Passwords (8-bit numbers) - 
    passArray DB 252, 21, 156, 164, 238, 246, 143, 202, 99, 252 
    
    ;Password Encrypted:
     
    ;ID=65     PASS--> 125  0111 1101  --After Encrypted--> 252  1111 1100  (swap)
    ;ID=148    PASS--> 84   0101 0100  --After Encrypted--> 21   0001 0101  (rotate)
    ;ID=526    PASS--> 29   0001 1101  --After Encrypted--> 156  1001 1100  (swap)
    ;ID=2036   PASS--> 37   0010 0101  --After Encrypted--> 164  1010 0100  (swap)
    ;ID=1504   PASS--> 187  1011 1011  --After Encrypted--> 238  1110 1110  (rotate)
    ;ID=82     PASS--> 219  1101 1011  --After Encrypted--> 246  1111 0110  (rotate)
    ;ID=112    PASS--> 62   0011 1110  --After Encrypted--> 143  1000 1111  (rotate)
    ;ID=2840   PASS--> 75   0100 1011  --After Encrypted--> 202  1100 1010  (swap)
    ;ID=940    PASS--> 141  1000 1101  --After Encrypted--> 99   0110 0011  (rotate)
    ;ID=1292   PASS--> 243  1111 0011  --After Encrypted--> 252  1111 1100  (rotate)    
    
    
    msg  DB '_____Anas Al Sayed- 1221020_____________________Abd Al-Rheem Yaseen- 1220783____'  ,'$'
    msg0 DB '______________________________Security lock_____________________________________' ,'$'
                                                                                               
    msg1 DB 0DH,0AH,"Please enter the employee ID: $"
    msg2 DB 0DH,0AH,"Please enter the employee Password: $"
    msgAccessAllowed DB 0DH,0AH,"Access Allowed!$"
    msgAccessDenied DB 0DH,0AH,"Access Denied!$" 
    
    newline DB 0Dh, 0Ah, '$'    
    
    
    num db 198
    id dw 940

    idBuff DB 50,?,50 DUP(?)   ; Buffer to store the user-entered ID
    passBuff DB 50,?,50 DUP(?) ; Buffer to store the user-entered Password
      
    index DB 0  
      
      
.code
.startup  



     ;Display "Please enter the employee ID:"
     ;************************
         mov ah, 09h
         lea dx, msg
         int 21h  
         
         mov ah, 09h 
         lea dx, newline
         int 21h 
         
         mov ah, 09h
         lea dx, msg0
         int 21h  
         
         mov ah, 09h
         lea dx, newline
         int 21h
     ;************************
          
          
          
          
          
     ;Display "Please enter the employee ID:"
     ;************************
         mov ah, 09h
         lea dx, msg1
         int 21h
    
     ;************************
     
     
     
     
     
     
     ; Read a Employee ID from the user
     ;************************ 
         mov cx, 0          
         xor ah,ah
      read_loop:
   
         mov ah, 01h        
         int 21h            
         xor ah,ah
   
   
         cmp al, 0Dh
         je done_reading    

   
         sub ax, 30h        

     ;Multiply the current number by 10
         add cx,ax
         mov bx,10
         mov ax,cx
         mul bx
   

    
         mov cx, ax        

     ;Loop back to read the next character
        jmp read_loop

      done_reading:
         mov ax,cx
         div bx
         mov cx,ax

     ;************************ 
      
 
 
            
            
            
 
     ;Find the ID Index 
     ;************************  
 
         xor bx,bx
         mov bx,cx
         xor cx,cx
         mov cl,10
         xor si,si
      
       
      next: 
         mov ax,[idArray+si]
      
       cmp ax,bx
        jz enterPassword;  
    
    
         add si,2 
         dec cl
        jnz next
        jmp notallowed
     ;************************  
      
      
      
      
      
      
                        
     ; Display "Please enter the employee Password:"          
     ;************************            
      enterPassword:
        mov ah, 09h
        lea dx, msg2
        int 21h
        
        mov index,cl     
     ;************************   
        
        
        
        
        
        
    
    
     ; Read a Password from the user
     ;************************ 
        mov cx, 0          
        xor ah,ah  
        
      read_loop1:
        mov ah, 08h        
        int 21h            
        xor ah,ah
  
        cmp al, 0Dh
        je done_reading1    


        sub ax, 30h       

    ;Multiply the current number by 10
        add cx,ax
     
        mov bx,10
        mov ax,cx
        mul bx
   
         mov cx, ax        
        jmp read_loop1

      done_reading1:
        mov ax,cx
        div bx
        mov cx,ax
        mov ch,ch
    ;************************
  
         
         
         
         
         
            
            
    ;Encryption of the Password
    ;************************
      compLeast:
        xor bx,bx 
        mov bl,cl 
              
         test bl,00000001
          jz  compMost0
          jnz compMost1 
              
      compMost0:
         test bl,80h
           jz equal
           jnz notEqual
              
              
      compMost1:
         test bl,80h
           jz notEqual
           jnz equal 
              
      equal: ;(rotate)
         ror bl,1
         ror bl,1
           jmp res
                
      notEqual:;(swap)
         xor bl,80h
         xor bl,00000001
           jmp res
               
               
       res: 
         mov cl,bl
         jmp comparing
    ;************************        
            
            
            
            
           
    ;Comparing the User Password with the Encrypted Password
    ;************************ 
    comparing:
    xor si,si
    mov bl,index     
    
    mov si,10
    mov bh,0
    sub si,bx
     
    mov al,[passArray+si]   
    xor bx,bx
    mov bl,cl  
    cmp al,bl
    jz allowed;  
    jmp notallowed
    ;************************
  
  
    allowed:
    mov ah, 09h
    lea dx, msgAccessAllowed
    int 21h
    jmp exit
    
    notallowed:
    mov ah, 09h
    lea dx, msgAccessDenied
    int 21h   
     
     
     
    exit:
    mov ah, 09h
    lea dx, newline
    int 21h 

.exit
end