#!/bin/bash
timestamp=$(date +"%Y%m%d_%H%M%S")
outdir="results/api_${timestamp}"

mkdir -p "$outdir"

robot -d "$outdir" tests/api/get_user

echo "Test Completed!"
echo "Report: $outdir/report.html"
open "$outdir/report.html"