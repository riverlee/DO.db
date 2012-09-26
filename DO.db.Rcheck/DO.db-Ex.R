pkgname <- "DO.db"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('DO.db')

assign(".oldSearch", search(), pos = 'CheckExEnv')
cleanEx()
nameEx("DOANCESTOR")
### * DOANCESTOR

flush(stderr()); flush(stdout())

### Name: DOANCESTOR
### Title: Annotation of DO Identifiers to their Ancestors
### Aliases: DOANCESTOR
### Keywords: datasets

### ** Examples

  # Convert the object to a list
  xx <- as.list(DOANCESTOR)
  # Remove DO IDs that do not have any ancestor
  xx <- xx[!is.na(xx)]
  if(length(xx) > 0){
    # Get the ancestor DO IDs for the first two elents of xx
    doids <- xx[1:2]
  }
  



cleanEx()
nameEx("DOBASE")
### * DOBASE

flush(stderr()); flush(stdout())

### Name: DO.db
### Title: Bioconductor annotation data package
### Aliases: DO.db DO
### Keywords: datasets

### ** Examples

  ls("package:DO.db")



cleanEx()
nameEx("DOCHILDREN")
### * DOCHILDREN

flush(stderr()); flush(stdout())

### Name: DOCHILDREN
### Title: Annotation of DO Identifiers to their Children
### Aliases: DOCHILDREN
### Keywords: datasets

### ** Examples

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



cleanEx()
nameEx("DOMAPCOUNTS")
### * DOMAPCOUNTS

flush(stderr()); flush(stdout())

### Name: DOMAPCOUNTS
### Title: Number of mapped keys for the maps in package DO.db
### Aliases: DOMAPCOUNTS
### Keywords: datasets

### ** Examples

  DOMAPCOUNTS
  mapnames <- names(DOMAPCOUNTS)
  DOMAPCOUNTS[mapnames[1]]
  x <- get(mapnames[1])
  sum(!is.na(as.list(x)))
  count.mappedkeys(x)   # much faster!

  ## Check the "map count" of all the maps in package DO.db
  #checkMAPCOUNTS("DO.db")



cleanEx()
nameEx("DOOBSOLETE")
### * DOOBSOLETE

flush(stderr()); flush(stdout())

### Name: DOOBSOLETE
### Title: Annotation of DO identifiers by terms defined by Disease
###   Ontology Consortium and their status are obsolete
### Aliases: DOOBSOLETE
### Keywords: datasets

### ** Examples

    # Convert the object to a list
    xx <- as.list(DOOBSOLETE)
    if(length(xx) > 0){
        # Get the TERMS for the first elent of xx
        DOID(xx[[1]])
        Term(xx[[1]])
    }



cleanEx()
nameEx("DOOFFSPRING")
### * DOOFFSPRING

flush(stderr()); flush(stdout())

### Name: DOOFFSPRING
### Title: Annotation of DO Identifiers to their Offspring
### Aliases: DOOFFSPRING
### Keywords: datasets

### ** Examples

  # Convert the object to a list
  xx <- as.list(DOOFFSPRING)
  # Remove DO IDs that do not have any offspring
  xx <- xx[!is.na(xx)]
   if(length(xx) > 0){
    # Get the offspring DO identifiers for the first two elents of xx
    doidentifiers <- xx[1:2]
  }



cleanEx()
nameEx("DOPARENTS")
### * DOPARENTS

flush(stderr()); flush(stdout())

### Name: DOPARENTS
### Title: Annotation of DO Identifiers to their Parents
### Aliases: DOPARENTS
### Keywords: datasets

### ** Examples

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



cleanEx()
nameEx("DOSYNONYM")
### * DOSYNONYM

flush(stderr()); flush(stdout())

### Name: DOSYNONYM
### Title: Map from DO synonyms to DO terms
### Aliases: DOSYNONYM
### Keywords: datasets

### ** Examples

    x <- DOSYNONYM
    sample(x, 3)
    # DO ID "DOID:8757" has a lot of synonyms
    DOTERM[["DOID:8757"]]
    # DO ID "DOID:9134" is a synonym of DO ID "DOID:8757"
    DOID(DOSYNONYM[["DOID:9134"]])



cleanEx()
nameEx("DOTERM")
### * DOTERM

flush(stderr()); flush(stdout())

### Name: DOTERM
### Title: Annotation of DO Identifiers to DO Terms
### Aliases: DOTERM
### Keywords: datasets

### ** Examples

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



cleanEx()
nameEx("DOTerms-class")
### * DOTerms-class

flush(stderr()); flush(stdout())

### Name: DOTerms-class
### Title: Class "DOTerms"
### Aliases: class:DOTerms DOTerms-class DOTerms initialize,DOTerms-method
###   DOID DOID,DOTerms-method DOID,DOTermsAnnDbBimap-method
###   DOID,character-method Term Term,DOTerms-method
###   Term,DOTermsAnnDbBimap-method Term,character-method Synonym
###   Synonym,DOTerms-method Synonym,DOTermsAnnDbBimap-method
###   Synonym,character-method Secondary Secondary,DOTerms-method
###   Secondary,DOTermsAnnDbBimap-method Secondary,character-method
###   show,DOTerms-method
### Keywords: methods classes

### ** Examples

  DOnode <- new("DOTerms", DOID="DOID:1234567", Term="Test")
  DOID(DOnode)
  Term(DOnode)

  ##Or you can just use these methods on a DOTermsAnnDbBimap
## Not run: 
##D ##I want to show an ex., but don't want to require DO.db
##D   require(DO.db)
##D   FirstTenDOBimap <- DOTERM[1:10] ##grab the 1st ten
##D   Term(FirstTenDOBimap)
##D 
##D   ##Or you can just use DO IDs directly
##D   ids = keys(FirstTenDOBimap)
##D   Term(ids)
## End(Not run)



cleanEx()
nameEx("DOTermsAnnDbBimap")
### * DOTermsAnnDbBimap

flush(stderr()); flush(stdout())

### Name: DOTermsAnnDbBimap
### Title: Class "DOTermsAnnDbBimap"
### Aliases: DOTermsAnnDbBimap class:DOTermsAnnDbBimap
###   DOTermsAnnDbBimap-class
### Keywords: classes interface

### ** Examples

   class(DOTERM)



cleanEx()
nameEx("DO_dbconn")
### * DO_dbconn

flush(stderr()); flush(stdout())

### Name: DO_dbconn
### Title: Collect information about the package annotation DB
### Aliases: DO_dbconn DO_dbfile DO_dbschema DO_dbInfo
### Keywords: utilities datasets

### ** Examples

  ## Count the number of rows in the "do_term" table:
  dbGetQuery(DO_dbconn(), "SELECT COUNT(*) FROM do_term")

  ## The connection object returned by DO_dbconn() was
  ## created with:
  dbConnect(SQLite(), dbname=DO_dbfile(), cache_size=64000,
  synchronous=0)

  #DO_dbschema()

#  DO_dbInfo()



### * <FOOTER>
###
cat("Time elapsed: ", proc.time() - get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
