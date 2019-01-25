# save a data frame containing 4 AMP names and sequences from
#   the Antimicrobial Peptide Database (APD3)
#   URL: http://aps.unmc.edu/AP/main.php
sample_seq <- data.frame(Name = c("Aurein 2.2",
                                  "Cecropin A-Magainin 2 Hybrid",
                                  "Uperin 3.5",
                                  "Citropin 1.1",
                                  "CPF-ST3"),
                         Seq = c("GLFDIVKKVVGALGSL",
                                 "KWKLFKKIKFLHSAKKF",
                                 "GVGDLIRKAVSVIKNIV",
                                 "GLFDVIKKVASVIGGL",
                                 "GLLGPLLKIAAKVGSNLL"),
                         stringsAsFactors = FALSE)
