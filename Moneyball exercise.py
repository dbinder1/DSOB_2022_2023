# def name(x) then indent and write the code

# 1. median, avg, standard deviation of the runs scored by each team

import os
import numpy as np
os.getcwd()
os.chdir("C:\\Users\\DavidBinder\\Documents\\Personal\\BSB\\Coding training\\Python")
data = np.genfromtxt(fname="Moneyball data.csv",delimiter=";", skip_header = 1)

data.shape

# Hints before you go:
# save columns that you need to use (numpy has no idea of what a dataframe is)
NY = data[:,1]
BO = data[:,2]
CS = data[:,3]
YR = data[:,0]

## Goals:

# 1 create a function that prints summary statistics (median, average and SD) of Runs scored of all teams 
def team_stats(team_data):
  print("Median is", round(np.nanmedian(team_data), 1))
  print("Mean is", round(np.nanmean(team_data), 1))
  print("Standard deviation is", round(np.nanstd(team_data), 1))
  pass

team_stats(NY)
team_stats(BO)
team_stats(CS)

# 2 now include in the function the possibility to select a range of years and provide same statistics
def team_stats_range(team_data, year_list, start_year, end_year):
  YR_range_array = np.logical_and(year_list >= start_year, year_list <= end_year) 
  team_stats(team_data[YR_range_array])

team_stats_range(NY, YR, 1950, 1975)
team_stats_range(NY, YR, 1908, 1975) # to test handling of nan
team_stats_range(BO, YR, 1950, 1975)
team_stats_range(CS, YR, 1950, 1975)

import numpy as np

# 3 create a function to define who did more [runs between two given teams
def more_runs(team_info_array):
  team1_sum = np.nansum(team_info_array[0][0])
  team1_name = team_info_array[0][1]
  team2_sum = np.nansum(team_info_array[1][0])
  team2_name = team_info_array[1][1]
  if team1_sum > team2_sum:
    print("The", team1_name, "outscored the", team2_name, team1_sum, "to", team2_sum)
  elif team1_sum == team2_sum:
    print("The", team1_name, "and the", team2_name, "scored the same number of runs:", team1_sum)
  else:
    print("The", team2_name, "outscored the", team1_name, team2_sum, "to", team1_sum)
  pass

more_runs([[NY, "New York Yankees"], [BO, "Boston Red Sox"]])
more_runs([[NY, "New York Yankees"], [CS, "Chicago White Sox"]])
more_runs([[NY, "New York Yankees"], [NY, "Yankee Clones"]])
more_runs([[BO, "Boston Red Sox"], [CS, "Chicago White Sox"]])

def more_max_runs(team_info_array):
  team1_max = np.nanmax(team_info_array[0])
  team1_name = team_info_array[1]
  team2_max = np.nanmax(team_info_array[2])
  team2_name = team_info_array[3]
  if team1_max > team2_max:
    print("The", team1_name, "had a higher max score than the", team2_name, team1_max, "to", team2_max)
  elif team1_max == team2_max:
    print("The", team1_name, "and the", team2_name, "had the same max number of runs:", team1_max)
  else:
    print("The", team2_name, "had a higher max score than the", team1_name, team2_max, "to", team1_max)
  pass

more_max_runs([NY, "New York Yankees", BO, "Boston Red Sox"])
more_max_runs([NY, "New York Yankees", CS, "Chicago White Sox"])
more_max_runs([NY, "New York Yankees", NY, "Yankee Clones"])
more_max_runs([BO, "Boston Red Sox", CS, "Chicago White Sox"])

# 4 create a function to compute moving averages over the time series

# first, create a function to compute the average over a specified range, returning nan if any value in the range is nan
def team_average_range(team_data, year_list, start_year, end_year):
  YR_range_array = np.logical_and(year_list >= start_year, year_list <= end_year) 
  # print(YR_range_array)
  # num_nans = np.nansum(np.isnan(team_data[YR_range_array]))
  # if num_nans > 0:
  #    return(float("nan"))
  # else:
  #   return(np.nanmean(team_data[YR_range_array]))
  return(np.mean(team_data[YR_range_array]))
  pass

team_average_range(NY, YR, 2000, 2010)
team_average_range(NY, YR, 1908, 1920)

# Example of moving average: if years_in_avg = 2 then take average of 5 years (current year, 
# 2 years before current year, and 2 years after current year)
def team_moving_average(team_data, year_list, years_in_avg):
  x = []
  min_year = year_list[0]
  max_year = year_list[-1]
  num_rows = len(team_data)
  for d in range(num_rows):
    if d < years_in_avg or d >= num_rows - years_in_avg:
      x.append(float("nan"))
    else:
      range_start_year = year_list[d] - years_in_avg
      range_end_year = year_list[d] + years_in_avg
      x.append(round(team_average_range(team_data, year_list, range_start_year, range_end_year), 1))
  return(x)
  pass

# Example of moving average: if years_in_avg = 2 then take average of 5 years (current year, 
# 2 years before current year, and 2 years after current year)
def team_moving_average(team_data, year_list, years_in_avg):
  x = []
  min_year = year_list[0]
  max_year = year_list[-1]
  num_rows = len(team_data)
  for d in range(num_rows):
    if d < years_in_avg or d >= num_rows - years_in_avg:
      x.append(float("nan"))
    else:
      range_start_year = year_list[d] - years_in_avg
      range_end_year = year_list[d] + years_in_avg
      YR_range_array = np.logical_and(year_list >= range_start_year, year_list <= range_end_year) 
      x.append(round(np.mean(team_data[YR_range_array]), 1))
  return(x)
  pass

moving_average_array = team_moving_average(team_data = NY, year_list = YR, years_in_avg = 3)
moving_average_array
moving_average_array = team_moving_average(team_data = BO, year_list = YR, years_in_avg = 4)
moving_average_array

# def moving_average_test(a, n):
#   ret = np.cumsum(a, dtype = float)
#   print(ret)
#   ret[n:] = ret[n:] - ret[:-n]
#   print(ret[n:])
#   return ret[n - 1:] / n
# 
# moving_average_test(BO, 4)

# 5 t-test between two teams run scores

def t_test(x1, x2):
  # Calculate the mean of each input array
  x1_avg = np.nanmean(x1)
  x2_avg = np.nanmean(x2)
  # Calculate the length of each input array excluding nan values
  n1 = sum(np.logical_not(np.isnan(x1)))
  n2 = sum(np.logical_not(np.isnan(x2)))
  # Calculate the variance of each input array excluding nan values
  var_x1 = np.nanvar(x1, ddof = 1)
  var_x2 = np.nanvar(x2, ddof = 1)
  # calculate the pooled sample variance
  pool_var = (((n1 - 1) * var_x1) + ((n2 - 1) * var_x2)) / (n1 + n2 - 2)
  # calculate the standard error
  std_error = np.sqrt(pool_var * (1 / n1 + 1 / n2))
  # calculate t statistics
  t = abs(x1_avg - x2_avg) / std_error
  return(round(t, 2))
  pass

print(t_test(NY, CS))
print(t_test(NY, BO))
print(t_test(CS, BO))
