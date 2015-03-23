\name{DOCHILDREN}
\alias{DOCHILDREN}
\title{Annotation of DO Identifiers to their Children} 
\description{
This data set describes associations between DO 
  terms and their direct children  terms, based on the directed acyclic
  graph (DAG) defined by the Disease Ontology Consortium. The format is an R
  object mapping the DO  terms to all direct children terms, where a
  direct child term is a more specific DO term that is immediately preceded
  by the given DO term in the DAG.
}
\details{
   Each DO  term is mapped to a vector of children DO  terms.

   
  Mappings were based on data provided by: Disease Ontology
  With a date stamp from the source of: 20150323 (sub_version 2806)


}
\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
%and \url{http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene} 
}
\examples{
  # Convert the object to a list
  xx <- as.list(DOCHILDREN)
  # Remove DO IDs that do not have any children
  xx <- xx[!is.na(xx)]
  
  if(length(xx) > 0){
     # Get the parent DO IDs for the first elents of xx
        doids <- xx[[1]]
        # Find out the DO terms for the first parent doid
        DOID(DOTERM[[doids[1]]])
        Term(DOTERM[[doids[1]]])
        Synonym(DOTERM[[doids[1]]])
        Secondary(DOTERM[[doids[1]]])
  }
}
\keyword{datasets}

