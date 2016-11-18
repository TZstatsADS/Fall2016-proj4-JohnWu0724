library(rhdf5)


load("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/Project4_data/lyr.RData")
lyr <- lyr[,c(-(1:3),-(6:30))]
word <- names(lyr)

p1 <- "~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/TestSongFile100"
p2 <- dir(p1,recursive = TRUE)

sound <- list()
for (i in 1:length(p2)) {
  sound[[i]] <- h5read(paste0(p1,'/',p2[i]),"/analysis")
}


sound.bars <- vector()
sound.beats <- vector()
sound.sections <- vector()
sound.segments <- vector()
sound.tatums <- vector()

for (i in 1:length(sound)) {
  sound.bars[i] <- length(sound[[i]]$bars_confidence)
  sound.beats[i] <- length(sound[[i]]$beats_confidence)
  sound.sections[i] <- length(sound[[i]]$sections_confidence)
  sound.segments[i] <- length(sound[[i]]$segments_confidence)
  sound.tatums[i] <- length(sound[[i]]$tatums_confidence)
}


sound.bars.n <- matrix(rep(0,length(sound)*max(sound.bars)),length(sound),max(sound.bars))

for (i in 1:length(sound)) {
  if (sound.bars[i] != 0) {
    if (max(sound.bars)/sound.bars[i] < 1) {
      sound.bars.n[i,] = c(sound[[i]]$bars_confidence,sound[[i]]$bars_confidence[1:(max(sound.bars)-sound.bars[i])])
    } else if (max(sound.bars)/sound.bars[i] == 1) {
      sound.bars.n[i,] = sound[[i]]$bars_confidence
    } else if(max(sound.bars)/sound.bars[i] > 1) {
      rp = as.integer(max(sound.bars)/sound.bars[i])
      if (max(sound.bars)%%sound.bars[i] > 0) {
        sound.bars.n[i,] = c(rep(sound[[i]]$bars_confidence,rp),
                             sound[[i]]$bars_confidence[1:(max(sound.bars)-sound.bars[i]*rp)])
      } else if (max(sound.bars)%%sound.bars[i] == 0) {
        sound.bars.n[i,] = rep(sound[[i]]$bars_confidence,rp)
      }
    }
  } else if (sound.bars[i] == 0) {
    sound.bars.n[i,] = rep(0,max(sound.bars))
  }
}

sound.beats.n <- matrix(rep(0,length(sound)*max(sound.beats)),length(sound),max(sound.beats))

for (i in 1:length(sound)) {
  if (sound.beats[i] != 0) {
    if (max(sound.beats)/sound.beats[i] < 1) {
      sound.sections.n[i,] = c(sound[[i]]$beats_confidence,sound[[i]]$beats_confidence[1:(max(sound.beats)-sound.beats[i])])
    } else if (max(sound.beats)/sound.beats[i] == 1) {
      sound.beats.n[i,] = sound[[i]]$beats_confidence
    } else if(max(sound.beats)/sound.beats[i] > 1) {
      rp = as.integer(max(sound.beats)/sound.beats[i])
      if (max(sound.beats)%%sound.beats[i] > 0) {
        sound.beats.n[i,] = c(rep(sound[[i]]$beats_confidence,rp),
                              sound[[i]]$beats_confidence[1:(max(sound.beats)-sound.beats[i]*rp)])
      } else if (max(sound.beats)%%sound.beats[i] == 0) {
        sound.beats.n[i,] = rep(sound[[i]]$beats_confidence,rp)
      }
    }
  } else if (sound.beats[i] == 0) {
    sound.beats.n[i,] = rep(0,max(sound.beats))
  }
}

sound.sections.n <- matrix(rep(0,length(sound)*max(sound.sections)),length(sound),max(sound.sections))

for (i in 1:length(sound)) {
  if (sound.sections[i] != 0) {
    if (max(sound.sections)/sound.sections[i] < 1) {
      sound.sections.n[i,] = c(sound[[i]]$sections_confidence,sound[[i]]$sections_confidence[1:(max(sound.sections)-sound.sections[i])])
    } else if (max(sound.sections)/sound.sections[i] == 1) {
      sound.sections.n[i,] = sound[[i]]$sections_confidence
    } else if(max(sound.sections)/sound.sections[i] > 1) {
      rp = as.integer(max(sound.sections)/sound.sections[i])
      if (max(sound.sections)%%sound.sections[i] > 0) {
        sound.sections.n[i,] = c(rep(sound[[i]]$sections_confidence,rp),
                                 sound[[i]]$sections_confidence[1:(max(sound.sections)-sound.sections[i]*rp)])
      } else if (max(sound.sections)%%sound.sections[i] == 0) {
        sound.sections.n[i,] = rep(sound[[i]]$sections_confidence,rp)
      }
    }
  } else if (sound.sections[i] == 0) {
    sound.sections.n[i,] = rep(0,max(sound.sections))
  }
}



sound.segments.n <- matrix(rep(0,length(sound)*max(sound.segments)),length(sound),max(sound.segments))

for (i in 1:length(sound)) {
  if (sound.segments[i] != 0) {
    if (max(sound.segments)/sound.segments[i] < 1) {
      sound.segments.n[i,] = c(sound[[i]]$segments_confidence,sound[[i]]$segments_confidence[1:(max(sound.segments)-sound.segments[i])])
    } else if (max(sound.segments)/sound.segments[i] == 1) {
      sound.segments.n[i,] = sound[[i]]$segments_confidence
    } else if(max(sound.segments)/sound.segments[i] > 1) {
      rp = as.integer(max(sound.segments)/sound.segments[i])
      if (max(sound.segments)%%sound.segments[i] > 0) {
        sound.segments.n[i,] = c(rep(sound[[i]]$segments_confidence,rp),
                                 sound[[i]]$segments_confidence[1:(max(sound.segments)-sound.segments[i]*rp)])
      } else if (max(sound.segments)%%sound.segments[i] == 0) {
        sound.segments.n[i,] = rep(sound[[i]]$segments_confidence,rp)
      }
    }
  } else if (sound.segments[i] == 0) {
    sound.segments.n[i,] = rep(0,max(sound.segments))
  }
}

sound.tatums.n <- matrix(rep(0,length(sound)*max(sound.tatums)),length(sound),max(sound.tatums))

for (i in 1:length(sound)) {
  if (sound.tatums[i] != 0) {
    if (max(sound.tatums)/sound.tatums[i] < 1) {
      sound.tatums.n[i,] = c(sound[[i]]$tatums_confidence,sound[[i]]$tatums_confidence[1:(max(sound.tatums)-sound.tatums[i])])
    } else if (max(sound.tatums)/sound.tatums[i] == 1) {
      sound.tatums.n[i,] = sound[[i]]$tatums_confidence
    } else if(max(sound.tatums)/sound.tatums[i] > 1) {
      rp = as.integer(max(sound.tatums)/sound.tatums[i])
      if (max(sound.tatums)%%sound.tatums[i] > 0) {
        sound.tatums.n[i,] = c(rep(sound[[i]]$tatums_confidence,rp),
                               sound[[i]]$tatums_confidence[1:(max(sound.tatums)-sound.tatums[i]*rp)])
      } else if (max(sound.tatums)%%sound.tatums[i] == 0) {
        sound.tatums.n[i,] = rep(sound[[i]]$tatums_confidence,rp)
      }
    }
  } else if (sound.tatums[i] == 0) {
    sound.tatums.n[i,] = rep(0,max(sound.tatums))
  }
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

new_feature <- cbind(sound.bars.n,sound.beats.n,sound.sections.n,sound.segments.n,sound.tatums.n)
classfication <- classify(new_feature)
top100 <- words_frequency[classfication,]

test.file <- read.csv("~/Documents/Columbia/Fall 2016/Applied Data Anaylsis/Project4/sample_submission.csv",check.names = FALSE)
test.file[1:100,5:6] = top100[,1:2]
test.file[1:100,32:5002] = top100[1,-(1:2)]


