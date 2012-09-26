#!/usr/bin/R
###################################
#Author :Jiang Li
#Email  :riverlee2008@gamil.com
#MSN    :riverlee2008@live.cn
#Address:Harbin Medical University
#TEl    :+86-13936514493
###################################

setClass("DOTermsAnnDbBimap",contains="AnnDbBimap");
setClass("DOTerms",
    representation(
        DOID="character",       # a single string (mono-valued)
        Term="character",       # a single string (mono-valued)
        #Ontology="character",   # a single string (mono-valued)
        #Definition="character", # a single string (mono-valued)
        Synonym="character",    # any length including 0 (multi-valued)
        Secondary="character"   # any length including 0 (multi-valued)
    )
)

### The mono-valued slots are also the mandatory slots.
#.DONODE_MONOVALUED_SLOTS <- c("DOID", "Term", "Ontology", "Definition")
.DONODE_MONOVALUED_SLOTS <- c("DOID", "Term")

### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### Initialization.
###

setMethod("initialize", "DOTerms",
    function(.Object, ...)
    {
        args <- list(...)
        argnames <- names(args)
        if (is.null(argnames) || any(argnames == ""))
            stop("all arguments must be named")
        argnames <- match.arg(argnames, slotNames(.Object), several.ok=TRUE)
        if (!(all(.DONODE_MONOVALUED_SLOTS %in% argnames))) {
            s <- paste(.DONODE_MONOVALUED_SLOTS, collapse=", ")
            stop("arguments ", s, " are mandatory")
        }
        for (i in seq_len(length(args))) {
            argname <- argnames[i]
            value <- args[[i]]
            if ((argname %in% .DONODE_MONOVALUED_SLOTS)) {
                if (length(value) != 1)
                    stop("can't assign ", length(value),
                         " values to mono-valued slot ", argname)
            } else {
                value <- value[!(value %in% c(NA, ""))]
            }
            slot(.Object, argname) <- value
        }
        .Object
    }
)

#used to construct a DOTerms object
DOTerms <- function(DOId, term,  synonym = "", secondary = ""
                   ){
    return(new("DOTerms", DOID = DOId, Term = term,
               Synonym = synonym, Secondary = secondary))
}


### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### The "DOID", "Term", "Ontology", "Definition", "Synonym" and "Secondary" 
### generics (accessor methods).
###

setGeneric("DOID", function(object) standardGeneric("DOID")) 
setGeneric("Term", function(object) standardGeneric("Term"))
#setGeneric("Ontology", function(object) standardGeneric("Ontology"))
#setGeneric("Definition", function(object) standardGeneric("Definition"))
setGeneric("Synonym", function(object) standardGeneric("Synonym"))
setGeneric("Secondary", function(object) standardGeneric("Secondary"))

setMethod("DOID", "DOTerms", function(object) object@DOID)

setMethod("Term", "DOTerms", function(object) object@Term)

#setMethod("Ontology", "DOTerms", function(object) object@Ontology)

#setMethod("Definition", "DOTerms", function(object) object@Definition)

setMethod("Synonym", "DOTerms", function(object) object@Synonym)

setMethod("Secondary", "DOTerms", function(object) object@Secondary)


##.DOid2go_termField() retrieves ids of type field from go_term
.DOid2go_termField <- function(ids, field){
    require("DO.db")
##     message(cat("Before SQL \n")) ##test
    sql <- sprintf("SELECT do_id, %s
                    FROM do_term
                    WHERE do_id IN ('%s')",
                   field,
                   paste(ids, collapse="','"))
    res <- dbGetQuery(DO_dbconn(), sql)
    if(dim(res)[1]==0 && dim(res)[2]==0){
        stop("None of your IDs match IDs from DO.  Are you sure you have valid IDs?")
    }else{
        ans <- res[[2]]
        names(ans) <- res[[1]]
        return(ans[ids]) ##This only works because each DO ID is unique (and therefore a decent index ID)
    }
}

setMethod("DOID", "DOTermsAnnDbBimap",function(object) .DOid2go_termField(keys(object),"do_id") )
setMethod("DOID", "character",function(object) .DOid2go_termField(object,"do_id") )

setMethod("Term", "DOTermsAnnDbBimap",function(object) .DOid2go_termField(keys(object),"term") )
setMethod("Term", "character",function(object) .DOid2go_termField(object,"term") )

#setMethod("Ontology", "DOTermsAnnDbBimap",function(object) .DOid2go_termField(keys(object),"ontology") )
#setMethod("Ontology", "character",function(object) .DOid2go_termField(object,"ontology") )

#setMethod("Definition", "DOTermsAnnDbBimap",function(object) .DOid2go_termField(keys(object),"definition") )
#setMethod("Definition", "character",function(object) .DOid2go_termField(object,"definition") )


##.DOid2go_synonymField() retrieves ids of type field from go_synonym
.DOid2go_synonymField <- function(ids, field){
    require("DO.db")
    sql <- paste("SELECT gt.do_id, gs.",field,"
                  FROM do_term AS gt, do_synonym AS gs
                  WHERE gt._id=gs._id AND do_id IN ('",paste(ids, collapse="','"),"')", sep="")
    res <- dbGetQuery(DO_dbconn(), sql)
    if(dim(res)[1]==0 && dim(res)[2]==0){
        stop("None of your IDs match IDs from DO.  Are you sure you have valid IDs?")
    }else{
        ans = split(res[,2],res[,1])
        return(ans[ids])##once again (this time in list context), we are indexing with unique IDs.
    }
}

setMethod("Synonym", "DOTermsAnnDbBimap",function(object) .DOid2go_synonymField(keys(object),"synonym") )
setMethod("Synonym", "character",function(object) .DOid2go_synonymField(object,"synonym") )

setMethod("Secondary", "DOTermsAnnDbBimap",function(object) .DOid2go_synonymField(keys(object),"secondary") )
setMethod("Secondary", "character",function(object) .DOid2go_synonymField(object,"secondary") )




### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
### The "show" methods.
###

setMethod("show", "DOTerms",
    function(object)
    {
        s <- character(0)
        for (slotname in slotNames(object)) {
            x <- slot(object, slotname)
            if ((slotname %in% .DONODE_MONOVALUED_SLOTS) && length(x) != 1) {
                warning("mono-valued slot ", slotname,
                        " contains ", length(x), " values")
            } else {
                if (length(x) == 0)
                    next
            }
            s <- c(s, paste(slotname, ": ", x, sep=""))
        }
        cat(strwrap(s, exdent=4), sep="\n")
    }
)





setMethod("as.list", "DOTermsAnnDbBimap",
    function(x, ...)
    {
        y <- AnnotationDbi:::flatten(x, fromKeys.only=TRUE)
        makeDONode <- function(do_id, Term, ...)
        {
            new("DOTerms", DOID=do_id[1],
                           Term=Term[1],
                           #Synonym = Synonym[1],
                           #Secondary = Secondary[1],
                           ...)
        }
        AnnotationDbi:::.toListOfLists(y, mode=1, makeDONode)
    }
)







