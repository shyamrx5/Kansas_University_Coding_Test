# Loading the necessary libraries
library(ggplot2)
library(dplyr)
library(readr)

# Step 1: Read the file
file_path <- "Homo_sapiens.gene_info.gz"  

# Read data with first line as header
gene_info <- read_delim(file_path, delim = "\t", col_names = FALSE, col_types = cols(), skip = 1)

# Rename columns based on the first line (header)
header_line <- readLines(file_path, n = 1)  # Reading the first line
header_names <- strsplit(header_line, "\t")[[1]]  # Spliting by tab to get column names
colnames(gene_info) <- header_names

# Step 2: Filter rows where Chromosome does not contain '|'
gene_info <- gene_info %>%
  filter(!grepl("\\|", .[[7]]))

# Step 3: Remove rows with NA in chromosome column and convert chromosome to character
gene_info <- gene_info %>%
  filter(!is.na(chromosome)) %>%
  mutate(chromosome = as.character(chromosome))

# Step 4: Define valid chromosome identifiers
valid_chromosomes <- c(as.character(1:22), "X", "Y", "MT", "Un")

# Step 5: Filter out rows with invalid chromosome identifiers
gene_info <- gene_info %>%
  filter(chromosome %in% valid_chromosomes)

# Step 6: Aggregate data by chromosome
gene_counts <- gene_info %>%
  group_by(chromosome) %>%
  summarise(count = n())

# Step 7: Define custom order for chromosomes
custom_order <- c(as.character(1:22), "X", "Y", "MT", "Un")

# Step 8: Arrange and plot data
gene_counts <- gene_counts %>%
  filter(chromosome %in% custom_order) %>%  # Filter again to ensure only valid chromosomes are plotted
  mutate(chromosome = factor(chromosome, levels = custom_order)) %>%
  arrange(match(chromosome, custom_order))

# Step 9: Create plot using ggplot2 and display directly
ggplot(gene_counts, aes(x = chromosome, y = count)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Number of Genes per Chromosome in Human Genomes",
       x = "Chromosome",
       y = "Number of Genes") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

ggsave("genes_per_chromosome.pdf", plot = last_plot(), width = 10, height = 6)
