#!/bin/bash

###############################
## Loading the JBrowse instance

## Set Path variables
source /usr/local/projects/AIP/DataProviders/TAIR/araport.env

## JBrowse data path
JBROWSE_DATA=data/json/arabidopsis

# Reference sequence
#bin/prepare-refseqs.pl --out $JBROWSE_DATA --fasta $AIP_HOME/$TAIR_DATA/custom_data/$CHRS_FASTA/TAIR10_genome.fas \
#    --trackLabel "TAIR10_genome" --key "Reference Sequence"

# Genes
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_CUSTOM_GFF3/TAIR10_GFF3_genes_transposons.AIP.gff \
    --trackLabel "TAIR10_genes" --key "Protein Coding Gene Models" --nameAttributes "name,alias,id,symbol" \
    --trackType "JBrowse/View/Track/CanvasFeatures" --type "gene,transposable_element_gene"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_CUSTOM_GFF3/TAIR10_GFF3_genes_transposons.AIP.gff \
    --trackLabel "TAIR10_transposons" --key "Natural Transposons" --type "transposable_element:TAIR10" \
    --className "generic_parent" --subfeatureClasses '{"transposon_fragment": "feature3"}' \
    --nameAttributes "name,alias,id,symbol"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_GFF3/TAIR10_unconfirmed_exons.gff \
    --trackLabel "TAIR10_unconfirmed_exons" --key "Unconfirmed Exons" --className "exon" \
    --type "exon:TAIREXONCONF" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_CUSTOM_GFF3/TAIR10_GFF3_genes_transposons.AIP.gff \
    --trackLabel "TAIR10_pseudogenes" --key "Pseudogenes" --className "generic_parent" \
    --subfeatureClasses '{"pseduogenic_exon":"exon"}' --type "pseudogenic_transcript:TAIR10" \
    --nameAttributes "name,alias,id,symbol"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_GFF3/Spliced_Junctions_clustered.gff \
    --trackLabel "TAIR10_Spliced_Junctions_clustered" --key "Spliced Junctions" \
    --className "exon" --type "exon:SAM1" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA \
    --gff $TAIR9_CUSTOM_GFF3/Community_annotation_GFF/tair9_Quesneville_Transposons_20090429.gff \
    --trackLabel "TAIR9_Quesneville_Transposons" --key "Quesneville et al. Natural Transposons" \
    --type "transposable_element:Quesneville" --className "generic_parent" \
    --subfeatureClasses '{"transposon_fragment": "match_part"}'

# Genomic Features
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_CUSTOM_GFF3/TAIR10_GFF3_genes_transposons.AIP.gff \
    --trackLabel "TAIR10_ncRNAs" --key "ncRNAs" --nameAttributes "name,alias,id,symbol" \
    --type "ncRNA:TAIR10,miRNA:TAIR10,tRNA:TAIR10,snoRNA:TAIR10,snRNA:TAIR10,rRNA:TAIR10" \
    --className "generic_parent" --subfeatureClasses '{"exon": "feature2"}'

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR10_GFF3/TAIR_GFF3_ssrs.gff \
    --trackLabel "TAIR_SSRs" --key "Tandem Repeats" --className "feature3" --nameAttributes "name" \
    --clientConfig '{"featureCss": "background-color: #623;"}' --type "satellite:TandemRepeatsFinder_v4.04"

# Assembly tracks
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Assembly_GFF/TAIR9_GFF3_assemblies.gff \
    --trackLabel "TAIR9_assemblies" --key "Tiling Path" --className "feature5" \
    --type "BAC_cloned_genomic_insert:TAIR" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Assembly_GFF/tair9_Assembly_gaps.gff \
    --trackLabel "TAIR9_assembly_gaps" --key "Gaps" --className "feature5" \
    --clientConfig '{"featureCss": "background-color: red;"}' --type "gap:TAIR9"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Assembly_GFF/tair9_assembly_updates.gff \
    --trackLabel "TAIR9_assembly_updates" --key "Assembly Updates" --className "feature3" \
    --type "possible_assembly_error:TAIR9,possible_base_call_error:TAIR9,possible_deletion:TAIR9,possible_insertion:TAIR9"

# Variation
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_tdnas.gff \
    --trackLabel "TAIR9_tDNAs" --key "T-DNAs/Transposons" \
    --type "transposable_element_insertion_site:TAIR9" --noSubfeatures \
    --className "triangle hgred invert" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_polymorphisms.gff \
    --trackLabel "TAIR9_polymorphisms" --key "Polymorphisms" --nameAttributes "name" \
    --type "INDEL:Allele,compound:Allele,deletion:Allele,insertion:Allele,substitution:Allele" \
    --className "diamond dmyellow" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Variation_GFF/TAIR9_GFF3_markers.gff \
    --trackLabel "TAIR9_markers" --key "Markers" --type "marker:TAIR9" --className "generic_part_a" \
    --nameAttributes "name"

# Expression
bin/flatfile-to-json.pl --out $JBROWSE_DATA --gff $TAIR9_GFF3/Expression_GFF/tair9_ATH1-121501.gff \
    --trackLabel "TAIR9_Microarray_probes" --key "Microarray ATH1-121501 probes" \
    --type "microarray_probe:NetAffx" --className "generic_part_a" --nameAttributes "name"

bin/flatfile-to-json.pl --out $JBROWSE_DATA \
    --gff $TAIR9_CUSTOM_GFF3/Expression_GFF/tair9_atproteometair7.gff --trackLabel "TAIR9_AtProteome" \
    --key "AtProteome (Baerenfaller et al. 2008)" --type "protein_match:AtProteomeTAIR9" \
    --className "generic_parent" --subfeatureClasses '{"match_part": "feature5"}'

bin/flatfile-to-json.pl --out $JBROWSE_DATA \
    --gff $TAIR9_CUSTOM_GFF3/Expression_GFF/tair9_Briggs_atproteome7_20090401.gff \
    --trackLabel "TAIR9_AtPeptide" --key "AtPeptide (Castellana et al. 2008)" \
    --type "protein_match:at_proteome_TAIR9" --className "generic_parent" \
    --subfeatureClasses '{"match_part": "feature5"}'

# Index names and set up autocompletion
bin/generate-names.pl --out data/json/arabidopsis \
    --tracks "TAIR10_genes,TAIR10_pseudogenes,TAIR10_ncRNAs,TAIR10_transposons,TAIR9_Quesneville_Transposons,TAIR9_markers,TAIR9_polymorphisms,TAIR_SSRs,TAIR9_tDNAs,TAIR9_Microarray_probes,TAIR9_assemblies" \
    --workdir /opt/www/araport/tmp --verbose --mem 4076000000
