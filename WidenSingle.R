# Load necessary package
library(readxl)

# Read the file into R
file_data <- read_excel("b2.xlsx", col_names = FALSE)

# Initialize empty variables to store the data
user_id <- character()
full_name <- character()
email <- character()
time_zone <- character()
avatar_url <- character()
active <- character()
groups <- list()

# Loop over the data and parse the fields
i <- 1
while (i <= nrow(file_data)) {  # Use nrow instead of length for data frame
  line <- as.character(file_data[i, 1])  # Assuming data is in the first column
  if (grepl(":", line)) {
    label <- sub(":.*", "", line)
    value <- sub(".*:", "", line)
    
    if (label == "Userid") user_id <- c(user_id, trimws(value))
    if (label == "Fullname") full_name <- c(full_name, trimws(value))
    if (label == "Email") email <- c(email, trimws(value))
  } else if (line == "Group") {
    group <- character()
    i <- i + 1
    while (i <= nrow(file_data) && trimws(as.character(file_data[i, 1])) != "") {  # Check for empty lines properly
      label <- sub(":.*", "", file_data[i, 1])
      value <- sub(".*:", "", file_data[i, 1])
      if (label == "Name") {
        group <- c(group, trimws(value))
      }
      i <- i + 1
    }
    groups[[length(user_id)]] <- group
  }
  
  i <- i + 1
}

# Combine the vectors into a data frame
df <- data.frame(
  user_id = user_id,
  full_name = full_name,
  email = email,
  stringsAsFactors = FALSE
)

# Add the groups to the data frame as separate columns
for (i in seq_along(groups)) {  # seq_along is better for indexing lists
  for (j in seq_along(groups[[i]])) {
    group_name <- groups[[i]][j]
    
    if (!(group_name %in% colnames(df))) {
      df[[group_name]] <- FALSE
    }
    
    df[i, group_name] <- TRUE
  }
}

# Display the final data frame
df
