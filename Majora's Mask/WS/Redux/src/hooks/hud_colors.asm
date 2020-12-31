;==================================================================================================
; A, B, C buttons color hooks
;==================================================================================================

.headersize (G_CODE_RAM - G_CODE_FILE)

; Custom color for A button.
; Replaces:
;   andi    t4, t3, 0x00FF
;   or      t5, t4, at
.org 0x80118DFC ; In rom: 0xAFEE5C
    jal     hud_colors_get_a_button_color_hook
    andi    t4, t3, 0x00FF

; Custom color for B button.
; Replaces:
;   addiu   t8, r0, 0x0078
;   ori     at, at, 0x69E8
;   addiu   t7, r0, 0x0064
;   addiu   t6, r0, 0x00FF
.org 0x801171A0 ; In rom: 0xAFD200
    jal     hud_colors_get_b_button_color_hook
    ori     at, at, 0x69E8
    andi    t6, t6, 0x00FF
    andi    t8, t8, 0x00FF

; Custom colors for C buttons and Start button.
; Replaces:
;   lh      t8, 0x002A (sp)
;   or      t9, t6, t7
;   andi    t6, t8, 0x00FF
;   or      t7, t9, t6
.org 0x8010D40C ; rom: 0xAF346C
    sw      ra, -0x0004 (sp)
    jal     hud_colors_get_c_start_button_color_hook
    lh      t8, 0x002A (sp)
    lw      ra, -0x0004 (sp)

; Custom color for C button triangle (left).
; Replaces:
;   lh      t6, 0x026A (t4)
;   andi    t8, t6, 0x00FF
;   or      t9, t8, t2
.org 0x801178F4 ; In rom: 0xAFD954
    nop
    jal     hud_colors_get_c_button_triangle_color_hook
    lh      t6, 0x026A (t4)

; Custom color for C button triangle (bottom).
; Replaces:
;   lh      t6, 0x026C (t4)
;   andi    t8, t6, 0x00FF
;   or      t9, t8, t2
.org 0x80117928 ; In rom: 0xAFD988
    nop
    jal     hud_colors_get_c_button_triangle_color_hook
    lh      t6, 0x026C (t4)

; Custom color for C button triangle (right).
; Replaces:
;   lh      t6, 0x026E (t4)
;   andi    t8, t6, 0x00FF
;   or      t9, t8, t2
.org 0x80117950 ; In rom: 0xAFD9B0
    nop
    jal     hud_colors_get_c_button_triangle_color_hook
    lh      t6, 0x026E (t4)

;==================================================================================================
; Clock color hooks
;==================================================================================================

; Custom color for clock.
; Replaces:
;   lui     at, 0x00AA
;   ori     at, at, 0x6400
;   addiu   t9, v0, 0x0008
;   sw      t9, 0x02A0 (s0)
;   or      t8, ra, at
.org 0x8011A110 ; In rom: 0xB00170
    addiu   t9, v0, 0x0008
    sw      ra, -0x0004 (sp)
    jal     hud_colors_get_clock_emblem_color_hook
    sw      t9, 0x02A0 (s0)
    lw      ra, -0x0004 (sp)

; Custom color for inverted clock (red).
; Replaces:
;   addu    t0, t0, t2
;   lh      a0, 0xFBCC (a0)
;   lh      t0, 0xFBEC (t0)
;   lui     t5, 0x801C
.org 0x80119B38 ; In rom: 0xAFFB98
    sw      ra, -0x0004 (sp)
    jal     hud_colors_get_inverted_clock_emblem_color_r_hook
    lh      a0, 0xFBCC (a0)
    lw      ra, -0x0004 (sp)

; Custom color for inverted clock (green).
; Replaces:
;   lh      t5, 0xFBD0 (t5)
;   lh      a2, 0xFBF0 (a2)
;   lui     a3, 0x801C
;   lui     t3, 0x801C
.org 0x80119C04 ; In rom: 0xAFFC64
    sw      ra, -0x0004 (sp)
    jal     hud_colors_get_inverted_clock_emblem_color_g_hook
    lh      t5, 0xFBD0 (t5)
    lw      ra, -0x0004 (sp)

; Custom color for inverted clock (blue).
; Replaces:
;   lui     a0, 0x801C
;   addu    a0, a0, t2
;   lh      a3, 0xFBD4 (a3)
;   lh      a0, 0xFBF4 (a0)
.org 0x80119CC8 ; In rom: 0xAFFD28
    sw      ra, -0x0004 (sp)
    jal     hud_colors_get_inverted_clock_emblem_color_b_hook
    lh      a3, 0xFBD4 (a3)
    lw      ra, -0x0004 (sp)

; Fix calculated color for inverted clock emblem.
; Replaces:
;   sll     t6, t8, 16
;   sll     t7, t9, 24
;   or      t9, t7, t6
;   ori     t8, t9, 0xFF00
.org 0x8011A078
    sw      ra, -0x0004 (sp)
    jal     hud_colors_fix_inverted_clock_emblem_color_calc_hook
    sll     t6, t8, 16
    lw      ra, -0x0004 (sp)

; Custom color for clock emblem sun icon.
; Replaces:
;   lui     at, 0xFFFF
;   ori     at, at, 0x6E00
;   andi    t9, t7, 0x00FF
;   or      t6, t9, at
.org 0x8011A39C ; In rom: 0xB003FC
    or      a3, t7, r0
    jal     hud_colors_get_clock_emblem_sun_color_hook
    swc1    f2, 0x01D0 (sp)
    lwc1    f2, 0x01D0 (sp)

; Custom color for clock emblem sun icon (blinking).
; Replaces:
;   lui     at, 0xFFFF
;   addiu   t8, v0, 0x0008
;   sw      t8, 0x02A0 (s0)
;   sw      t7, 0x0000 (v0)
;   lh      t9, 0x0000 (a1)
;   ori     at, at, 0x6E00
;   andi    t6, t9, 0x00FF
;   or      t8, t6, at
.org 0x8011A3C0 ; In rom: 0xB00420
    addiu   t8, v0, 0x0008
    sw      t8, 0x02A0 (s0)
    sw      t7, 0x0000 (v0)
    lh      a3, 0x0000 (a1)
    jal     hud_colors_get_clock_emblem_sun_color_hook
    swc1    f2, 0x01D0 (sp)
    lwc1    f2, 0x01D0 (sp)
    ; Move return value from T6 to T8
    or      t8, t6, r0

; Custom color for clock sun icon.
; Replaces:
;   ori     at, at, 0x6E00
;   andi    t8, t6, 0x00FF
;   or      t7, t8, at
.org 0x8011A73C ; In rom: 0xB0079C
    jal     hud_colors_get_clock_sun_color_hook
    sh      t0, 0x01C6 (sp)
    lh      t0, 0x01C6 (sp)

; Custom color for clock moon icon.
; Replaces:
;   ori     at, at, 0x3700
;   andi    t9, t7, 0x00FF
;   or      t6, t9, at
.org 0x8011A88C ; In rom: 0xB008EC
    jal     hud_colors_get_clock_moon_color_hook
    sh      t0, 0x01C6 (sp)
    lh      t0, 0x01C6 (sp)

;==================================================================================================
; Heart colors hooks
;==================================================================================================

; Custom colors for hearts.
; Replaces:
;   jal     0x8010069C
.org 0x80121534 ; In rom: 0xB07594
    jal     hud_colors_update_heart_colors

;==================================================================================================
; Map color hooks
;==================================================================================================

; Custom color for map (original: #00FFFFA0)
; Replaces:
;   andi    t6, t9, 0x00FF
;   or      t5, t8, t6
.org 0x801032F4 ; In rom: 0xAE9354
    jal     hud_colors_get_map_color_hook
    nop

;==================================================================================================
; Song A + C Button Note Colors
;==================================================================================================

; Write colors for A, C button note icons.
; Replaces:
;   jal     0x80147564
.org 0x80151F90
    jal     hud_colors_update_button_note_colors

; Replaces:
;   jal     0x80147564
.org 0x80154614
    jal     hud_colors_update_button_note_colors

; Replaces:
;   jal     0x80147564
.org 0x80155178
    jal     hud_colors_update_button_note_colors

;==================================================================================================
; Song A + C Button Note Colors (Pause Menu)
;==================================================================================================

.headersize (G_KALEIDO_SCOPE_VRAM - G_KALEIDO_SCOPE_FILE)

; Get "A" button note color (when not playing).
; RDRAM: 0x8074C2AC, offset: 0x138C
; Replaces:
;   lui     t8, 0x5096
;   ori     t8, t8, 0xFFC8
.org 0x8081742C
    jal     hud_colors_pause_1_get_note_a_color_hook
    ori     at, r0, 0

; Get "C" button note color (when not playing).
; RDRAM: 0x8074C2D0, offset: 0x13B0
; Replaces:
;   lui     t9, 0xFFFF
;   ori     t9, t9, 0x32C8
.org 0x80817450
    jal     hud_colors_pause_1_get_note_c_color_hook
    ori     at, r0, 1

; Get "A" button note color (when playing).
; RDRAM: 0x8074C0D4, offset: 0x11B4
; Replaces:
;   lui     at, 0x5096
;   ori     at, at, 0xFF00
.org 0x80817254
    jal     hud_colors_pause_2_get_note_color_hook
    ori     at, r0, 0

; Get "C" button note color (when playing).
; RDRAM: 0x8074C104, offset: 0x11E4
; Replaces:
;   lui     at, 0xFFFF
;   ori     at, at, 0x3200
.org 0x80817284
    jal     hud_colors_pause_2_get_note_color_hook
    ori     at, r0, 1

; Get "A" button note color (when replaying).
; RDRAM: 0x8074C4D4, offset: 0x15B4
; Replaces:
;   lui     at, 0x5096
;   ori     at, at, 0xFF00
.org 0x80817654
    jal     hud_colors_pause_2_get_note_color_hook
    ori     at, r0, 0

; Get "C" button note color (when replaying).
; RDRAM: 0x8074C504, offset: 0x15E4
; Replaces:
;   lui     at, 0xFFFF
;   ori     at, at, 0x3200
.org 0x80817684
    jal     hud_colors_pause_2_get_note_color_hook
    ori     at, r0, 1
