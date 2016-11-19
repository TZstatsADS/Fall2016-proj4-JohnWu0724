# Project: Words 4 Music

### [Project Description](doc/Project4_desc.md)

![image](http://cdn.newsapi.com.au/image/v1/f7131c018870330120dbe4b73bb7695c?width=650)

Term: Fall 2016

+ [Data link](https://courseworks2.columbia.edu/courses/11849/files/folder/Project_Files?preview=763391)-(**courseworks login required**)
+ [Data description](doc/readme.html)
+ Contributor's name: Zichen Wu
+ Projec title: Thousands Songs
+ Project summary: This project aims to construct a recommendation system on lyrics based on sound features in music. My baseline model use clustering method(ward.D) to classify training music to 24 groups first based on sound features(beats confidence, bars confidence...) and rank the lyric frequency in each group. For testing music, I need to put them in the suitable groups based on the minimum euclidean distance between testing sound and groups, and then use group word frequency to predict songs frequency. 

How to choose the number of groups? I choose suitable number of groups based on recurrence rate and occupation ratio. I found there is so many punctuations and stop words(such as I,the, to...)get the highest rank in each group, so when I calculate recurrence rate, I used 50:100 highest rank words in my calculation. Groups should not have too many similar words with each other. Also, I could not make number of songs in each group too small which is not representative and will cause overfitting. So I set minimum number of songs in each group to be 50. Based on these to constrains, 24 is the most suitable number of groups.

+ For the advanced model, I need to improve my algorithms on following two parts:
	1. Further clean the data set to get better features
       	My baseline model simply extracted raw data as features. I could calculate time intervals between each start 		time and the mean and variance of loudness to get better features. Also, I need to clean punctuation words, stop words	      and other common used words when I classfiy lyrics.
	2. Better prediction models
	Rather than just classify musics, I should classify lyrics as well based on topic modeling. And than I should try	 logistic regression/random forest/Adaboost/SVM methods to improve my prediction
	
	
+ What I did on advanced models right now:
 	1. I have tried association rules on classification, but does not work well. I got 7977675 rules with minimum 0.8 	  confidence, but there are many similar rules with very high confidence and similar support. Such as {you, I, the} => 		{we}, I also had {you, I, the, to} => {we} with nearly 0.9 confince. My idea is choose rules with highest number of    		items among similar rules, but not down yet.
 	2. Futher thought on association rules: I tried to use association rules to predict rather than just classify. So for 	      music features, rather than combine all features in one matrix, I will use five kinds of features with different		levels. For example, I have bars, beats, sections, segments and tatums as my features, and for each feature, such as 	     bars, I will further classify it to 3 levels(bar1,bar2,bar3) based on clustering method. And then I will apply 	      	      association rules on music features and lyrics. The rules will look like this: {bars1,beats2,segments3} => {war},    	   {beats2, segments3, section 1} => {war}. The diffcult here is to find a suitbale way to combine music feature matrix   	  and lyrics transaction matrix, I'm still working on it.
 	3. I used tm_map function(removePunctution, removeWords, stopwords('English')...) in 'tm' package to romove high 	 frequency words. And coverted lyrics to Corpus and then dtm form. But I always get error when I use 
	'lda.collapsed.gibbs.sampler' function, I don't know what's wrong here and keep debugging.
	
+ Necessary libraries/packages:

	1. Extractinng features: (rhdf5)
	2. Association rules: (arules, arulesViz)
	3. Topic Modeling: (tm,lda,NLP)
	4. Predictive Models: (randomForest,xgboost,e1071)

	
Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
