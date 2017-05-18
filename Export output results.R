### exporting output results


# export to csv
write.csv(data, "file.csv")

# professional outputs
library(xtable)
table(sap$z1)
print(xtable(m1), type = "html", file = "heckhack.doc") #type = "LaTeX" alternatively
print(xtable(table(sap$z1)), type = "html", file = "somename.doc")

library(texreg)
htmlreg(list(m1, m2, m3), single.row = T, file = "heckhack.doc")
texreg(list(m1, m2))