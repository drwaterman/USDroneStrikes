library(googlesheets)
library(plotly)
library(dplyr)
library(xts)
library(shiny)

c_names <- c("Strike_ID", "Date", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
             "Minimum_people_killed", "Maximum_people_killed",
             "Minimum_civilians_reported_killed",
             "Maximum_civilians_reported_killed",
             "Minimum_children_reported_killed",
             "Maximum_children_reported_killed",
             "x8", "x9", "x10", "x11", "x12")

afg_names <- c("Strike_ID", "Date", "x1", "x2", "x3", "x4", "x5", "x6", "x7","x8","x9",
               "x10","x11","x12","x13",
               "Minimum_people_killed", "Maximum_people_killed",
               "Minimum_civilians_reported_killed",
               "Maximum_civilians_reported_killed",
               "Minimum_children_reported_killed",
               "Maximum_children_reported_killed",
               "x14", "x15", "x16", "x17", "x18")

# Load and Process Pakistan data
pak_url <- "https://docs.google.com/spreadsheets/d/1NAfjFonM-Tn7fziqiv33HlGt09wgLZDSCP-BQaux51w/edit?usp=sharing"
pak_sheet <- gs_url(pak_url)
pak_data <- gs_read(pak_sheet, ws="Drone strikes data")
pak_data <- pak_data[,c(2,5:10)]
pak_data$Date <- as.Date(pak_data$Date, format = "%d/%m/%Y")
names(pak_data) <- gsub(" ", "_", names(pak_data))
pak_data$people_killed <-
                rowMeans(pak_data[,c("Minimum_total_people_killed",
                                 "Maximum_total_people_killed")])
pak_data$civilians_killed <-
                rowMeans(pak_data[,c("Minimum_civilians_reported_killed",
                                 "Maximum_civilians_reported_killed")])
pak_data$children_killed <-
                rowMeans(pak_data[,c("Minimum_children_reported_killed",
                                 "Maximum_children_reported_killed")])
pak_avg_data <- pak_data[,c(1,8:10)]
pak_ts <- xts(pak_data[,c(8:10)], order.by=pak_data$Date)
# convert daily data to monthly sums
pak_ts_m = apply.monthly(pak_ts, colSums)

pak_plot_data <- data.frame(date=index(pak_ts_m),
                            people_killed=pak_ts_m[,1,drop=T],
                            civilians_killed=pak_ts_m[,2,drop=T],
                            children_killed=pak_ts_m[,3,drop=T])


# Load and Process Yemen data
yemen_url <- "https://docs.google.com/spreadsheets/d/1lb1hEYJ_omI8lSe33izwS2a2lbiygs0hTp2Al_Kz5KQ/edit?usp=sharing"
yemen_sheet <- gs_url(yemen_url)
yemen_data <- gs_read(yemen_sheet, ws="All US actions", col_names=c_names, skip=2)
yemen_data <- yemen_data[,c(2,10:15)]
# There is a typo in the original data, one line has 2105 for year
yemen_data$Date <- sub("21/08/2105", "21/08/2015", yemen_data$Date)
yemen_data$Date <- as.Date(yemen_data$Date, format = "%d/%m/%Y")
yemen_data$people_killed <-
                rowMeans(yemen_data[,c("Minimum_people_killed",
                                 "Maximum_people_killed")])
yemen_data$civilians_killed <-
                rowMeans(yemen_data[,c("Minimum_civilians_reported_killed",
                                 "Maximum_civilians_reported_killed")])
yemen_data$children_killed <-
                rowMeans(yemen_data[,c("Minimum_children_reported_killed",
                                 "Maximum_children_reported_killed")])

yemen_avg_data <- yemen_data[,c(1,8:10)]
yemen_ts <- xts(yemen_data[,c(8:10)], order.by=yemen_data$Date)
# convert daily data to monthly sums
yemen_ts_m = apply.monthly(yemen_ts, colSums)

yemen_plot_data <- data.frame(date=index(yemen_ts_m),
                              people_killed=yemen_ts_m[,1,drop=T],
                              civilians_killed=yemen_ts_m[,2,drop=T],
                              children_killed=yemen_ts_m[,3,drop=T])


# Load and Process Somalia data
som_url <- "https://docs.google.com/spreadsheets/d/1-LT5TVBMy1Rj2WH30xQG9nqr8-RXFVvzJE_47NlpeSY/edit#gid=1110953463"
som_sheet <- gs_url(som_url)
som_data <- gs_read(som_sheet, ws="All US actions", col_names=c_names[1:19], skip=2)
som_data <- som_data[,c(2,10:15)]
som_data$Date <- as.Date(som_data$Date, format = "%d/%m/%Y")
som_data$people_killed <-
                rowMeans(som_data[,c("Minimum_people_killed",
                                 "Maximum_people_killed")])
som_data$civilians_killed <-
                rowMeans(som_data[,c("Minimum_civilians_reported_killed",
                                 "Maximum_civilians_reported_killed")])
som_data$children_killed <-
                rowMeans(som_data[,c("Minimum_children_reported_killed",
                                 "Maximum_children_reported_killed")])

som_avg_data <- som_data[,c(1,8:10)]
som_ts <- xts(som_data[,c(8:10)], order.by=som_data$Date)
# convert daily data to monthly sums
som_ts_m = apply.monthly(som_ts, colSums)

som_plot_data <- data.frame(date=index(som_ts_m),
                            people_killed=som_ts_m[,1,drop=T],
                            civilians_killed=som_ts_m[,2,drop=T],
                            children_killed=som_ts_m[,3,drop=T])


# Load and Process Afghanistan data
# Original Afghanistan spreadsheet permissions cause errors, will instead use copy
# on my personal Google account
#afg_url <- "https://docs.google.com/spreadsheets/d/1Q1eBZ275Znlpn05PnPO7Q1BkI3yJZbvB3JycywAmqWc/edit?usp=sharing"
afg_url <- "https://docs.google.com/spreadsheets/d/19QS0-wp-NIiRRiOfJq1JdEphPmUlDn-0d09_1B9BapY/edit?usp=sharing"
afg_sheet <- gs_url(afg_url)
afg_data <- gs_read(afg_sheet, ws="Bureau data: US strikes", col_names = afg_names, skip=2)
afg_data <- afg_data[,c(2,16:21)]
afg_data$Date <- as.Date(afg_data$Date, format = "%d/%m/%Y")
afg_data$people_killed <-
                rowMeans(afg_data[,c("Minimum_people_killed",
                                 "Maximum_people_killed")])
afg_data$civilians_killed <-
                rowMeans(afg_data[,c("Minimum_civilians_reported_killed",
                                 "Maximum_civilians_reported_killed")])
afg_data$children_killed <-
                rowMeans(afg_data[,c("Minimum_children_reported_killed",
                                 "Maximum_children_reported_killed")])

afg_avg_data <- afg_data[,c(1,8:10)]
afg_ts <- xts(afg_data[,c(8:10)], order.by=afg_data$Date)
# convert daily data to monthly sums
afg_ts_m = apply.monthly(afg_ts, colSums)

afg_plot_data <- data.frame(date=index(afg_ts_m),
                            people_killed=afg_ts_m[,1,drop=T],
                            civilians_killed=afg_ts_m[,2,drop=T],
                            children_killed=afg_ts_m[,3,drop=T])



all_data <- rbind(pak_avg_data, yemen_avg_data, som_avg_data, afg_avg_data)
all_ts <- xts(all_data[,2:4], order.by=all_data$Date)
# convert daily data to monthly sums
all_ts_m = apply.monthly(all_ts, colSums)
all_plot_data <- data.frame(date=index(all_ts_m),
                            people_killed=all_ts_m[,1,drop=T],
                            civilians_killed=all_ts_m[,2,drop=T],
                            children_killed=all_ts_m[,3,drop=T])

