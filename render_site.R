files = list.files()
rmd_files = files[grepl("\\.Rmd", files)]

for(i in files){
  rmarkdown::render(i)
}