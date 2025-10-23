# Students performance analysis in R

#load libraries
library(DBI)
library(RMySQL)
library(dplyr)
library(ggplot2)

#connecting to SQL Database 
con <- dbConnect(
  MySQL(),
  user = "root",
  password = "Shivani@3099",      
  dbname = "student_performance",
  host = "localhost"
)
# Fetch data from SQL

data <- dbGetQuery(con, "SELECT * FROM students;")

# Preview data

head(data)

# Create Average Score Column

data <- data %>%
  mutate(avg_score = (math_score + science_score + english_score)/3)

# ---- Summary Statistics ----

summary_stats <- data %>%
  summarise(
    avg_math = mean(math_score),
    avg_science = mean(science_score),
    avg_english = mean(english_score),
    avg_attendance = mean(attendance),
    avg_study_hours = mean(study_hours)
  )

print(summary_stats)
# ---- Regression Analysis ----

model <- lm(avg_score ~ attendance + study_hours, data = data)
summary(model)

# ---- Visualization 1: Attendance vs Average Score ----

ggplot(data, aes(x = attendance, y = avg_score)) +
  geom_point(color = "blue", size = 3) +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  ggtitle("Attendance vs Average Score") +
  xlab("Attendance (%)") +
  ylab("Average Score")

#---- Visualization 2: Gender vs Average Score ----

ggplot(data, aes(x = gender, y = avg_score, fill = gender)) +
  geom_boxplot() +
  ggtitle("Gender-wise Performance Comparison") +
  ylab("Average Score")

#EXPORT to CSV to excel
write.csv(data, "student_performance_output.csv", row.names = FALSE)

#Disconnet
dbDisconnect(con)



















