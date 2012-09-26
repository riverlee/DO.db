datacache <- new.env(hash=TRUE, parent=emptyenv())

DO <- function() showQCData("DO", datacache)
DO_dbconn <- function() dbconn(datacache)
DO_dbfile <- function() dbfile(datacache)
#DO_dbschema <- function(file="", show.indices=FALSE) dbschema(datacache, file=file, show.indices=show.indices)
DO_dbInfo <- function() dbInfo(datacache)
DO_dbschema <- function(){writeLines(strwrap(readLines(system.file("DBschemas","schemas_1.0","DO_DB.sql", package ="DO.db")),indent=2, exdent=4))}

.onLoad <- function(libname, pkgname)
{
    require("methods", quietly=TRUE)
    
    #################################
    #set the classes and defined the methods
    #classfile<-system.file("scripts","DOClasses.R", package=pkgname, lib.loc=libname)
    #source(classfile);
    setClass("DOTermsAnnDbBimap",contains="AnnDbBimap");
    
    ## Connect to the SQLite DB
    dbfile <- system.file("extdata", "DO.sqlite", package=pkgname, lib.loc=libname)
    assign("dbfile", dbfile, envir=datacache)
    dbconn <- dbFileConnect(dbfile)
    assign("dbconn", dbconn, envir=datacache)
    
    #later when Bimap object defined in AnnotationDbi package use
    #ann_objs <- createAnnObjs.SchemaChoice("DO_DB", "DO", "DO", dbconn, datacache)
    #but currently we use following
    #Get the objects.R file in inst/scripts directory which defined Bimap object
    #bimapfile<-system.file("scripts","objects.R", package=pkgname, lib.loc=libname)
    #source(bimapfile)
    ann_objs<-createAnnObjs.DO_DB("DO", "DO", dbconn, datacache)
    mergeToNamespaceAndExport(ann_objs, pkgname)   
}

.onUnload <- function(libpath)
{
    dbFileDisconnect(DO_dbconn())
}

