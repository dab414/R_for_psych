## faceting with three factors
library(data.table)
df <- fread('http://www.lehigh.edu/~dab414/data/research_data/old/special_issue/easy_clean.csv')

df %>% 
  mutate(current = as.factor(current),
         other = as.factor(other),
         rsi = as.factor(rsi)) %>% 
  group_by(subject, current, other, rsi) %>% 
  summarize(transcode = mean(transcode)) %>% 
  group_by(current, other, rsi) %>% 
  summarize(switch = mean(transcode), se = sd(transcode) / sqrt(n())) %>% 
  ggplot(aes(x = current, y = switch, group = other)) + 
  geom_bar(stat = 'identity', aes(fill = other), position = 'dodge') +
  geom_errorbar(stat = 'identity', aes(ymin = switch - se, ymax = switch + se),
                position = position_dodge(width = .9), width = .5) + 
  facet_wrap(~rsi) + ylim(0, 1) + labs(title = 'Lots of confusing stuff', 
                                       subtitle = 'Really, it is confusing',
                                       x = 'Current',
                                       y = 'Switching')








