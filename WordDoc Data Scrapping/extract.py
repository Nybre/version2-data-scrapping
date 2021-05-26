import docxpy

#--------------------extract from list of docs files
#extractionf from file 1
#alternatively make an array of file names 
file = 'Peterson.docx' 
# extract hyperlinks from a word doc
doc = docxpy.DOCReader(file)
doc.process()  # process file
hyperlinks = doc.data['links']
 
 
