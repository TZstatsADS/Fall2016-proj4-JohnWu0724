library(arules)
library(arulesViz)




load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/sound_bars.RData")
load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/sound_beats.RData")
load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/sound_sections.RData")
load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/sound_segments.RData")
load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/sound_tatums.RData")


### Clustering five big features

d.bars <- dist(sound.bars.n,method = "euclidean")
d.beats <- dist(sound.beats.n,method = "euclidean")
d.sections <- dist(sound.sections.n,method = "euclidean")
d.segments <- dist(sound.segments.n,method = "euclidean")
d.tatums <- dist(sound.tatums.n,method = "euclidean")

fit.bars <- cutree(hclust(d.bars, method = "ward.D"), k = 3)
fit.beats <- cutree(hclust(d.beats, method = "ward.D"), k = 3)
fit.sections <- cutree(hclust(d.sections, method = "ward.D"), k = 3)
fit.segments <- cutree(hclust(d.segments, method = "ward.D"), k = 3)
fit.tatums <- cutree(hclust(d.tatums, method = "ward.D"), k = 3)

clus.all <- t(rbind(fit.bars,fit.beats,fit.sections,fit.segments,fit.tatums))
clus.s <- matrix(rep(0,15*length(sound)),length(sound),15)

### get total 3^5 = 243 groups

count = 0
combination <- matrix(rep(0,243*5),243,5)
for (i in 1:3) {
  for (j in 1:3) {
    for (k in 1:3) {
      for (m in 1:3) {
        for (n in 1:3) {
          count = count + 1
          combination[count,] = c(i,j,k,m,n)
        }
      }
    }
  }
}

count_combination <- matrix(rep(0,nrow(clus.all)*243),nrow(clus.all),243)

for (i in 1:nrow(clus.all)) {
  for (j in 1:nrow(combination)) {
    if (sum(clus.all[i,] == combination[j,]) == 5) {
      count_combination[i,j] = 1
    } else {
      count_combination[i,j] = 0
    }
  }
}

### get word frequency in each group

word_frequency <- matrix(rep(0,nrow(lyr)*ncol(lyr)),nrow(lyr),ncol(lyr))


for (i in 1:nrow(combination)) {
  index = which(count_combination[,i] == 1)
  lyr_select = rbind(lyr[index,])
  word_frequency[i,] = apply(lyr_select,2,sum)
}

### Combine all features together and just clustering once

features.all <- cbind(sound.bars.n,sound.beats.n,sound.sections.n,sound.segments.n,sound.tatums.n)
features.dist <- dist(features.all,method = "euclidean")
feature.fit <- cutree(hclust(features.dist,method = "ward.D"),k = 24)



words_frequency <- matrix(rep(0,24*ncol(lyr)),24,ncol(lyr))
words_sequence <- matrix(rep(0,24*ncol(lyr)),24,ncol(lyr))
words_rank <- matrix(rep(0,24*ncol(lyr)),24,ncol(lyr))
words_average <- matrix(rep(0,24*ncol(features.all)),24,ncol(features.all))

for (i in 1:24) {
  index = which(feature.fit == i)
  lyr_select = rbind(lyr[index,])
  features_select = rbind(features.all[index,])
  words_frequency[i,] = apply(lyr_select, 2, sum)
  words_sequence[i,] = word[order(words_frequency[i,],decreasing = T)]
  words_average[i,] = apply(features_select,2, mean)
}

for (i in 1:24) {
  words_rank[i,] = order(words_frequency[i,],decreasing = T)
}

classify <- function(input) {
  dist_test = matrix(rep(0,nrow(input)*24),nrow(input),24)
  for (i in 1:nrow(input)) {
    for (j in 1:24) {
      dist_test[i,j] = dist(rbind(words_average[j,],input[i,]), method = "euclidean")
    }
  }
  dist_min = apply(dist_test, 1, which.min)
  return(dist_min)
}



### Association Rules

l1 <- as.matrix(lyr)

for (i in 1:nrow(l1)) {
  for (j in 1:ncol(l1)) {
    if (l1[[i,j]] != 0) {
      l1[[i,j]] = 1
    } 
  }
}

r1 = apriori(l1)

inspect(head(r1))




