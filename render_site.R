files = list.files()
rmd_files = files[grepl("\\.Rmd", files)]

for(i in rmd_files){
  rmarkdown::render(i)
}