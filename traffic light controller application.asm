; Author: A.K. Bogatsu 
; Date: 16/04/2024
; Title: Traffic Light Controller using PIC16F627
; Description: The purpose of the code is to implement a traffic light controller  
;              that cycles through three states (red, green, yellow, red). It also consists
;              of a pedestrian button that will interrupt the main cycle by switching 
;              to the pedestrian crossing state. The pedestrian crossing state must
;              light a red light for 10 seconds then light a green LED for 10 seconds. 
;              After completion of the pedestrian crossing state the traffic light must
;              return to its previous state and continue its normal cycle.              

; LEDs are connected to PORTB (RB0, RB1, RB2)
; Pedestrian button is connected to RB3
;
; Oscillator type and speed: 4MHz Oscillator using Simulation
; Fuse settings: None 

    ; Define constants
    RED_TIME        EQU 10000     ; 10 seconds in ms
    YELLOW_TIME     EQU 3000      ; 3 seconds in ms
    GREEN_TIME      EQU 10000     ; 10 seconds in ms

    red             EQU 1
    yellow          EQU 2
    green           EQU 3
    pedestrian_red  EQU 7
    pedestrian_green EQU 6
    button          EQU 0

    ; Declare variables - COUNT1 and COUNT2    
    COUNT1 EQU h'20'    ; Define COUNT1 as a variable
    COUNT2 EQU h'21'    ; Delay counter for pedestrian crossing state
    BUTTON_PRESSED EQU h'22' ; Variable to track button press

    ; Setup registers and ports
    ORG h'00'
    GOTO INIT 

    ORG h'04'
    ; Interrupt service routine for button press
    BTFSS INTCON, INTF       ; Check if the interrupt is caused by the button press
    RETFIE                   ; Return from interrupt if not
    BCF INTCON, INTF         ; Clear the interrupt flag
    BSF BUTTON_PRESSED, 0    ; Set the button pressed flag
    RETFIE

INIT:                
    BSF STATUS, RP0          ; Bank 1
    BSF TRISB, button        ; input pin 0 for the button         
    BCF TRISB, red           ; output pin 1 for the red LED
    BCF TRISB, yellow        ; output pin 2 for the yellow LED
    BCF TRISB, green         ; output pin 3 for the green LED
    BCF TRISB, pedestrian_red ; output pin 7 for the pedestrian red LED
    BCF TRISB, pedestrian_green ; output pin 6 for the pedestrian green LED

    BCF STATUS, RP0          ; Bank 0

    ; Initialize INTCON register for interrupts
    BSF INTCON, INTE          ; Enable RB0/INT external interrupt
    BSF INTCON, GIE           ; Enable global interrupt

    BCF BUTTON_PRESSED, 0     ; Clear the button pressed flag

MAIN:
    ; Red state
    BSF PORTB, red            ; Turn on red LED
    CALL DELAY1               ; Wait for RED_TIME (10 seconds)
    BCF PORTB, red            ; Turn off red LED

    ; Check if pedestrian button pressed
    BTFSC BUTTON_PRESSED, 0   ; If button pressed
    GOTO CAUTION              ; Jump to the caution state

    ; Green state
    BSF PORTB, green          ; Turn on green LED
    CALL DELAY1               ; Wait for GREEN_TIME (10 seconds)
    BCF PORTB, green          ; Turn off green LED

    ; Check if pedestrian button pressed
    BTFSC BUTTON_PRESSED, 0   ; If button pressed
    GOTO CAUTION              ; Jump to the caution state

    ; Yellow state
    BSF PORTB, yellow         ; Turn on yellow LED
    CALL DELAY2               ; Wait for YELLOW_TIME (3 seconds)
    BCF PORTB, yellow         ; Turn off yellow LED

    ; Check if pedestrian button pressed
    BTFSC BUTTON_PRESSED, 0   ; If button pressed
    GOTO CAUTION              ; Jump to pedestrian crossing state

    GOTO MAIN                 ; repeat the cycle

CAUTION:
    ; Caution state (Yellow light for cars)
    BSF PORTB, yellow         ; Turn on yellow LED
    CALL DELAY2               ; Wait for YELLOW_TIME (3 seconds)
    BCF PORTB, yellow         ; Turn off yellow LED

    ; Ensure cars stop at the red light
    BSF PORTB, red            ; Turn on red LED

    ; Pedestrian crossing state
    BSF PORTB, pedestrian_red ; Turn on pedestrian red LED
    CALL DELAY1               ; Wait for RED_TIME (10 seconds)
    BCF PORTB, pedestrian_red ; Turn off pedestrian red LED
    BSF PORTB, pedestrian_green ; Turn on pedestrian green LED
    CALL DELAY1               ; Wait for GREEN_TIME (10 seconds)
    BCF PORTB, pedestrian_green ; Turn off pedestrian green LED
    BCF PORTB, red            ; Turn off red LED

    ; Clear the button pressed flag
    BCF BUTTON_PRESSED, 0

    ; Resume normal cycle
    GOTO MAIN

; Delay subroutine in ms
; Delay subroutine in ms
DELAY1:
    	MOVLW D'40'         		; 4MHz clock frequency - 40 cycles per ms
    	MOVWF COUNT1
DELAY_LOOP1:
    	DECFSZ COUNT1, F
    	GOTO DELAY_LOOP1
    	RETURN

; Delay subroutine for pedestrian crossing state in ms
DELAY2:
    	MOVLW D'12'        		; Adjust for shorter delay (3 seconds)
    	MOVWF COUNT2
DELAY_LOOP2:
    	DECFSZ COUNT2, F
    	GOTO DELAY_LOOP2
    	RETURN
    END
