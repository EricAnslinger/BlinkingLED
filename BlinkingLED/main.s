		
; ------------------------------- exportierte Funktionen -----------------------------------		
	EXPORT  main			
	AREA	main_s,code		
		
main PROC
   
   ldr R0, = (((0x40000000 + 0x00020000) + 0x1000) + 0x4C)  ;Lade RCC_AHB2ENR in Register 0
   ldr R1, =1            ;Schalte den Strom ein 
   str R1, [R0]         ;Speichere den Wert R1 an Adresse R0
   
   ldr R0, = (((0x40000000 + 0x08000000) + 0x0000) + 0x00)  ;GPIOA_MODDER
   ldr R1, [R0]         ;Lade Werte aus Adresse an R1
   ldr R2, =0xFFFF0000  ; Lade folgenden Hexadezimalwert in R2
   and R1, R1, R2       ; Verunde, um aktuelle Werte der Register 16 bis 31 beibehalten zu können
   ldr R2, =0x00000001  ;Aktiviere mit 01 den Output für Pin A0
   orr R1, R2           ; Verodere, damit der Wert davor und der aktualisierte Wert gespeichert werden kann
   str R1, [R0]         ;Speichere die Werte an der Speicheradresse
   
   
blink_loop   
   
   ldr R0, =(((0x40000000 + 0x08000000) + 0x0000) + 0x18) ;GPIOA_BSRR
   ldr R1,=0x00000001    ;Schalte LED A0 an
   str R1, [R0]          ;Speichere die Werte an der Speicheradresse
   
                         ; Verzögerungsschleife (größere Zahl für langsames Blinken)
   LDR R0, =1600000
schleife
   SUB R0, R0, #1         ; Subtrahiere 1 von R0
   CMP R0, #0             ; Wenn R0 == 0, beende die Schleife
   BGT schleife           ; Andernfalls wiederhole
   
   ldr R0, =(((0x40000000 + 0x08000000) + 0x0000) + 0x18) ;GPIOA_BSRR
   ldr R1,=0x00010000
   str R1, [R0]
   
      ; Verzögerungsschleife
   LDR R0, =1600000
schleife2
   SUB R0, R0, #1         
   CMP R0, #0
   BGT schleife2
   
   B blink_loop           ;Springe zurück zu blink_loop
     
  ENDP

   END
		