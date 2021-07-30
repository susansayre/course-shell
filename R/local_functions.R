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
  
}