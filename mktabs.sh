#!/bin/bash
set -e

cd "$(dirname "$0")"
mkdir -p tsv

mktsv () {
  awk 'NF==2 && /^[^#]/ {print $1,$2}' OFS='\t' "$@"
}

mktsv1 () {
  grep '^[^#]' "$@" | cat -n | mktsv
}

./pull-oim-tables.sh > tsv/oim-tables.tsv
./run-oneshot.sh     > tsv/gratia_summary.tsv
mktsv RGMap          > tsv/RGMap.tsv
mktsv normal_hepspec > tsv/normal_hepspec.tsv
mktsv1 VOList        > tsv/VOList.tsv

