\name{DOTerms-class}
\docType{class}

\alias{class:DOTerms}
\alias{DOTerms-class}

\alias{DOTerms}

\alias{initialize,DOTerms-method}

\alias{DOID}
\alias{DOID,DOTerms-method}
\alias{DOID,DOTermsAnnDbBimap-method}
\alias{DOID,character-method}
\alias{Term}
\alias{Term,DOTerms-method}
\alias{Term,DOTermsAnnDbBimap-method}
\alias{Term,character-method}
\alias{Synonym}
\alias{Synonym,DOTerms-method}
\alias{Synonym,DOTermsAnnDbBimap-method}
\alias{Synonym,character-method}
\alias{Secondary}
\alias{Secondary,DOTerms-method}
\alias{Secondary,DOTermsAnnDbBimap-method}
\alias{Secondary,character-method}

\alias{show,DOTerms-method}



\title{Class "DOTerms"}

\description{A class to represent Disease Ontology nodes}

\section{Objects from the Class}{
  Objects can be created by calls of the form
  \code{DOTerms(DOId, term, synonym, secondary)}.
  DOId, term are required.
}

\section{Slots}{
  \describe{
    \item{\code{DOID}:}{Object of class \code{"character"} A character
      string for the DO id of a primary node.}
    \item{\code{Term}:}{Object of class \code{"character"} A
      character string that defines the role of gene product
      corresponding to the primary DO id.}
    \item{\code{Synonym}:}{Object of class \code{"character"} other
      ontology terms that are considered to be synonymous to the primary
      term attached to the DO id. Synonymous here can mean that the
      synonym is an exact synonym of the primary term, is related to the
      primary term, is broader than the primary term, is more precise
      than the primary term, or name is related to the term, but is not
      exact, broader or narrower.}
    \item{\code{Secondary}:}{Object of class \code{"character"} DO ids
      that are secondary to the primary DO id as results of merging DO
      terms so that One DO id becomes the primary DO id and the rest
      become the secondary.}
  }
}

\section{Methods}{
  \describe{
    \item{DOID}{\code{signature(object = "DOTerms")}:
      The get method for slot DOID.}
    \item{Term}{\code{signature(object = "DOTerms")}:
      The get method for slot Term.}
    \item{Synonym}{\code{signature(object = "DOTerms")}:
      The get method for slot Synonym.}
    \item{Secondary}{\code{signature(object = "DOTerms")}:
      The get method for slot Secondary.}
    \item{show}{\code{signature(x = "DOTerms")}:
      The method for pretty print.}
  }
}

\references{
\url{http://do-wiki.nubic.northwestern.edu/index.php/Main_Page} 
}

\note{DOTerms objects are used to represent primary DO nodes in the
   SQLite-based annotation data package DO.db}

\examples{
  DOnode <- new("DOTerms", DOID="DOID:1234567", Term="Test")
  DOID(DOnode)
  Term(DOnode)

  ##Or you can just use these methods on a DOTermsAnnDbBimap
\dontrun{##I want to show an ex., but don't want to require DO.db
  require(DO.db)
  FirstTenDOBimap <- DOTERM[1:10] ##grab the 1st ten
  Term(FirstTenDOBimap)

  ##Or you can just use DO IDs directly
  ids = keys(FirstTenDOBimap)
  Term(ids)
}
}

\keyword{methods}
\keyword{classes}

