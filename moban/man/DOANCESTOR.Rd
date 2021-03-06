\name{DOANCESTOR}
\alias{DOANCESTOR}
\title{Annotation of DO Identifiers to their Ancestors} 
\description{
  This data set describes associations between DO 
  terms and their ancestor  terms, based on the directed acyclic
  graph (DAG) defined by the Disease Ontology Consortium. The format is an R
  object mapping the DO  terms to all ancestor terms, where an
  ancestor term is a more general DO term that precedes
  the given DO term in the DAG (in other words, the parents, and all
  their parents, etc.).
}
\details{
  Each DO  term is mapped to a vector of ancestor DO  terms.
  
  
    
  Mappings were based on data provided by: Disease Ontology
  With a date stamp from the source of: ?


}
\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
%and \url{http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene} 
}
\examples{
  # Convert the object to a list
  xx <- as.list(DOANCESTOR)
  # Remove DO IDs that do not have any ancestor
  xx <- xx[!is.na(xx)]
  if(length(xx) > 0){
    # Get the ancestor DO IDs for the first two elents of xx
    doids <- xx[1:2]
  }
  
}
\keyword{datasets}

