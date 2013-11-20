#!/bin/bash

###############################
## Loading the JBrowse instance

## Set Path variables
AIP_HOME=/usr/local/projects/AIP
TAIR_DATA=DataProviders/TAIR
GBROWSE_DATA_ROOT=ftp.arabidopsis.org/Maps/gbrowse_data
CUSTOM_DATA=vkrishna/TAIR10_GFF3/genome_browser

JBROWSE_DATA=data/json/tair10

# Reference sequence
bin/prepare-refseqs.pl --out $JBROWSE_DATA --fasta $AIP_HOME/vkrishna/TAIR10_fasta/TAIR10_genome.fas --trackLabel "TAIR10_genome" --key "Reference Sequence"

# Genes
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/TAIR10_GFF3_genes_transposons.20131107_1826.gff3 --trackLabel "TAIR10_genes" --key "Protein Coding Gene Models" --className "transcript" --getType --getSubfeatures --getLabel --subfeatureClasses '{"exon":"transcript-exon","CDS":"transcript-CDS","five_prime_UTR":"transcript-UTR","three_prime_UTR":"transcript-UTR"}' --type "mRNA:TAIR10"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/TAIR10_GFF3_genes_transposons.20131107_1826.gff3 --trackLabel "TAIR10_transposons" --key "Natural Transposons" --type "transposable_element:TAIR10" --className "generic_parent" --subfeatureClasses '{"transposon_fragment": "match_part"}'
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/TAIR10_unconfirmed_exons.gff --trackLabel "TAIR10_unconfirmed_exons" --key "Unconfirmed Exons" --className "exon" --type "exon:TAIREXONCONF"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/TAIR10_GFF3_genes_transposons.20131107_1826.gff3 --trackLabel "TAIR10_pseudogenes" --key "Pseudogenes" --className "generic_parent" --subfeatureClasses '{"pseduogenic_exon":"exon"}' --type "pseudogenic_transcript:TAIR10"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/Spliced_Junctions_clustered.gff --trackLabel "TAIR10_Spliced_Junctions_clustered" --key "Spliced Junctions" --className "exon" --type "exon:SAM1"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/tair9_Quesneville_Transposons_20090429.20131118_0936.gff --trackLabel "TAIR9_Quesneville_Transposons" --key "Quesneville et al. Natural Transposons" --type "transposable_element:Quesneville" --className "generic_parent" --subfeatureClasses '{"transposon_fragment": "match_part"}'

# Genomic Features
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/TAIR10_GFF3_genes_transposons.20131107_1826.gff3 --trackLabel "TAIR10_ncRNAs" --key "ncRNAs" --type "ncRNA:TAIR10" --className "generic_parent" --subfeatureClasses '{"exon": "match_part"}'
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR10/TAIR_GFF3_ssrs.gff --trackLabel "TAIR_SSRs" --key "Tandem Repeats" --className "feature3" --clientConfig '{"featureCss": "background-color: #623;"}' --type "satellite:TandemRepeatsFinder_v4.04"

# Assembly tracks
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/TAIR9_GFF3_assemblies.gff --trackLabel "TAIR9_assemblies" --key "Tiling Path" --className "feature5" --type "BAC_cloned_genomic_insert:TAIR"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/tair9_Assembly_gaps.gff --trackLabel "TAIR9_assembly_gaps" --key "Gaps" --className "feature5" --clientConfig '{"featureCss": "background-color: red;"}' --type "gap:TAIR9"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Assembly_GFF/tair9_assembly_updates.gff --trackLabel "TAIR9_assembly_updates" --key "Assembly Updates" --className "feature3" --type "possible_assembly_error:TAIR9,possible_base_call_error:TAIR9,possible_deletion:TAIR9,possible_insertion:TAIR9"

# Variation
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_tdnas.gff --trackLabel "TAIR9_tDNAs" --key "T-DNAs/Transposons" --type "transposable_element_insertion_site:TAIR9" --noSubfeatures --className "triangle hgred invert"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_polymorphisms.gff --trackLabel "TAIR9_polymorphisms" --key "Polymorphisms" --className "diamond dmyellow" --type "INDEL:Allele,compound:Allele,deletion:Allele,insertion:Allele,substitution:Allele"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Variation_GFF/TAIR9_GFF3_markers.gff --trackLabel "TAIR9_markers" --key "Markers" --type "marker:TAIR9" --className "generic_part_a"

# Expression
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$TAIR_DATA/$GBROWSE_DATA_ROOT/TAIR9/Expression_GFF/tair9_ATH1-121501.gff --trackLabel "TAIR9_Microarray_probes" --key "Microarray ATH1-121501 probes" --type "microarray_probe:NetAffx" --className "generic_part_a"
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/tair9_atproteometair7.20131118_0936.gff --trackLabel "TAIR9_AtProteome" --key "AtProteome (Baerenfaller et al. 2008)" --type "protein_match:AtProteomeTAIR9" --className "generic_parent" --subfeatureClasses '{"match_part": "match_part"}'
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $AIP_HOME/$CUSTOM_DATA/tair9_Briggs_atproteome7_20090401.20131118_0936.gff --trackLabel "TAIR9_Briggs_AtProteome" --key "AtProteome (Briggs et al.)" --type "protein_match:at_proteome_TAIR9" --className "generic_parent" --subfeatureClasses '{"match_part": "match_part"}'
