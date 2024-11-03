function DetectGoHtmlTmpl()
    if (expand('%:e') == "html" && search("{{") != 0)
        setfiletype html
    endif
endfunction

function SetGoHtmlTmpl()
    setfiletype html
endfunction

augroup filetypedetect
    " gohtmltmpl
    au BufRead,BufNewFile *.html call DetectGoHtmlTmpl()
    au BufRead,BufNewFile *.gohtml call SetGoHtmlTmpl()
augroup END

