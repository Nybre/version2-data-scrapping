library(rmarkdown)

#Get the working directory
#put the Rmd file in the working directory
output_dir <- getwd() #this can be made a working directory string

render("testing.Rmd", output_format = "word_document",output_dir = output_dir, params = list(output_dir = output_dir),
       output_file = file.path(dirname(output_dir), 'BigRock_Media.pdf'))

library(readtext)
library(reticulate)
#extracts hyperlinks from the word doc using python script
#There is nothing as far as am aware to extract hyperlinks directly in R, resorted to python


#you will enter customer name here to extract info on (So far enter the name and domain)
#can be optimised to only enter customer name

#2 example tests

customer_name="Big Rock Brewery bigrockbeer.com"
#customer_name="CubicFarm Systems cubicfarms.com"

source_python("extract.py")
#Can sorce hyperlinks by index
 
#---------------list of the .docs file you are to read from
#read document from a list of .docs files in R to extract text 

doc.text <- readtext(c("Peterson.docx","Peterson1.docx"))$text 

#combine all the text and update doc.text
doc.text=paste(doc.text[1],doc.text[2])

 #split text into indexes
doc.parts <- strsplit(doc.text, "\n")[[1]]  
# The text in between these 2 keywords will be abstract text:
Keywords.loc <- grep("Keywords:", doc.parts)

#company names (Always sits before the keywords)
company.names = doc.parts[Keywords.loc-1]
 
 
client.location = which(company.names==customer_name) 
#keyword must be connected/located to customer/company name
key_word = doc.parts[Keywords.loc][client.location]
cusomter_name = company.names[client.location]
#extract hyperlink position from name

#----------------------------------manaaging hyperlinks
#this output will manage hyperlinks
 
client.location=grep("bigrockbeer.com",hyperlinks)
#source hyperlink name
ht=c() 
for (t in 1:2){
 ht[t] =paste(hyperlinks[t][[1]][[1]],hyperlinks[t][[1]][[2]])
  }
ht
  
 
 
#-----------------------------------------------------

#------------------------this code below extract relevant articles to the customer name in all the uploaded multiple word docs
#this portion of code needs to be joined or connected to the python hyperlinks through string search
#Top media hits
Top.Media.loc <- grep("Top Media Hits", doc.parts) 
doc.parts[Top.Media.loc]

artitcles_content = paste0(doc.parts[Top.Media.loc[client.location]:(Keywords.loc-1)[client.location+1]],sep=",")
 
#----- Top media hits list
doc.parts[Top.Media.loc+1] 
output=c()
for (var in 1:NROW(artitcles_content)){
  output[var] = toString(doc.parts[Top.Media.loc[client.location]:(Keywords.loc-1)[client.location+1]][var])
} 
output 
output2=paste0(gsub(",","\\\\linebreak", (output))) 
#make the top line output2 to be like below so that you have better looking lines
paste0("test","\\linebreak ", "test2","\\linebreak ", "test3")
#Finally the output2 must be formorted so that it looks nice in R markdown