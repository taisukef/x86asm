global _main ; start ラベル（シンボル）は外部から参照可能にする

section .text ; text セクションの開始を定義

_main:
    cmp dword [esp], 2 ; esp のアドレスから double word (4バイト) 分にあるデータと 2 を比較する
    jl .if ; もし 2 未満であれば .if ラベルにジャンプする
    jge .else ; もし 2　以上であれば .else ラベルにジャンプする
.if:
    call func_1 ; func_1 プロシージャを呼ぶ（戻り先アドレスが自動でスタックにプッシュされる）
    jmp .end_if ; .end_if ラベルにジャンプする
.else:
    call func_2 ; func_2 プロシージャを呼ぶ（戻り先アドレスが自動でスタックにプッシュされる）
.end_if:
    push dword eax  ; eax レジスタの内容をスタックにプッシュする
    mov eax, 0x1 ; eax レジスタに 1 を入れる
    sub esp, 4 ; esp レジスタから 4 を引く（Mac のシステムコール時のおまじない）
    int 0x80 ; システムコールを行う

console:
    push dword ebp ; ebp レジスタの内容をスタックにプッシュする。esp レジスタが -4 されるので注意
    mov ebp, esp ; esp レジスタの内容を ebp レジスタに入れる
    push dword [ebp + 12] ; システムコール引数のメッセージの長さをスタックにプッシュする
    push dword [ebp + 8] ; システムコール引数のメッセージのアドレスをスタックにプッシュする
    push dword 1 ; システムコール引数の 1（標準出力）をスタックにプッシュする
    mov eax, 4 ; システムコール番号の 4 を eax レジスタに入れる
    sub esp, 4 ; esp レジスタから 4 を引く（Mac のシステムコール時のおまじない） 
    int 0x80 ; システムコールを行う
    add esp, 16 ; push した引数とおまじないをスタックから消す
    pop ebp ; ebp レジスタの内容をプロシージャ開始時と同じ状態に戻す（作法）
    ret

func_1:
    push dword hello_world_len ; "Hello World!" の長さをスタックにプッシュする
    push dword hello_world ; "Hello World!" のアドレスをスタックにプッシュする
    call console ; console プロシージャを呼ぶ（戻り先アドレスが自動でスタックにプッシュされる）
    add esp, 8 ; push した引数をスタックから消す
    mov eax, 1 ; プロシージャの返り値として 1 を eax レジスタに入れる
    ret ; call 元に戻る

func_2:
    push dword good_night_world_len ; "Goodnight baby." の長さをスタックにプッシュする
    push dword good_night_world ; "Goodnight baby." のアドレスをスタックにプッシュする
    call console ; console プロシージャを呼ぶ（戻り先アドレスが自動でスタックにプッシュされる）
    add esp, 8 ; push した引数をスタックから消す
    mov eax, 2 ; プロシージャの返り値として 2 を eax レジスタに入れる
    ret ; call 元に戻る

section .data ; data セクションの開始を定義
    hello_world: db "Hello World!", 10 ; hello_world というラベルに、文字列のアドレスを入れる
    hello_world_len: equ $ - hello_world ; hello_world_len というラベルに、文字列の長さを入れる
    good_night_world: db "Goodnight baby.", 10 ; good_night_world というラベルに、文字列のアドレスを入れる
    good_night_world_len: equ $ - good_night_world ; good_night_world_len というラベルに、文字列の長さを入れる

section .bss ; bss セクションの開始を定義
    ; 今回は初期値未定義のメモリは確保しない事にした
