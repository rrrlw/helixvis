# save a data frame containing 5 AMP names and sequences from
#   the Collection of Anti-Microbial Peptides database
#   URL: http://www.camp.bicnirrh.res.in/index.php
sequence <- data.frame(Name = c("Polyphemusin-1",
                                "Lariatin A",
                                "Longipin",
                                "Lycocitin-1",
                                "Phylloseptin-L1"),
                       Seq = c("RRWCFRVCYRGFCYRKCR",
                               "GSQLVYREWVGHSNVIKP",
                               "SGYLPGKEYVYKYKGKVF",
                               "GKLQAFLAKMKEIAAQTL",
                               "LLGMIPLAISAISALSKL"),
                       stringsAsFactors = FALSE)

# add to package
devtools::use_data(sequence)
