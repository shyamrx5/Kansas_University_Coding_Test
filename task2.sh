#!/bin/bash

# Define the URL for the FASTA file
fasta_url="https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa"

# Define the local file name
fasta_file="NC_000913.faa"

# Download the FASTA file using wget
wget $fasta_url -O $fasta_file

# Check if the file download was successful
if [ ! -f "$fasta_file" ]; then
    echo "Failed to download the file. Check the URL and your internet connection."
    exit 1
fi

# Count the total number of amino acids, excluding headers
total_amino_acids=$(grep -v "^>" "$fasta_file" | tr -d '\n' | wc -c)

# Count the number of sequence headers
total_sequences=$(grep "^>" "$fasta_file" | wc -l)

# Checking divison by 0
if [ "$total_sequences" -eq 0 ]; then
    echo "No sequences found, cannot calculate average length."
    exit 1
fi

# Calculate the average length of the proteins and print the floor value
average_length=$(echo "$total_amino_acids / $total_sequences" | bc)

echo "Average protein length: $average_length"

