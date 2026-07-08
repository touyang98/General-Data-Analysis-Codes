# General Data Analysis Repository Introduction 
A collection of R codes for processing laboratory instrument data used in aquatic and marine biogeochemistry.

The repository currently includes workflows for:
- absorbance and excitation–emission matrix (EEM) fluorescence data processed by HORIBA Auqalog, including PARAFAC analysis
- dissolved inorganic carbon (DIC) data processed by LI-5350A
- non-purgeable organic carbon (NPOC) and total dissolved nitrogen (TDN) data processed by Shimadzu TOC-L & TDN-L
- elemental concentration data processed by iCAP ProSeries ICP-OES

The scripts are intended to make common data-cleaning, calibration, calculation, visualization, and export steps easier to reproduce. Each instrument workflow is maintained in its own folder and can be used independently.

[IMPORTANT!!!]: These scripts are research-analysis templates rather than a fully automated software package. Instrument exports, calibration designs, sample layouts, dilution factors, and quality-control requirements may differ among laboratories and projects. Review and validate all settings before using calculated results.


## Repository contents

| Folder                                               | Instrument or data type                          | Rendered analysis                                                            | Main tasks                                                                                                                                                                                                           |
| ---------------------------------------------------- | ------------------------------------------------ | ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [`Aqualog_PARAFAC/`](Aqualog_PARAFAC/)               | Aqualog absorbance and EEM fluorescence data     | [`Aqualog_PARAFAC_Analysis.md`](Aqualog_PARAFAC/Aqualog_PARAFAC_Analysis.md) | Read absorbance and EEM files, perform blank and baseline corrections, remove and interpolate scattering regions, smooth EEMs, calculate optical indices, build and evaluate PARAFAC models, and export model output |
| [`LI-5350A_DIC/`](LI-5350A_DIC/)                     | Apollo SciTech LI-5350A DIC analyzer output      | [`LI-5350A_DIC_Analysis.md`](LI-5350A_DIC/LI-5350A_DIC_Analysis.md)          | Read DIC C5-12T CSV exports from Google Drive or local storage, clean records, construct a calibration curve, calculate sample DIC concentrations, summarize replicates, and export results                          |
| [`Shimadzu_TOC/`](Shimadzu_TOC/)                     | Shimadzu TOC-L and TNM-L output                  | [`Shimadzu_TOC_Analysis.md`](Shimadzu_TOC/Shimadzu_TOC_Analysis.md)          | Read detailed text exports, separate NPOC and TDN analyses, construct calibration curves, calculate sample concentrations and uncertainty, apply dilution corrections, and export results                            |
| [`iCAP_ProSeries_ICP-OES/`](iCAP_ProSeries_ICP-OES/) | Thermo Scientific iCAP Pro Series ICP-OES output | [`ICP-OES_Cations_Analysis.md`]                                                      | Read SpreadsheetML/XML exports, extract instrumental signals, select an ion and signal column, fit a calibration curve, and calculate dilution-corrected concentrations                                              |

## Project structure

```text
General-Data-Analysis-Codes/
├── Aqualog_PARAFAC/
│   ├── Aqualog_Data/
│   ├── Abs_Analysis_Functions.R
│   ├── EEMs_Analysis_Functions.R
│   ├── Aqualog_PARAFAC_Analysis.Rmd
│   ├── Aqualog_PARAFAC_Analysis.md
│   └── Aqualog_PARAFAC_Analysis_files/
├── LI-5350A_DIC/
│   ├── LI-5350A_DIC_Analysis.Rmd
│   ├── LI-5350A_DIC_Analysis.md
│   └── -LI-5350A_DIC_Analysis_files/
├── Shimadzu_TOC/
│   ├── Shimadzu_TOC_Functions.R
│   ├── Shimadzu_TOC_Analysis.Rmd
│   ├── Shimadzu_TOC_Analysis.md
│   ├── Shimadzu_TOC_Analysis_files/
│   └── TOC_Test_Data.txt
├── iCAP_ProSeries_ICP-OES/
│   ├── ICP-OES_Functions.R
│   └── ICP-OES_Cations_Analysis.Rmd
├── General Data Analysis Codes.Rproj
└── README.md
```

The `.Rmd` files contain editable analysis workflows. The corresponding `.md` files and figure folders contain GitHub-rendered examples where available. Helper functions are stored in the instrument folders as `.R` files.

## Requirements

* R
* RStudio is recommended
* Internet access when helper scripts are sourced directly from GitHub
* Instrument-exported data in the format expected by the selected workflow

Packages used across the repository include:

```r
install.packages(c(
  "dplyr",
  "ggplot2",
  "googledrive",
  "magrittr",
  "readr",
  "staRdom",
  "tidyverse",
  "writexl",
  "XML"
))
```

Not every package is required for every workflow. See the relevant `.Rmd` file for the minimum dependencies.


## Contributing

Suggestions, corrections, and additional instrument workflows are welcome. Please open an issue or submit a pull request with:

* a clear description of the proposed change;
* the expected input format;
* a small, de-identified example dataset when possible; and
* documentation of the expected output.

Do not commit confidential, personally identifiable, or unpublished project data.

## Citation

When using these workflows in a publication or shared analytical product, cite this repository and record the commit or release used:

```text
Ouyang, T. General Data Analysis Codes. GitHub repository:
https://github.com/touyang98/General-Data-Analysis-Codes
```

A versioned release or DOI can be added in the future for more formal citation.

## Contact

**Tianyin Ouyang (Tia)**
Email: `touyang@umces.edu`

Questions and bug reports can also be submitted through the repository's GitHub Issues page.

## License

No license file is currently included in this repository. Please contact the author before reusing, modifying, or redistributing the code outside the permissions provided by GitHub's Terms of Service.
