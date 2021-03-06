% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/individualQC.R
\name{check_ancestry}
\alias{check_ancestry}
\title{Identification of individuals of divergent ancestry}
\usage{
check_ancestry(indir, name, qcdir = indir, prefixMergedDataset,
  europeanTh = 1.5, refSamples = NULL, refColors = NULL,
  refSamplesFile = NULL, refColorsFile = NULL, refSamplesIID = "IID",
  refSamplesPop = "Pop", refColorsColor = "Color",
  refColorsPop = "Pop", studyColor = "#2c7bb6",
  run.check_ancestry = TRUE, interactive = FALSE, verbose = verbose,
  path2plink = NULL, showPlinkOutput = TRUE)
}
\arguments{
\item{indir}{[character] /path/to/directory containing the basic PLINK data
files name.bim, name.bed, name.fam files.}

\item{name}{[character] prefix of plink files, i.e. name.bed, name.bim,
name.fam.}

\item{qcdir}{[character] /path/to/directory where
prefixMergedDataset.eigenvec results as returned by plink --pca should be
saved. Per default qcdir=indir. If run.check_ancestry is FALSE, it is assumed
that plink --pca prefixMergedDataset has been run and
qcdir/prefixMergedDataset.eigenvec exists.User needs writing permission to
qcdir.}

\item{prefixMergedDataset}{[character] Prefix of merged dataset (study and
reference samples) used in plink --pca, resulting in
prefixMergedDataset.eigenvec.}

\item{europeanTh}{[double] Scaling factor of radius to be drawn around center
of European reference samples, with study samples inside this radius
considered to be of European descent and samples outside this radius of
non-European descent. The radius is computed as the maximum Euclidean
distance of European reference samples to the centre of European reference
samples.}

\item{refSamples}{[data.frame] Dataframe with sample identifiers
[refSamplesIID] corresponding to IIDs in prefixMergedDataset.eigenvec and
population identifier [refSamplesPop] corresponding to population IDs
[refColorsPop] in refColorsfile/refColors. Either refSamples or
refSamplesFile have to be specified.}

\item{refColors}{[data.frame, optional] Dataframe with population IDs in
column [refColorsPop] and corresponding colour-code for PCA plot in column
[refColorsColor]. If not provided and is.null(refColorsFile) default colors
are used.}

\item{refSamplesFile}{[character] /path/to/File/with/reference samples. Needs
columns with sample identifiers [refSamplesIID] corresponding to IIDs in
prefixMergedDataset.eigenvec and population identifier [refSamplesPop]
corresponding to population IDs [refColorsPop] in refColorsfile/refColors.}

\item{refColorsFile}{[character, optional]
/path/to/File/with/Population/Colors containing population IDs in column
[refColorsPop] and corresponding colour-code for PCA plot in column
[refColorsColor].If not provided and is.null(refColors) default colors for
are used.}

\item{refSamplesIID}{[character] Column name of reference sample IDs in
refSamples/refSamplesFile.}

\item{refSamplesPop}{[character] Column name of reference sample population
IDs in refSamples/refSamplesFile.}

\item{refColorsColor}{[character] Column name of population colors in
refColors/refColorsFile}

\item{refColorsPop}{[character] Column name of reference sample population
IDs in refColors/refColorsFile.}

\item{studyColor}{[character] Colour to be used for study population.}

\item{run.check_ancestry}{[logical] Should plink --pca be run to
determine principal components of merged dataset; if FALSE, it is assumed
that plink --pca has been run successfully and
qcdir/prefixMergedDataset.eigenvec is present;
\code{\link{check_ancestry}} will fail with missing file error otherwise.}

\item{interactive}{[logical] Should plots be shown interactively? When
choosing this option, make sure you have X-forwarding/graphical interface
available for interactive plotting. Alternatively, set interactive=FALSE and
save the returned plot object (p_ancestry) via ggplot2::ggsave(p=p_ancestry,
other_arguments) or pdf(outfile) print(p_ancestry) dev.off().}

\item{verbose}{[logical] If TRUE, progress info is printed to standard out.}

\item{path2plink}{[character] Absolute path to PLINK executable
(\url{https://www.cog-genomics.org/plink/1.9/}) i.e.
plink should be accesible as path2plink -h. The full name of the executable
should be specified: for windows OS, this means path/plink.exe, for unix
platforms this is path/plink. If not provided, assumed that PATH set-up works
and PLINK will be found by \code{\link[sys]{exec_wait}}('plink').}

\item{showPlinkOutput}{[logical] If TRUE, plink log and error messages are
printed to standard out.}
}
\value{
Named [list] with i) fail_ancestry, containing a [data.frame] with
FID and IID of non-European individuals and ii) p_ancestry, a ggplot2-object
'containing' a scatter plot of PC1 versus PC2 colour-coded for samples of the
reference populations and the study population, which can be shown by
print(p_ancestry).
}
\description{
Runs and evaluates results of plink --pca on merged genotypes from
individuals to be QCed and individuals of reference population of known
genotypes. Currently, check ancestry only supports automatic selection of
individuals of European descent. It uses information from principal
components 1 and 2 returned by plink --pca to find the center of the European
reference samples (mean(PC1_europeanRef), mean(PC2_europeanRef). It then
computes the maximum Euclidean distance (maxDist) of the European reference
samples from this centre. All study samples whose Euclidean distance from the
centre falls outside the circle described by the radius r=europeanTh* maxDist
are considered non-European and their IDs are returned as failing the
ancestry check.
\code{check_ancestry} creates a scatter plot of PC1 versus PC2 colour-coded
for samples of the reference populations and the study population.
}
\examples{
\dontrun{
indir <- system.file("extdata", package="plinkQC")
name <- "data"
fail_ancestry <- check_ancestry(indir=indir, name=name,
refSamplesFile=paste(indir, "/HapMap_ID2Pop.txt",sep=""),
refColorsFile=paste(indir, "/HapMap_PopColors.txt", sep=""),
prefixMergedDataset="data.HapMapIII", interactive=FALSE,
run.check_ancestry=FALSE)
}
}
