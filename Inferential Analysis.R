install.packages("ggpubr")
install.packages("qqplotr")
install.packages("rstatix")
install.packages("ggplot2")
library(ggpubr)
library(qqplotr)
library(rstatix)
library(ggplot2)

#hypothesis
#We hypothesize that tvl is associated with the use case (category) of the protocol, especially for the top 5 use cases (Dexes, Yield, Lending, Reserve Currency, Algo-stables)





#make boxplot
ggboxplot(ProtocolTVL, x = "category", y = "tvl",
          ylab = "Weight", xlab = "Treatment")

#check that data is normally distributed. Output shows that data is not normally distributed.
ggplot(data = ProtocolTVL, mapping = aes(sample = tvl, fill = category))+
  stat_qq_band(alpha=0.15) +stat_qq_line(alpha=0.15) +stat_qq_point(size=0.5) + 
  facet_wrap(~ category) +labs(title = "Normal Q-Q plot", x = "Theoretical Quantiles", y = "Sample Quantiles")+
  theme_polsara()


#check for equal variance. Equal variance is checked with Fligner-Killeen test
#since data is not normally distributed. Output shows that the p-value is statistically significant.
#This means that significant difference was observed between the tested sample variances.
fligner.test(tvl ~ category, data = ProtocolTVL)



# The non parametric Kruskal-Wallis test is used to test difference in averages between groups.
#This is used because the data is not balanced and variances are unequal. So we cannot use a one way ANOVA
#
#https://www.statology.org/kruskal-wallis-test/

kruskal.test(tvl ~ category, data = ProtocolTVL)


#shows which variables have a statistically significant difference
pairwise.wilcox.test(ProtocolTVL$tvl, ProtocolTVL$category,
                     p.adjust.method = "BH")


