\name{DOPARENTS}
\alias{DOPARENTS}
\title{Annotation of DO Identifiers to their Parents} 
\description{
  This data set describes associations between DO
  terms and their direct parent  terms, based on the directed acyclic
  graph (DAG) defined by the Disease Ontology Consortium. The format is an R
  object mapping the DO  terms to all direct parent terms, where a
  direct parent term is a more general DO term that immediately precedes
  the given DO term in the DAG.
}
\details{
  Each DO  term is mapped to a named vector of DO  terms. The name
  associated with the parent term will be either \emph{isa}, \emph{partof},
  where \emph{isa} indicates that the child term is a more specific version
  of the parent, and  \emph{partof} indicate that the
  child term is a part of the parent. 

 
  Mappings were based on data provided by: Disease Ontology
  With a date stamp from the source of: 20150323 (sub_version 2806)


}
\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
%and \url{http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene} 
}
\examples{
  # Convert the object to a list
  xx <- as.list(DOPARENTS)
  # Remove DO IDs that do not have any parent
  xx <- xx[!is.na(xx)]
  if(length(xx) > 0){
     doids <- xx[[1]]
     # Find out the DO terms for the first parent do ID
     DOID(DOTERM[[doids[1]]])
     Term(DOTERM[[doids[1]]])
     Synonym(DOTERM[[doids[1]]])
     Secondary(DOTERM[[doids[1]]])
  }
}
\keyword{datasets}

