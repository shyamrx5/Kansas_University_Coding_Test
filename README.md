# Task 1 -Gene Info Processing Tool
## Overview
#### This Python script reads specific columns from a gene information file, creates mappings from gene symbols to GeneIDs, and updates GMT files with these IDs.
## Requirements
1.Python 3.x
2.Pandas library
3.gzip library
## Usage
Prepare your gene info file (Homo_sapiens.gene_info.gz) and your GMT file.
Run the script using the command line:

python script_name.py <gene_info_path> <gmt_file_path> <output_file_path> [--print]

* gene_info_path: Path to the .gz gene info file.
* gmt_file_path: Path to the GMT file to be processed.
* output_file_path: Path where the updated GMT file will be saved.
* --print: Optional flag to print the output to the terminal.
Example

python script_name.py data/gene_info.gz data/sample.gmt results/updated.gmt --print

This will process the gene info and GMT files, save the updated GMT file to 'results/updated.gmt', and print the output to the terminal if the --print option is used.


# Task 2 
