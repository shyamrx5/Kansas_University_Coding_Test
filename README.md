# Task 1 -Gene Info Processing Tool
## Overview
#### This Python script reads specific columns from a gene information file, creates mappings from gene symbols to GeneIDs, and updates GMT files with these IDs.
## Requirements
Python 3.x;
Pandas library;
gzip library

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


# Task 2 FASTA File Processor
## Overview
#### This Bash script downloads a FASTA file of Escherichia coli K-12 substr. MG1655 from NCBI, counts the total number of amino acids, and calculates the average protein length.

## Usage
To run the script, use the following command in a terminal:

bash task2.sh

The script performs the following steps:

* Downloads the specified FASTA file using wget.
* Checks if the file was downloaded successfully.
* Counts the total amino acids in the file, excluding the header lines.
* Counts the total number of protein sequences.
* Calculates and displays the average length of the proteins.

## Output
#### The script will print:The average protein length if the file is processed successfully.

# Task3 -Gene Count Visualization 

## Overview
#### This R script processes gene information from a compressed .gz file and visualizes the distribution of gene counts across chromosomes. It filters out unwanted entries, aggregates gene counts by chromosome, and produces a bar plot to show the number of genes per chromosome.

## Usage

* Place the gene information file (Homo_sapiens.gene_info.gz) in your working directory or specify the full path in the script.
* Run the script in R or RStudio.
  
## Steps Performed by the Script

* Read the file: Opens and reads data from a .gz compressed file, assuming the first line after the skipped row is the header.
* Filtering data: Removes rows with chromosome identifiers containing | or are NA, and keeps only valid chromosomes (1-22, X, Y, MT, Un).
* Aggregating data: Counts the number of genes per chromosome.
* Data visualization: Generates a bar plot showing the number of genes per chromosome and saves the plot as a PDF (genes_per_chromosome.pdf).

## Example Command

source("Task3.R")

## Output

#### The script will generate a PDF file named genes_per_chromosome.pdf in the working directory, showing the average length of proteins by chromosome.

