        .pc = $810
        
        sei         ; irq-k letiltasa
        lda #1
        sta $d01a   ; raszter irq kerelem
        lda #$1b
        sta $d011
        lda #$80
        sta $d012   ; a megszakitas helye, rasztersorokban
        lda #$7f
        sta $dc0d   ; a cia irq-inak letiltasa
        lda #<irq
        ldx #>irq
        sta $314
        stx $315    ; irq vektor atiranyitasa
        cli         ; irq-k engedelyezese
        rts         ; vissza basicbe
        
irq:    inc $d019   ; irq. ack.
        nop
        nop
        nop
        nop
        nop
        nop
        lda #1
        sta $d020
        sta $d021   ; szinek
        ldx #10     ; varakozas, ures ciklus
        dex
        bne *-1
        lda #14
        sta $d020
        lda #6
        sta $d021   ; szinek vissza
        jmp $ea31   ; eredeti irq-handler

; hat, ennyi lett volna. cheers!