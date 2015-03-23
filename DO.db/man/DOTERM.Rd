\name{DOTERM}
\alias{DOTERM}
\title{Annotation of DO Identifiers to DO Terms}
\description{
  This data set gives mappings between DO identifiers and their respective terms.
}
\details{
  Each DO identifier is mapped to a \code{DOTerms} object that has 4 slots:
   DOID: DO Identifier;
   Term: The term for that DO id;
   Secondary: Secondary terms that have been merged into this term;
   Synonym: other  ontology terms that are considered to be synonymous to the primary
      term attached to the DO id
 
  
  Mappings were based on data provided by: Disease Ontology
  With a date stamp from the source of: 20150323 (sub_version 2806)


}
\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
%and \url{http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?db=gene} 
}
\examples{
    # Convert the object to a list
    FirstTenDOBimap <- DOTERM[1:10] ##grab the 1st ten
    xx <- as.list(FirstTenDOBimap)
     if(length(xx) > 0){
        # Get the TERMS for the 2nd element of xx
        DOID(xx[[2]])
        Term(xx[[2]])
        Synonym(xx[[2]])
        Secondary(xx[[2]])
    }
}
\keyword{datasets}

