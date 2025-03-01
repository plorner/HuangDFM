#### HuangDFM function
#### Author: Paul Orner
#### University of Southern California
#### Political Science & International Relations PhD program

#### Takes a quanteda corpus of Chinese-language texts
#### and converts them into a Quanteda DFM
#### Function is not entirely stable, and may fail
#### if multiple texts have the same label or if there
#### is no text in a particular entry.
#### Clean your data as necessary!

#### NB This function performs NO PREPROCESSING
#### The default ("mix") jiebaR worker is used
#### for segmentation, however stop words are kept

#### Please note this function is a work in progress!
#### Most aspects of the function have yet to be vectorized,
#### and the conversion to DFM is particularly inefficient -
#### does not scale well for large datasets!

#### Special thanks to Dr. Inaki Sagarzazu of Texas Tech for
#### optimizing the code during the initial stages of the 
#### project - the code has evolved significantly since then,
#### and all inefficiencies and errors should be attributed
#### solely to Orner

### This updated version sems to return MORE results than
### the less efficient original version.  Not sure why yet.

# small test edit for git

library(jiebaR)
library(quanteda)

# Takes a corpus and returns a quanteda DFM
huangdfm <- function(corpus) {
  message("Inititializing JieBa worker...")
  worker.def <- worker()
  
  # Create list of tokenized documents
  message("Segmenting texts...")
  texts.seg <- lapply(corpus$documents$texts,
                         FUN = jiebaR::segment, 
                         jiebar = worker.def)
  
  # paste results
  message("Pasting segmented results...")
  pastedsegresults <- lapply(texts.seg, paste,
                        sep = "",collapse = " ")
  
  # tokenize on whitespace
  message("Tokenizing texts...")
  seg.tokens <- tokens(unlist(pastedsegresults),what = "fastestword")
  
  # create dfm from tokens object
  message("Creating dfm...")
  seg.dfm <- dfm(seg.tokens)
}
