---
title: 'Visualizing alpha-helical peptides in R with helixvis'
tags:
  - 'antimicrobial peptide'
  - 'alpha helix'
  - 'wenxiang diagram'
  - 'helical wheel'
  - 'visualization'
authors:
  - name: 'Raoul R. Wadhwa'
    orcid: '0000-0003-0503-9580'
    affiliation: '1, 2'
  - name: 'Vigneshwar Subramanian'
    affiliation: '2'
  - name: 'Regina Stevens-Truss'
    affiliation: '1'
affiliations:
  - name: 'Department of Chemistry, Kalamazoo College, Kalamazoo, MI 49006, USA'
    index: '1'
  - name: 'Cleveland Clinic Lerner College of Medicine, Case Western Reserve University, Cleveland, OH 44195, USA'
    index: '2'
date: 5 October 2018
bibliography: paper.bib
---

# Summary

Studying the interactions of short peptides is conceptually non-trivial, even when the peptide's primary and secondary structures are known.
The difficulty is often a result of the three-dimensional spatial complexity present in protein secondary structure.
Here, we focus on $\alpha$-helical secondary structure.
Two-dimensional visualizations, specifically helical wheels (Figure 1, left panel) and wenxiang diagrams (Figure 1, right panel), are used by biochemists to study $\alpha$-helices.
Helical wheels provide a bird's eye view of a helical peptide with the amino acids forming a perfect circle, and allow for rapid identification of the peptide's hydrophobic faces [@wheeldiag], helping solve a common challenge in biochemistry research.
In contrast, wenxiang diagrams incorporate residue order by making residue distance from the center directly proportional to residue position in the peptide [@wenxiangdiag].
However, this makes the identification of hydrophobic faces less intuitive.
Together, these two forms of visualization allow researchers to more clearly understand the underlying structure of $\alpha$-helical peptides.

The helixvis R package allows researchers to programmatically create helical wheels and wenxiang diagrams for short, $\alpha$-helical peptides (Figure 1).
Although there exist several web tools that do the same, there is currently no package on the Comprehensive R Archive Network (CRAN) to implement this functionality in R.
Additionally, programmatic creation and design of graphics allows for greater customization with fewer restrictions than tools that interact with users via a grpahical interface.
By allowing programmatic customization and design of helical wheels and wenxiang diagrams, helixvis reduces the number of manual steps required to create these visualizations to essentially zero.
Thus, helixvis facilitates reproducibility, a critical component of computational research [@reproducible].

Researchers can apply helixvis to help answer a multitude of scientific questions.
In particular, helical wheels and wenxiang diagrams have been heavily used in the design of antimicrobial peptides.
There currently exist carefully curated databases listing sequences for thousands of antimicrobial peptides [@apd; @camp].
An important research goal in this area is the design of synthetic antimicrobial peptides, and the presence of strongly hydrophobic faces is known to play a role in the toxicity of $\alpha$-helical antimicrobial peptides.
The helixvis package allows researchers to rapidly and reproducibly produce helical wheels and wenxiang diagrams for known and potential antimicrobial peptide sequences, thus facilitating the design of new antimicrobial peptides.
The senior author of this paper is using helixvis for the aforementioned purpose in current research projects.
A Python version of helixvis is also currently under production [@py-helixvis].

![**Two-dimensional visualizations of an alpha-helical oligopeptide.** Left: helical wheel, particularly useful for identifying hydrophobic faces formed by secondary structure. Right: wenxiang diagram, visually incorporates amino acid order lost in helical wheels at the cost of a less intuitive visualization.](helices.png)

# Acknowledgments

Raoul R. Wadhwa and Regina Stevens-Truss thank the Alan & Elaine Hutchcroft Fund and the F.W. & Elsie Heyl Science Scholarship Fund for research funding, and the Kalamazoo College Department of Chemistry for support.

# References
