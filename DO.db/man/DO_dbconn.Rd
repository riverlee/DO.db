
\name{DO_dbconn}

\alias{DO_dbconn}
\alias{DO_dbfile}
\alias{DO_dbschema}
\alias{DO_dbInfo}


\title{Collect information about the package annotation DB}

\description{
  Some convenience functions for getting a connection object to (or collecting
  information about) the package annotation DB.
}

\usage{
  DO_dbconn()
  DO_dbfile()
%  DO_dbschema(file="", show.indices=FALSE)
  DO_dbschema()
  DO_dbInfo()
}

%\arguments{
%  \item{file}{
%    A connection, or a character string naming the file to print to (see
%    the \code{file} argument of the \code{\link[base]{cat}} function for
%    the details).
%  }
%  \item{show.indices}{
%    The CREATE INDEX statements are not shown by default.
%    Use \code{show.indices=TRUE} to get them.
%  }
%}

\details{
  \code{DO_dbconn} returns a connection object to the
  package annotation DB.  IMPORTANT: Don't call
  \code{\link[DBI:dbConnect]{dbDisconnect}} on the connection object
  returned by \code{DO_dbconn} or you will break all the
  \code{\link[AnnotationDbi:AnnDbObj-class]{AnnDbObj}} objects defined
  in this package!

  \code{DO_dbfile} returns the path (character string) to the
  package annotation DB (this is an SQLite file).

  \code{DO_dbschema} prints the schema definition of the
  package annotation DB.

  \code{DO_dbInfo} prints other information about the package
  annotation DB.
}

\value{
  \code{DO_dbconn}: a DBIConnection object representing an
  open connection to the package annotation DB.

  \code{DO_dbfile}: a character string with the path to the
  package annotation DB.

  \code{DO_dbschema}: none (invisible \code{NULL}).

  \code{DO_dbInfo}: none (invisible \code{NULL}).
}

\seealso{
  \code{\link[DBI:dbSendQuery]{dbGetQuery}},
  \code{\link[DBI:dbConnect]{dbConnect}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbconn}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbfile}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbschema}},
  \code{\link[AnnotationDbi:AnnDbObj-class]{dbInfo}}
}

\examples{
  ## Count the number of rows in the "do_term" table:
  dbGetQuery(DO_dbconn(), "SELECT COUNT(*) FROM do_term")

  ## The connection object returned by DO_dbconn() was
  ## created with:
  dbConnect(SQLite(), dbname=DO_dbfile(), cache_size=64000,
  synchronous=0)

  #DO_dbschema()

#  DO_dbInfo()
}

\keyword{utilities}
\keyword{datasets}

