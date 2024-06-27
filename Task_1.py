import pandas as pd
import gzip
import argparse


## TASK 1:


def read_specific_columns(file_path):
    """Read and print specific columns (GeneID, Symbol, Synonyms) from the gene info file."""
    with gzip.open(file_path, 'rt') as file:
        gene_info = pd.read_csv(file, sep='\t', header=0, usecols=[1, 2, 4])
    return gene_info

## 2.1
def create_symbol_to_geneid_map(file_path):
    """Create a mapping of gene symbols and their synonyms to GeneID."""
    gene_info = read_specific_columns(file_path)
    gene_info.columns = ['GeneID', 'Symbol', 'Synonyms']
    symbol_to_geneid = {}
    for index, row in gene_info.iterrows():
        symbol_to_geneid[row['Symbol']] = row['GeneID']
        if pd.notna(row['Synonyms']):
            synonyms = row['Synonyms'].split('|')
            for synonym in synonyms:
                symbol_to_geneid[synonym] = row['GeneID']
    return symbol_to_geneid


## 2.2
def process_gmt_file(gmt_file_path, symbol_to_geneid_map, output_file_path, print_to_terminal):
    """Process GMT file, replace gene names with Entrez IDs, save and print the results."""
    with open(gmt_file_path, 'r') as file, open(output_file_path, 'w') as outfile:
        for line in file:
            parts = line.strip().split('\t')
            pathway_name, pathway_description = parts[0], parts[1]
            gene_names = parts[2:]
            entrez_ids = [str(symbol_to_geneid_map.get(gene, 'NA')) for gene in gene_names]
            updated_line = '\t'.join([pathway_name, pathway_description] + entrez_ids)
            outfile.write(updated_line + '\n')
            if print_to_terminal:
                print(updated_line)

def main(gene_info_path, gmt_file_path, output_file_path, print_to_terminal):
    symbol_to_geneid_map = create_symbol_to_geneid_map(gene_info_path)
    process_gmt_file(gmt_file_path, symbol_to_geneid_map, output_file_path, print_to_terminal)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process gene information and GMT files.")
    parser.add_argument("gene_info_path", type=str, help="Path to the Homo_sapiens.gene_info.gz file")
    parser.add_argument("gmt_file_path", type=str, help="Path to the GMT file")
    parser.add_argument("output_file_path", type=str, help="Path to save the updated GMT file")
    parser.add_argument("--print", action='store_true', help="Print the updated lines to the terminal")
    args = parser.parse_args()

    main(args.gene_info_path, args.gmt_file_path, args.output_file_path, args.print)


