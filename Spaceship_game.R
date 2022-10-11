setwd("~/Personal/BSB/Coding training/R/Introduction_2022_2023")

choice = ""
df_player = data.frame(Name = character(), Guesses = numeric())

while(choice != "q") {
  choice = readline(cat("1 - Play\n2 - High Scores\nq - quit\n\n"))
  
  if(choice == 1) {
    cat("Let's play!\n\nYour spaceship needs to land!\n\nTry to guess where the landing spot is, and I'll do my best to guide you.\n\nType 'q' at any time to exit.\n\n")

    player_name = readline("What's your name, Captain? ")
    if(player_name == 'q') {
      choice = 'q'
      break
    }
    cat("\n")
    
    # choose random integers for latitude and longitude
    lat = sample.int(100, 1)
    lon = sample.int(100, 1)
    
    lat_error = 1
    lon_error = 1
    
    num_guesses = 0
    
    lat_guess = 0
    lon_guess = 0
    
    while(lat_error != 0 | lon_error !=0) {
      if(lat_error != 0) {
        lat_guess = readline("What do you think the latitude is? Guess an integer between 1 and 100: ")
        # exit if user types 'q'
        if(lat_guess == 'q') {
          choice = 'q'
          cat("\nBye!\n")
          break
        }
        # exit with no warnings if user types non-numeric value
        options(warn = -1)
        if(is.na(as.integer(lat_guess))) {
          choice = 'q'
          cat("\nThat's not a number. You broke the game!\n")
          options(warn = 0)
          break
        }
                
        lat_guess = as.integer(lat_guess)

        # apply floor of 1 and ceiling of 100
        if(lat_guess < 1) {
          lat_guess = 1
          cat("\nToo low - setting latitude to 1.\n\n")
        }
        else if(lat_guess > 100) {
          lat_guess = 100
          cat("\nToo high - setting latitude to 100.\n\n")
        }
      }
      if(choice == 'q') {
        break
      }
      
      if(lon_error != 0) {
        lon_guess = readline("What do you think the longitude is? Guess an integer between 1 and 100: ")
        # exit if user types 'q'
        if(lon_guess == 'q') {
          choice = 'q'
          cat("\nBye!\n")
          break
        }
        
        # exit with no warnings if user types non-numeric value
        options(warn = -1)
        if(is.na(as.integer(lon_guess))) {
          choice = 'q'
          cat("\nThat's not a number. You broke the game!\n")
          options(warn = 0)
          break
        }
        lon_guess = as.integer(lon_guess)
        
        # apply floor of 1 and ceiling of 100
        if(lon_guess < 1) {
          lon_guess = 1
          cat("\nToo low - setting longitude to 1.\n")
        }
        else if(lon_guess > 100) {
          lon_guess = 100
          cat("\nToo high - setting longitude to 100.\n")
        }
      }
      if(choice == 'q') {
        break
      }
      
      num_guesses = num_guesses + 1
      
      lat_error = lat_guess - lat
      lon_error = lon_guess - lon

      cat("\n")      
      if (lat_error == 0) {
        print("The latitude is correct! Well done!")
      } else if (lat_error > 0) {
        print(paste0("The latitude is too high -- guess a number lower than ", lat_guess, "."))
      } else {
        print(paste0("The latitude is too low -- guess a number higher than ", lat_guess, "."))
      }
      
      if (lon_error == 0) {
        print("The longitude is correct! Well done!")
      } else if (lon_error > 0) {
        print(paste0("The longitude is too high -- guess a number lower than ", lon_guess, "."))
      } else {
        print(paste0("The longitude is too low -- guess a number higher than ", lon_guess, "."))
      }
      
      cat("\n")
    }
    if (lat_error == 0 & lon_error == 0) {
      print(paste0("You guessed the answer in ", num_guesses, " turns. Congratulations, Captain ", player_name, "!"))
    }
    cat("\n")
    
    # add game result to high score table
    df_player[nrow(df_player) + 1,] = data.frame(player_name, num_guesses)
  } 
  else if(choice == 2) {
    if(nrow(df_player) == 0) {
        print("No scores yet! Want to play?")
    } else {
      cat("\n")
      # print high score table sorted in ascending order by # of guesses then player name
      print(df_player[order(df_player$Guesses, df_player$Name),], row.names=FALSE) 
      cat("\n")
    }
  }
}

