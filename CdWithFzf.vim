let s:cwd = getcwd()     
let s:fwd = getcwd()     
    
function! UpdateCWD()     
    let s:cwd = getcwd()     
endfunction     
    
function! UpdateFWD()     
    let s:fwd = getcwd()     
endfunction     
    
function Dir_with_fzf(line)     
    if a:line[0] == "-"     
        call fzf#run(fzf#wrap(     
          \ {'source': 'find '.s:cwd.' -type d',    
          \  'sink': 'cd'}))     
    
        let s:cwd = s:fwd     
        call UpdateFWD()     
    else     
        call UpdateCWD()     
    
        call fzf#run(fzf#wrap(     
          \ {'source': 'find '.a:line[0].' -type d',                                                                                                                                          
          \  'sink': 'cd'}))     
    
    
        call UpdateFWD()     
    endif     
    
endfunction     
    
    
command! -nargs=* -complete=dir Cd call Dir_with_fzf([<f-args>]->empty()?'':[<f-args>])    
nnoremap C :Cd<Space>    
