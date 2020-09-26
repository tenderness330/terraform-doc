if exists(g:loaded_terraform_doc)
  finish
endif

let g:loaded_terraform_doc = 1
let g:terraform_doc_token_filepath = "~/.token"

command! Tfdoc call terraform_doc#open_document()
