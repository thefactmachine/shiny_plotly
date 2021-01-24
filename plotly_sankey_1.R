library(plotly)

# https://plotly.com/r/sankey-diagram/
# define the data

vct_source <- c(0,1,0,2,3,3)
vct_target <- c(2,3,3,4,4,5)
vct_value <-  c(7,4,1,8,4,2)

lst_link <- list(source = vct_source, target = vct_target, value =  vct_value)

lst_line <- list(color = "black", width = 0.5)
vct_label <- c("A1", "A2", "B1", "B2", "C1", "C2")
vct_color <- c("red", "pink", "green", "brown", "black", "yellow")
lst_node <- list(label = vct_label, color = vct_color, 
                 pad = 15, thickness = 20)


fig <- plot_ly(type = "sankey", orientation = "h", 
               node = lst_node, link = lst_link)
fig <- fig %>% layout(title = "Basic Sankey Diagram", font = list(size = 10))
fig

# vectors are zero based...convert to 1 based
vct_source_1_base <- vct_source + 1
vct_target_1_base <-  vct_target + 1

# the positions of the labels are: A1 = 1 & B1 = 3

# =======================
# so we have A1 (1) to B1 (3)
vct_source_1_base[which(vct_label == "A1")]
vct_target_1_base[which(vct_label == "A1")]

# ========================
# and then B1 (3) to C1 (5)
# B1 source (i.e number 3 is the fourth position)
# this prints out 3
vct_source_1_base[4]
# this prints out 5
vct_target_1_base[4]

# ========================
# We also have A1 going to B2 (position 3 on source)
vct_source_1_base[3]

# what is the target for this...I bet it is B2 (position 4)
vct_target_1_base[3]

# here is the value
vct_value[3]

# =============================================================================
# ssh



