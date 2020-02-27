# CC-HIC Data Specification Version 2.0

This is a comprehensive data specification for CC-HIC designed to facilitate the ETL to OMOP (OHDSI CDM). We follow the same conventions as detailed on the OHDSI Common Data Model wiki.

The founding axioms apply when performing your ETL:
- If something happens, we must know about it and have a record.
- If there is no record, it must follow that nothing happened.

It is a major limitation of the current iteration of HIC, that missingness is prolific, and cannot be distinguished from when something didn't happen.

## Goals

1. Provide a clear mapping (flat file) from HIC data objects to SNOMED or other standard vocab
2. Provide a clear insight into how that should be represented in OMOP

## To do:

Ed:
Push this repo
Share synthetic/dummy "core" flat file so Aasiyah and Claire can spin an OMOP db to work from.
Alter muncher to keep things in memor
01-import-core.r
start -> 02-cvs-bundle.r

Aasiyah:
Double check all fields have an athena code
Assign "new HIC codes" that respect the "keep", "drop", "merge" principle
Assiyah finish CSV.r

Claire:
Assign bundles (based on organ system)
Assign resource types (based on where data is likely to come from)
Claire do resp.r

Build synthetic data for the existing core/dummy patients, for each bundle so that there is a OMOP representation of this data (fairly easy for everything except micro, which will be challenging)

|-code
  |-01-import-core.r
  |-02-cvs-bundle.r
|-synthetic_omop
  |- all the omop tables ... .csv

rules for code files:

begin with accepting the final product of the previous file
end with writing out the tables to csv.

### THE FUTURE

generating the wiki...


