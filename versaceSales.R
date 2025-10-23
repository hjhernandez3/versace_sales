library(readxl)
library(dplyr)
library(lubridate)
library(ggplot2)
library(broom)

sales <- read_excel("data/versaceSales.xlsx", sheet = "QUARTERLY")       
ambassadors <- read_excel("data/versaceSales.xlsx", sheet = "AMBASSADORS")

# Ensuring the dates are date format
sales <- sales %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%y"))

ambassadors <- ambassadors %>%
  mutate(
    Date = as.Date(Date, format = "%m/%d/%y"),
    endDate = as.Date(`End Date`, format = "%m/%d/%y"))

total_sales <- sales_with_amb %>%
  group_by(Date) %>%
  summarise(total_sales = sum(`Sales (Millions)`))
# For each region-quarter, count the ambassadors since appointment to termination--yang mi is the only one that is noted to have ended
sales_with_amb <- sales %>%
  rowwise() %>%
  mutate(
    ambassador_count = sum(
      ambassadors$Region == Region &
        ambassadors$Date <= Date &
        (is.na(ambassadors$endDate) | ambassadors$endDate >= Date)
    )
  ) %>%
  ungroup()

#graph including each region compared to the total
ggplot() +
  geom_line(data = sales_with_amb, 
            aes(x = Date, y = `Sales (Millions)`, color = Region), size = 1) +
  geom_point(data = sales_with_amb, 
             aes(x = Date, y = `Sales (Millions)`, size = ambassador_count)) +  
  geom_line(data = total_sales, 
            aes(x = Date, y = total_sales), 
            color = "black", alpha = 0.3, size = 1.2, linetype = "dashed") +
  scale_size_continuous(range = c(2, 6)) +
  labs(title = "Sales Over Time by Region with Total Sales",
       x = "Date",
       y = "Sales (Millions)",
       color = "Region",
       size = "Ambassadors") +
  theme_minimal()

# Simple regression model
model <- lm(`Sales (Millions)` ~ ambassador_count + Region, data = sales_with_amb)
summary(model)



sales_with_amb <- sales_with_amb %>%
  group_by(Region) %>%
  arrange(Date) %>%
  mutate(cum_ambassadors = cumsum(ambassador_count)) %>%
  ungroup()

model_total <- lm(`Sales (Millions)`  ~ cum_ambassadors + factor(Quarter) + Region, data = sales_with_amb)
summary(model_total)


# Seeing if there is a significance compared to the quarters after ambassador was appointed
sales_with_lags <- sales_with_amb %>%
  arrange(Region, Date) %>%
  group_by(Region) %>%
  mutate(
    cum_amb_1lag = lag(cum_ambassadors, n = 1, default = 0),
    cum_amb_2lag = lag(cum_ambassadors, n = 2, default = 0)
  ) %>%
  ungroup()

model_lagged <- lm(`Sales (Millions)` ~ cum_amb_1lag + cum_amb_2lag + factor(Quarter) + Region, 
                   data = sales_with_lags)

summary(model_lagged)
