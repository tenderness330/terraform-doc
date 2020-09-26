let s:terraform_doc_buffer = 'TFDOCBUF'

function! terraform_doc#getcontent(url) abort
	" let url = "https://api.github.com/repos/terraform-providers/terraform-provider-aws/contents/website/docs/r/vpc.html.markdown"
  let lines = readfile(g:terraform_doc_token_filepath) 
  let token = "token " . substitute(lines[0], "\n", "", "")
  let res = webapi#http#get (a:url, {"Authorization": token, "Accept": "application/vnd.github.v3.raw"})
  return res.content
endfunction

function! terraform_doc#getresource() abort
  let curline = substitute(getline("."), '"', "", "g")
  let line_list = split(getline("."))

  if line_list[0] == 'resource'
    let resource["kind"] = "r"
  elseif line_list[0] == 'data'
    let resource["kind"] = "d"
  endif

  let resource["provider"] = split(line_list[0],"_")
  let resource["type"] = substitute(line_list[0] . "_", resource["provider"], "", "")

  return resource
endfunction

function! terraform_doc#generateurl(provider, resource, content) abort
  return 'https://api.github.com/repos/terraform-providers/terraform-provider-' . a:provider
        \ . '/contents/website/docs/' . a:resource . '/' . a:content . '.html.markdown'
endfunction


function! terraform_doc#open_document(content) abort
  let files = s:files()

  if empty(files)
    return
  endif


  if bufexists(s:terraform_doc_buffer)
    let winid = bufwinid(s:terraform_doc_buffer)
    if winid isnot# -1
      call win_gotoid(winid)
    else
      execute 'sbuffer' s:terraform_doc_buffer
    endif

  else
    execute 'new' s:terraform_doc_buffer

    set buftype=nofile

  endif

endfunction

