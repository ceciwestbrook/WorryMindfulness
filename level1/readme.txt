# Ceci Westbrook, 11/2021

Level 1 analyses were performed using FSL's Feat program. In this directory is a copy of the template design (fsf) files and a script that can generate the design files for all participants. Note that there are 3 different versions of the design file: the ordinary template which assumes both successful and unsuccessful worry disengagement trials; the NOworry template which is for runs with all successful disengagement, and the ONLYworry template which is for runs with no successful disengagement trials. These designations will be carried forward to level 2 where they will be needed to exclude no/only worry runs for successful vs. unsuccessful disengagement contrasts.

The individual timing files are not included in this repository but they can be generated from the .tsv files in the associated OpenNeuro dataset. We used the 3-column FSL format. An example timing file is included in this directory with the columns 1) onset 2) duration 3) modulator (always set to 1 for this study).

Use of this repository assumes basic knowledge of bash or other command-line scripting and software such as Python or R for data reformatting.