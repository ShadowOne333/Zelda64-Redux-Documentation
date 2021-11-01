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

;==================================================================================================
; Pause Menu Border Primary Color
;==================================================================================================

.headersize(G_KALEIDO_SCOPE_VRAM - G_KALEIDO_SCOPE_FILE)

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t8, 0xB4B4
;   ori     t8, t8, 0x78FF
.org 0x808227C4
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t8, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t7, 0xB4B4
;   ori     t7, t7, 0x78FF
.org 0x808228EC
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t7, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t9, 0xB4B4
;   ori     t9, t9, 0x78FF
.org 0x80822A94
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t9, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t9, 0xB4B4
;   ori     t9, t9, 0x78FF
.org 0x80822BE0
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t9, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t7, 0xB4B4
;   ori     t7, t7, 0x78FF
.org 0x80822D38
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t7, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t7, 0xB4B4
;   ori     t7, t7, 0x78FF
.org 0x80822E54
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t7, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t8, 0xB4B4
;   ori     t8, t8, 0x78FF
.org 0x8082312C
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t8, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t6, 0xB4B4
;   ori     t6, t6, 0x78FF
.org 0x80823264
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t6, v1, r0

; Replaces:
;   lw      v0, 0x02B0 (s0)
;   lui     t4, 0xB4B4
;   ori     t4, t4, 0x78FF
.org 0x80824928
    jal     hud_colors_get_menu_border_1_color_hook
    lw      v0, 0x02B0 (s0)
    or      t4, v1, r0

;==================================================================================================
; Pause Menu Border Secondary Color
;==================================================================================================

.headersize(G_KALEIDO_SCOPE_VRAM - G_KALEIDO_SCOPE_FILE)

; Color used for bottom panel, Z/R buttons when not selected.
; Replaces:
;   lw      v1, 0x00B4 (sp)
;   lw      t0, 0x002C (sp)
;   lw      ra, 0x00C0 (sp)
;   sw      v0, 0x0004 (v1)
;   lui     a3, 0xFA00
;   lw      v0, 0x02B0 (ra)
;   lui     t9, 0x968C
;   ori     t9, t9, 0x5AFF
.org 0x80823C30
.area 0x20
    lw      v1, 0x00B4 (sp)
    jal     hud_colors_get_menu_border_2_color_1_hook
    sw      v0, 0x0004 (v1)
    or      t9, v0, r0 ;; Move color result to T9.
    lw      t0, 0x002C (sp)
    lw      ra, 0x00C0 (sp)
    lui     a3, 0xFA00
    lw      v0, 0x02B0 (ra)
.endarea

; Z/R button colors when Z selected (part 1).
; Replaces:
;   lui     at, 0x968C
;   addiu   t8, v0, 0x0008
;   sw      t8, 0x02B0 (ra)
;   sw      a3, 0x0000 (v0)
.org 0x80823CD0
    jal     hud_colors_get_menu_border_2_color_2_hook
    sw      a3, 0x0000 (v0)
    lw      ra, 0x00C0 (sp) ;; Restore RA.
    addiu   t8, v0, 0x0008

; Z/R button colors when Z selected (part 2).
; Replaces:
;   ori     at, at, 0x5A00
.org 0x80823CE4
    sw      t8, 0x02B0 (ra)

; R button color when R selected.
; Replaces:
;   lui     at, 0x968C
;   ori     at, at, 0x5A00
;   andi    a0, a0, 0x00FF
.org 0x80823D40
    jal     hud_colors_get_menu_border_2_color_2_hook
    andi    a0, a0, 0x00FF
    lw      ra, 0x00C0 (sp) ;; Restore RA.

; Bottom panel during Song of Soaring map selection.
; Replaces:
;   lw      v1, 0x006C (sp)
;   lw      t0, 0x0030 (sp)
;   lui     a0, 0xFA00
;   sw      v0, 0x0004 (v1)
;   lw      v0, 0x02B0 (s0)
;   lui     t6, 0x968C
;   ori     t6, t6, 0x5AFF
.org 0x80825454
.area 0x1C
    lw      v1, 0x006C (sp)
    jal     hud_colors_get_menu_border_2_color_1_hook
    sw      v0, 0x0004 (v1)
    lw      t0, 0x0030 (sp)
    lui     a0, 0xFA00
    or      t6, v0, r0 ;; Store result in T6.
    lw      v0, 0x02B0 (s0)
.endarea

;==================================================================================================
; Pause Menu Subtitle Text Color
;==================================================================================================

.headersize(G_KALEIDO_SCOPE_VRAM - G_KALEIDO_SCOPE_FILE)

; Color of pause menu subtitle text (when colored).
; Replaces:
;   lui     t6, 0xFFC8
;   ori     t6, t6, 0x00FF
;   addiu   t7, v0, 0x0008
.org 0x80824284
    jal     hud_colors_get_menu_subtitle_text_color_hook
    addiu   t7, v0, 0x0008
    lw      ra, 0x00C0 (sp) ;; Restore RA.

;==================================================================================================
; Song Score Lines Color
;==================================================================================================

.headersize(G_CODE_RAM - G_CODE_FILE)

; Replaces:
;   lui     at, 0x0001
;   addu    at, at, v0
;   sh      a0, 0x2034 (at) ;; Red = 0xFF
;   lui     at, 0x0001
;   addu    at, at, v0
;   sh      r0, 0x2036 (at) ;; Green = 0x00
;   lui     at, 0x0001
;   addu    at, at, v0
;   sh      r0, 0x2038 (at) ;; Blue = 0x00
.org 0x80150C2C
.area 0x24
    sw      v0, 0x0034 (sp) ;; Store V0 in reserved stack space.
    sw      v1, 0x0038 (sp) ;; Store V1 in reserved stack space.
    jal     hud_colors_update_score_lines_color
    lw      a0, 0x0030 (sp) ;; A0 = GlobalContext.
    addiu   a0, r0, 0x00FF  ;; Restore: A0 = 0xFF.
    lw      v0, 0x0034 (sp) ;; Restore V0.
    lw      v1, 0x0038 (sp) ;; Restore V1.
    nop
    nop
.endarea

;==================================================================================================
; Song Score Note Color
;==================================================================================================

.headersize(G_CODE_RAM - G_CODE_FILE)

@ScoreNoteColor equ (HUD_COLOR_CONFIG + 0xBC)

; Replaces:
;   or      v1, v0, r0       ;; V1 = V0.
;   lui     t7, 0xFF64       ;;
;   ori     t7, t7, 0x00FF   ;; T7 = 0xFF6400FF (color value).
;   sw      t7, 0x0004 (v1)  ;; Write lower 32-bits of SetPrimColor instruction (color value).
;   sw      t2, 0x0000 (v1)  ;; Write higher 32-bits of SetPrimColor instruction.
.org 0x80152B4C
    lui     t7, hi(@ScoreNoteColor)
    lw      t7, lo(@ScoreNoteColor) (t7)
    ori     t7, t7, 0x00FF   ;; Alpha = 0xFF.
    sw      t7, 0x0004 (v0)
    sw      t2, 0x0000 (v0)

;==================================================================================================
; Shop Cursor Color
;==================================================================================================

; Write cursor color for Trading Post.
.headersize(G_EN_OSSAN_VRAM - G_EN_OSSAN_FILE)
.org 0x808AAAF8 ; Offset: 0x2A58
    addiu   a1, a0, 0x220 ;; A1 = Output array.
    mfc1    a2, f0        ;; A2 = Amount.
    j       HudColors_WriteShopCursorColor
    or      a3, r0, r0    ;; A3 = Shop type (0).

; Write cursor color for Curiosity Shop.
.headersize(G_EN_FSN_VRAM - G_EN_FSN_FILE)
.org 0x80AE2D90 ; Offset: 0x1220
    addiu   a1, a0, 0x3B4  ;; A1 = Output array.
    mfc1    a2, f0         ;; A2 = Amount.
    j       HudColors_WriteShopCursorColor
    ori     a3, r0, 0x0001 ;; A3 = Shop type (1).

; Write cursor color for Bomb Shop, Goron Shop, Zora Shop.
.headersize(G_EN_SOB1_VRAM - G_EN_SOB1_FILE)
.org 0x80A0EFDC ; Offset: 0x27CC
    addiu   a1, a0, 0x30C  ;; A1 = Output array.
    mfc1    a2, f0         ;; A2 = Amount.
    j       HudColors_WriteShopCursorColor
    ori     a3, r0, 0x0002 ;; A3 = Shop type (2).

; Write cursor color for Potion Hut.
.headersize(G_EN_TRT_VRAM - G_EN_TRT_FILE)
.org 0x80A8E56C ; Offset: 0x2DFC
    addiu   a1, a0, 0x3F0  ;; A1 = Output array.
    mfc1    a2, f0         ;; A2 = Amount.
    j       HudColors_WriteShopCursorColor
    ori     a3, r0, 0x0003 ;; A3 = Shop type (3).
