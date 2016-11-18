library(tm)
library(topicmodels)
library(lda)
library(LDAvis)
library(NLP)




preprocess.directory = function(dirname){
  ds = DirSource(dirname)
  fp = Corpus( ds )
  fp = tm_map( fp , content_transformer(tolower))
  fp = tm_map( fp , removePunctuation);
  fp = tm_map( fp, removeWords, stopwords("english"));
  fp = tm_map( fp, stemDocument)
  fp = tm_map( fp, stripWhitespace)
  writeCorpus( fp , sprintf('%s_clean',dirname) )
}

doc <- preprocess.directory("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis
/Project4/Project4_data/mxm_dataset_train.txt")


a1 = 20
a2 = 5000
a3 = 0.02
a4 = 0.02
a5 = apply(doc, 2, sum)

fit <- lda.collapsed.gibbs.sampler(documents = a5, K = a1, vocab = word, 
                                   num.iterations = a2, alpha = a3, 
                                   eta = a4, initial = NULL, burnin = 0,
                                   compute.log.likelihood = TRUE)











