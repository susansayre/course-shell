library(tidyverse)
library(here)

new_hw <- function(number, dir = "docs/homework", standalone = T, type = "book"){
  
  file_dir <- here::here("content", dir)
  
  filename <- file.path(file_dir, paste0("hw", number, ".Rmd"))
  
  if (file.exists(filename)) {
    stop(paste0(filename, " already exists"))
  }
  
  if (!file.exists(file_dir)){
    dir.create(file_dir, recursive = T)
    
    lines = c("---",
              "title: Homework",
              "icon: tasks",
              "icon_pack: fas",
              "summary: Details on homework",
              "type: book",
              "---",
              "",
              "General info about homework",
              "")
    
    out <- cat(lines, file = file.path(file_dir, "_index.md"), sep = "\n")
  }
  
  x <- readLines(here::here("layouts/page-types", "hw.Rmd"))
  y <- gsub( "Num", as.character(number), x )
  z <- gsub("weight: 1", paste0("weight: ", as.character(number*10)), y)
  
  out <- cat(z, file = filename, sep = "\n")
  file.edit(filename)
}

new_post <- function(title, dir = "post", 
                     standalone = T, 
                     type = "post", 
                     ext = ".Rmd",
                     date = Sys.Date()){
  
  file_dir <- here::here("content", dir)
  
  if (standalone) {
  filename <- file.path(file_dir, str_c(str_replace_all(tolower(title), " ", "-"), ext))
} else {
  
  file_dir <- file.path(file_dir, str_c(str_replace_all(tolower(title), " ", "-")))
  filename <- str_c(file_dir, "/_index", ext)
  
  if (!file.exists(file_dir)){
    dir.create(file_dir, recursive = T)
    
  }}
  
  if (file.exists(filename)) {
    print(paste0(filename, " already exists"))
    return(0)
  }

  x <- c("---",
                 str_c("title: ", title),
                 str_c("date: ", date),
                 "draft: true",
                 "---")
  out <- cat(x, file = filename, sep = "\n")
  file.edit(filename)
  
}

new_assign <- function(filename, name, linkname = name, dir = "docs/assignments"){
  
  file_dir <- here::here("content", dir)
  
  filename <- file.path(file_dir, paste0(filename, ".Rmd"))
  
  if (file.exists(filename)) {
    stop(paste0(filename, " already exists"))
  }
  
  if (!file.exists(file_dir)){
    dir.create(file_dir, recursive = T)
    
    lines = c("---",
              "title: Assignments",
              "icon: tasks",
              "icon_pack: fas",
              "summary: Details on course assignments",
              "type: book",
              "---",
              "",
              "{{<list_children>}}",
              "")
    
    out <- cat(lines, file = file.path(file_dir, "_index.md"), sep = "\n")
  }
  
  x <- readLines(here::here("layouts/page-types", "assignment.Rmd"))
  y <- gsub("assignTitle", name, x )
  z <- gsub("shortname", linkname, y)
  
  out <- cat(z, file = filename, sep = "\n")
  file.edit(filename)
  
}

local_edit <- function(string, path = here::here("content")){
  
  file_list <- list.files(path = path, recursive = T, full.names = T)
  
  #Try .Rmd files first
  my_list <- file_list[str_detect(file_list, str_c(string, ".Rmd"))]

  #Try .md files next
  if (length(my_list)==0) {
    my_list <- file_list[str_detect(file_list, str_c(string, ".md"))]
  }
  
  #Try index files next
  if (length(my_list)==0) {
    long_list <- file_list[str_detect(file_list, string)]
    
    my_list <- long_list[str_detect(long_list, "index.Rmd")]
    
    #Now string/_index.md
    if (length(my_list)==0) {
      my_list <- long_list[str_detect(long_list, "index.md")]
    }
  }
  
  if (length(my_list)==0) {
    
    matches_pattern <- file_list[str_detect(file_list, string)]
    
    if (length(as.list(matches_pattern)) > 1) {
      print(matches_pattern)
      file_number = readline(prompt = "Matches multiple files. Which one do you want to edit?")
      
      file_name <- matches_pattern[as.integer(file_number)] 
    } else {
      file_name <- matches_pattern
    } 
  } else if (length(as.list(my_list))>1) {
    
    print(my_list)
    file_number = readline(prompt = "Matches multiple files. Which one do you want to edit?")
    file_name <- my_list[as.integer(file_number)]
  } else {
    file_name <- my_list
  }
  
  if (!is.null(file_name)) file.edit(file_name)
  
}
