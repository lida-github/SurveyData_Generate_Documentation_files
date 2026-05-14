## Libraries ####

library(grid)
library(stringr)
library(pdftools)
library(png)
library(haven)
library(sjPlot)

## Dirs ####

setwd("...") # Set a working directory

# Set general information ----

document.title.ques <- 'Questionnaire = Klausimynas'
document.title.show <- 'Showcards = Kortelės'
document.title.fldw.rep <- 'Fieldwork report = Lauko darbų ataskaita'
document.title.leaflet <- 'Survey leaflet = Apklausos bukletas'
dataset.citation <- '' # Add citation information for a dataset (e.g.: The Centre for Parliamentary Cooperation, 2026, "Attitudes towards the Seimas, November 2008", https://hdl.handle.net/21.12137/VCZ0FU, Lithuanian Data Archive for SSH (LiDA))
dataset.id.lida <- '' # Add dataset LiDA ID (e.g.: LiDA_SurveyData_0634)
dataset.no <- '' # Add dataset LiDA number (e.g.: 0634)
data.file.version <- '' # Add data file version (e.g.: v2.0)
variables.file.version <- '' # Add variables file version (e.g.: v2.0)
questionnaire.file.version <- '' # Add questionnaire file version (e.g.: v2.0)
showcards.file.version <- '' # Add showcards file version (e.g.: v2.0)
fldw.rep.file.version <- '' # Add fieldwork report file version (e.g.: v2.0)
leaflet.file.version <- '' # Add survey leaflet file version (e.g.: v2.0)


files.dir <- 'files/' # Directory where a data file is stored

# Files and directories ----

files.dir <- 'files/' # Directory where all files are stored
files.dataset.dir <- paste0('files/',dataset.no,'/') # Directory where documentation files are stored

# Importing logo

if (any(grepl("\\.png$",list.files(paste0(files.dir,"logo/")),ignore.case=TRUE))) {
  logo.png <- readPNG(list.files(path=paste0(files.dir,"logo/"),pattern="\\.png$",full.names=TRUE))
}

## Generate files ####

# Generate variable files ----

# Generate variable files: Import data file ----

file <- read_sav(paste0(files.dataset.dir,dataset.id.lida,"_Data_",data.file.version,".sav"))

# Generate variables file: Save file ----

sjPlot::view_df(file,
                alternate.rows=TRUE,
                show.id=TRUE,
                show.type=TRUE,
                show.values=TRUE,
                show.string.values=TRUE,
                show.labels=TRUE,
                show.frq=TRUE, # Comment, when access to an SPSS data file is restricted (or embargo is applied)
                show.prc=TRUE, # Comment, when access to an SPSS data file is restricted (or embargo is applied)
                show.na=TRUE,
                max.len=9999,
                sort.by.name=FALSE,
                wrap.labels=200,
                verbose=FALSE,
                encoding=NULL,
                file=paste0(files.dataset.dir,dataset.id.lida,"_Variables_",variables.file.version,".html"),
                use.viewer=TRUE,
                remove.spaces=TRUE)

# Generate variables file: Add citation info ----

html.file <- readLines(paste0(files.dataset.dir,dataset.id.lida,"_Variables_",variables.file.version,".html"),-1)
html.file[2] <- paste0("<caption><b>Dataset = Duomenų rinkinys</b>: ",dataset.citation,"<br/><br/><b>Data file = Duomenų failas</b>: ",dataset.id.lida,"_Data_",data.file.version,".sav</caption>")
writeLines(html.file,paste0(files.dataset.dir,dataset.id.lida,"_Variables_",variables.file.version,".html"))
writeLines(html.file,paste0(files.dataset.dir,dataset.id.lida,"_Variables_",variables.file.version,".xlsx"))

# Generate documentation files ----

# Original file names should be:
# questionnaire.pdf
# showcards.pdf
# fieldwork_report.pdf
# survey_leaflet.pdf

# Generate documentation files: Questionnaire ----

# Generate title page file for a questionnaire ----

if (file.exists(paste0(files.dataset.dir,"questionnaire.pdf"))) {
  
  cairo_pdf(paste0(files.dataset.dir,"title_page.pdf"),width=8.27,height=11.27) # A4
  
  grid.newpage()
  
  grid.text(document.title.ques,
            y=0.7,
            gp=gpar(fontsize=20,fontface="bold"))
  
  grid.text("Dataset = Duomenų rinkinys:",
            y=0.6,
            gp=gpar(fontsize=16,fontface="bold"))
  
  grid.text(str_wrap(dataset.citation,80),
            y=0.5,
            gp=gpar(fontsize=14))
  
  grid.text(paste0("LiDA ID: ",dataset.id.lida),
            y=0.35,
            gp=gpar(fontsize=12))
  
  grid.text(paste0("Version: ",questionnaire.file.version),
            y=0.32,
            gp=gpar(fontsize=12))
  
  grid.text(paste0(format(Sys.Date(), "%F, "),"Kaunas"),
            y=0.07,
            gp=gpar(fontsize=14))
  
  grid.rect(width=unit(0.9, "npc"),
            height=unit(0.925, "npc"),
            gp=gpar(col="grey70",fill=NA))
  
  if (any(grepl("\\.png$",list.files(paste0(files.dir,"logo/")),ignore.case=TRUE))) {
    
    grid.raster(logo.png,
                y=0.92,
                width=unit(0.25,"npc"))
    
  }
  
  dev.off()
  
}

# Add title page to the questionnaire file ----

if (file.exists(paste0(files.dataset.dir,"questionnaire.pdf"))) {
  
  pdf_combine(c(paste0(files.dataset.dir,"title_page.pdf"),
                paste0(files.dataset.dir,"questionnaire.pdf")),
              output=paste0(files.dataset.dir,dataset.id.lida,"_Questionnaire_",questionnaire.file.version,".pdf"))
  
}

# Generate documentation files: Showcards ----

# Generate title page file for showcards ----

if (file.exists(paste0(files.dataset.dir,"showcards.pdf"))) {
  
  cairo_pdf(paste0(files.dataset.dir,"title_page.pdf"),width=8.27,height=11.27) # A4
  
  grid.newpage()
  
  grid.text(document.title.show,
            y=0.7,
            gp=gpar(fontsize=20,fontface="bold"))
  
  grid.text("Dataset = Duomenų rinkinys:",
            y=0.6,
            gp=gpar(fontsize=16,fontface="bold"))
  
  grid.text(str_wrap(dataset.citation,80),
            y=0.5,
            gp=gpar(fontsize=14))
  
  grid.text(paste0("LiDA ID: ",dataset.id.lida),
            y=0.35,
            gp=gpar(fontsize=12))
  
  grid.text(paste0("Version: ",showcards.file.version),
            y=0.32,
            gp=gpar(fontsize=12))
  
  grid.text(paste0(format(Sys.Date(), "%F, "),"Kaunas"),
            y=0.07,
            gp=gpar(fontsize=14))
  
  grid.rect(width=unit(0.9, "npc"),
            height=unit(0.925, "npc"),
            gp=gpar(col="grey70",fill=NA))
  
  if (any(grepl("\\.png$",list.files(paste0(files.dir,"logo/")),ignore.case=TRUE))) {
    
    grid.raster(logo.png,
                y=0.92,
                width=unit(0.25,"npc"))
    
  }
  
  dev.off()
  
}

# Add title page to the showcards file ----

if (file.exists(paste0(files.dataset.dir,"showcards.pdf"))) {
  
  pdf_combine(c(paste0(files.dataset.dir,"title_page.pdf"),
                paste0(files.dataset.dir,"showcards.pdf")),
              output=paste0(files.dataset.dir,dataset.id.lida,"_Showcards_",showcards.file.version,".pdf"))
  
}

# Generate documentation files: Fieldwork report ----

# Generate title page file for a fieldwork report ----

if (file.exists(paste0(files.dataset.dir,"fieldwork_report.pdf"))) {
  
  cairo_pdf(paste0(files.dataset.dir,"title_page.pdf"),width=8.27,height=11.27) # A4
  
  grid.newpage()
  
  grid.text(document.title.fldw.rep,
            y=0.7,
            gp=gpar(fontsize=20,fontface="bold"))
  
  grid.text("Dataset = Duomenų rinkinys:",
            y=0.6,
            gp=gpar(fontsize=16,fontface="bold"))
  
  grid.text(str_wrap(dataset.citation,80),
            y=0.5,
            gp=gpar(fontsize=14))
  
  grid.text(paste0("LiDA ID: ",dataset.id.lida),
            y=0.35,
            gp=gpar(fontsize=12))
  
  grid.text(paste0("Version: ",fldw.rep.file.version),
            y=0.32,
            gp=gpar(fontsize=12))
  
  grid.text(paste0(format(Sys.Date(), "%F, "),"Kaunas"),
            y=0.07,
            gp=gpar(fontsize=14))
  
  grid.rect(width=unit(0.9, "npc"),
            height=unit(0.925, "npc"),
            gp=gpar(col="grey70",fill=NA))
  
  if (any(grepl("\\.png$",list.files(paste0(files.dir,"logo/")),ignore.case=TRUE))) {
    
    grid.raster(logo.png,
                y=0.92,
                width=unit(0.25,"npc"))
    
  }
  
  dev.off()
  
}

# Add title page to the fieldwork report file ----

if (file.exists(paste0(files.dataset.dir,"fieldwork_report.pdf"))) {
  
  pdf_combine(c(paste0(files.dataset.dir,"title_page.pdf"),
                paste0(files.dataset.dir,"fieldwork_report.pdf")),
              output=paste0(files.dataset.dir,dataset.id.lida,"_Fieldwork_report_",fldw.rep.file.version,".pdf"))
  
}

# Generate documentation files: Survey leaflet ----

# Generate title page file for survey leaflet ----

if (file.exists(paste0(files.dataset.dir,"survey_leaflet.pdf"))) {
  
  cairo_pdf(paste0(files.dataset.dir,"title_page.pdf"),width=8.27,height=11.27) # A4
  
  grid.newpage()
  
  grid.text(document.title.leaflet,
            y=0.7,
            gp=gpar(fontsize=20,fontface="bold"))
  
  grid.text("Dataset = Duomenų rinkinys:",
            y=0.6,
            gp=gpar(fontsize=16,fontface="bold"))
  
  grid.text(str_wrap(dataset.citation,80),
            y=0.5,
            gp=gpar(fontsize=14))
  
  grid.text(paste0("LiDA ID: ",dataset.id.lida),
            y=0.35,
            gp=gpar(fontsize=12))
  
  grid.text(paste0("Version: ",leaflet.file.version),
            y=0.32,
            gp=gpar(fontsize=12))
  
  grid.text(paste0(format(Sys.Date(), "%F, "),"Kaunas"),
            y=0.07,
            gp=gpar(fontsize=14))
  
  grid.rect(width=unit(0.9, "npc"),
            height=unit(0.925, "npc"),
            gp=gpar(col="grey70",fill=NA))
  
  if (any(grepl("\\.png$",list.files(paste0(files.dir,"logo/")),ignore.case=TRUE))) {
    
    grid.raster(logo.png,
                y=0.92,
                width=unit(0.25,"npc"))
    
  }
  
  dev.off()
  
}

# Add title page to the survey leaflet file ----

if (file.exists(paste0(files.dataset.dir,"survey_leaflet.pdf"))) {
  
  pdf_combine(c(paste0(files.dataset.dir,"title_page.pdf"),
                paste0(files.dataset.dir,"survey_leaflet.pdf")),
              output=paste0(files.dataset.dir,dataset.id.lida,"_Survey_leaflet_",leaflet.file.version,".pdf"))
  
}

# Clean-up ----

file.remove(c(paste0(files.dataset.dir,"questionnaire.pdf"),
              paste0(files.dataset.dir,"showcards.pdf"),
              paste0(files.dataset.dir,"fieldwork_report.pdf"),
              paste0(files.dataset.dir,"survey_leaflet.pdf"),
              paste0(files.dataset.dir,"title_page.pdf")))

## End ####
