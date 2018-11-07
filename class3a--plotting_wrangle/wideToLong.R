df <- read.csv('https://davebraun.org/quant/edsi_talent_survey_raw_data.csv')

newDf <- df %>% 
  select(-contains('AVE'), -contains('AVG'),
         -MS.E, -NPS.E,
         -MS.L, -NPS.L) %>% 
  gather(var, value, ST1.L:SN6.E) %>% 
  separate(var, into = c('item', 'item_number', 'position'), sep = c(2,4)) %>% 
  mutate(item_number = as.numeric(item_number),
         item = as.factor(item),
         position = as.factor(position))  

  