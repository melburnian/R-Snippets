# Read the file into R
file_data <- read_excel("b2.xlsx")


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
while (i <= length(file_data)) {
  line <- file_data[i]
  if (grepl(":", line)) {
    label <- sub(":.*", "", line)
    value <- sub(".*:", "", line)
    
    if (label == "Userid") user_id <- c(user_id, value)
    if (label == "Fullname") full_name <- c(full_name, value)
    if (label == "Email") email <- c(email, value)
  } else if (line == "Group") {
    group <- character()
    i <- i + 1
    while (i <= length(file_data) && file_data[i] != "") {
      label <- sub(":.*", "", file_data[i])
      value <- sub(".*:", "", file_data[i])
      if (label == "Name") {
        group <- c(group, value)
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
for (i in 1:length(groups)) {
  for (j in 1:length(groups[[i]])) {
    group_name <- groups[[i]][j]
    
    if (!(group_name %in% colnames(df))) {
      df[[group_name]] <- FALSE
    }
    
    df[i, group_name] <- TRUE
  }
}

