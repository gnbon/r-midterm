library(dplyr)
library(ggplot2)

midwest1 = midwest %>%
  select(county, state, poptotal, popasian)
midwest1 = midwest1 %>% rename(total=poptotal, asian=popasian)
midwest1 = midwest1 %>% mutate(pct_asian = asian / total * 100)
hist(midwest1$pct_asian)

midwest1 = midwest1 %>% mutate(degree=ifelse(pct_asian>mean(pct_asian), "large", "small"))
barplot(table(midwest1$degree))

arrange(midwest1, pct_asian)
arrange(midwest1, desc(pct_asian))

table(mpg$class)
mpg %>%
  group_by(manufacturer) %>%
  filter(class=='suv') %>%
  mutate(total=(hwy+cty)/2) %>%
  summarise(mean_tot=mean(total)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

mpg %>%
  filter(manufacturer=='audi'|manufacturer=='toyota') %>% 
  group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty))

mpg %>%
  filter(class=='compact') %>%
  group_by(manufacturer) %>%
  summarise(n=n()) %>%
  arrange(desc(n))

avocado = read.csv('avocado.csv')

(x_avg = avocado %>%
    group_by(region, year, type) %>%
    summarise(V_avg=mean(Total.Volume), P_avg=mean(AveragePrice)))

x_avg %>%
  filter(region != "TotalUS") %>%
  ggplot(aes(year, V_avg, col=type)) + geom_line() + facet_wrap(~region)

x_avg %>%
  filter(region != "TotalUS") %>%
  ggplot(aes(year, P_avg, col=type)) + geom_line() + facet_wrap(~region)

arrange(x_avg, desc(V_avg))

x_avg1 = x_avg %>% filter(region != 'TotalUs')
x_avg1[x_avg1$V_avg==max(x_avg1$V_avg),]
arrange(x_avg1, desc(V_avg))
