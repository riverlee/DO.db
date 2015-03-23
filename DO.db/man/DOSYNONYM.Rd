\name{DOSYNONYM}
\alias{DOSYNONYM}
\title{Map from DO synonyms to DO terms}
\description{
  DOSYNONYM is an R object that provides mapping
  from DO synonyms to DO terms
}
\details{
  Mappings were based on data provided by: Disease Ontology
  With a date stamp from the source of: 20150323 (sub_version 2806)


}
\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
%and \url{http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene} 
}
\examples{
    x <- DOSYNONYM
    sample(x, 3)
    # DO ID "DOID:8757" has a lot of synonyms
    DOTERM[["DOID:8757"]]
    # DO ID "DOID:9134" is a synonym of DO ID "DOID:8757"
    DOID(DOSYNONYM[["DOID:9134"]])
}
\keyword{datasets}

