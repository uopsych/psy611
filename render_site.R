# This script builds on Aleszu Bajak's excellent 
# [tutorial on building a course website using R Markdown and Github pages](http://www.storybench.org/convert-google-doc-rmarkdown-publish-github-pages/). 
# I was excited about the concept but wanted to automate a few of the production steps: namely generating the HTML files 
# for the site from the RMD pages (which Aleszu describes doing one-by-one) and generating the site navigation menu, 
# which Aleszu handcodes in the `_site.yml` file. This script should automate both processes, though it may have some quirks 
# unique to my setup that you'd want to tweak to fit your own. It's likely more loquacious than necessary as well, so feel free 
# to condense as you can. Ideally, each time you make updates to your RMD files you can run this script to generate updated HTML 
# pages and a new `_site.yml`. Then commit changes to Github and you're up and running!

# Once you've got everything configured for your own site below, you should be able to run `source('renderSite.R')` 
# in your console to generate updated HTML files and an updated menu. You could probably add some Github code to the 
# very end to build the commit into the script. 


#list all the RMD files in your site's directory
files <- list.files(path = ".", pattern = '*.Rmd', full.names = FALSE)

#this function runs over all the RMD files and renders them to their default output (hopeful HTML)
lapply(files, function(x) {
  rmarkdown::render(paste0(x))
})

# here I set a few variables for the course that I can paste into the strings below
courseTitle <- "Data Analysis I"
navTitle <- "PSY 611"
profName <- "Sara Weston"
profEmail <- "sweston2@uoregon.edu"

# this generates a list of the HTML files created in lines 8-10
html_files <- list.files(path = ".", pattern = '*.html', full.names = FALSE)

# the code below works through the listed HTML files and generates a list of strings, formatted as required in the 
# `_site.yml` file, that includes each of the site's pages and URLs. It generates the page name in upper case but you could 
# tweak that as desired. This does name the pages based on their HTML filenames; if you wanted something more 
# descriptive you'd have to write some more code here. 

pages <- lapply(html_files, function(x) {
  pageName <- sub('\\.html$', '', x)
  paste0('    - text: \"',paste(toupper(substr(pageName, 1, 1)), substr(pageName, 2, nchar(pageName)), sep=""),'\"\n',
         '      href: ',pageName,'.html','\n')
})

# these collapse the list into a single string. This also renames the "Index" menu item as "Description." 
# I put my course description in the `index.html` file so it's the first thing that loads with the site, 
# but I think calling the page "Index" in the site menu would be confusing for students. If there were other pages you 
# knew you'd want to rename consistently every time you generated the site, you could use the `sub` function to do so.  

pages <- paste(pages, collapse = "")
pages <- sub("Index","Description", pages)

# this pastes the standard boilerplate from the top of the `_site.yml` file together with the list of pages 
# generated above. This also adds a final menu item with a link to email the professor established in the variables above. 

yml <- paste0('name: ',courseTitle,'\n',
              'output_dir: \".\"','\n',
              'navbar:','\n',
              '  title: \"',navTitle,'\"','\n',
              '  left:','\n',
              pages)

# finally, this writes everything generated above into (what should be) a valid `_site.yml` file. 
# Commit the folder to github and everything should be updated!
write(yml, file="_site.yml")