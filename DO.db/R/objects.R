###################################
#Author :Jiang Li
#Email  :riverlee2008@gamil.com
#MSN    :riverlee2008@live.cn
#Address:Harbin Medical University
#TEl    :+86-13936514493
###########################################
###############Notes#######################
#This file  contains two main objects: 
#1)DO_DB_AnnDbBimap_seeds;
#2)createAnnObjs.DO_DB
#which is created by taking file 'createAnnObjs.GO_DB.R' in AnnotationDbi package as a reference
#We defined 7 Bimaps(5 are defined in DO_DB_AnnDbBimap_seeds and 2 are defined by revmap2 which defined in createAnnObjs.DO_DB)
#Bimap object TERM, OBSOLETE, SYNONYM are similiar to GO but can't be assign to GOTermsAnnDbBimap class
#and currently assign them to AnnDbBimap class, so when applying method such as 'as.list','toTable' etc. to 
#them, it can not fetch the items defined in Rattribnames. So we may need to define an DOTermsAnnoDbBimap class
#and create functions as.list, toTable etc. to DOTermsAnnoDbBimap class
#
###################################
###################################
### =========================================================================
### An SQLite-based ann data package (AnnDbPkg) provides a set of pre-defined
### AnnObj objects that are created at load-time. This set depends only on
### the underlying db schema i.e. all the SQLite-based ann data packages that
### share the same underlying db schema will provide the same set of AnnObj
### objects.
###
### This file describes the set of AnnObj objects provided by any
### DO_DB-based package i.e. any SQLite-based ann data package based
### on the DO_DB schema.
### The createAnnObjs.DO_DB() function is the main entry point for
### this file: it is called by any DO_DB-based package at load-time.
### -------------------------------------------------------------------------
### Mandatory fields: objName, Class and L2Rchain
DO_DB_AnnDbBimap_seeds <- list(
    list(
        objName="PARENTS",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_term",
                Lcolname="do_id",
                Rcolname="_id"
            ),
            list(
                tablename="do_parents",
                Lcolname="_id",
              #  tagname=c(RelationshipType="{relationship_type}"), #not very clear here
                Rcolname="_parent_id"
            ),
            list(
                tablename="do_term",
                Lcolname="_id",
                Rcolname="do_id"
            )
        )
    ),
    
    list(
        objName="ANCESTOR",
        Class="AnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_term",
                Lcolname="do_id",
                Rcolname="_id"
            ),
            list(
                tablename="do_offspring",
                Lcolname="_offspring_id",
                Rcolname="_id"
            ),
            list(
                tablename="do_term",
                Lcolname="_id",
                Rcolname="do_id"
            )
        )
    ),
   
    list(
        objName="TERM",
        #Class="GOTermsAnnDbBimap",
       	#Class="AnnDbBimap",
       	Class="DOTermsAnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_term",
                Lcolname="do_id",
                Rcolname="do_id",
                Rattribnames=c(
                    Term="{term}",
                    #Ontology="{ontology}",
                    #Definition="{definition}",
                    Synonym="do_synonym.synonym",
                    Secondary="do_synonym.secondary"
                ),
                Rattrib_join="LEFT JOIN do_synonym ON {_id}=do_synonym._id"
            )
        )
    ),
    list(
        objName="OBSOLETE",
        #Class="GOTermsAnnDbBimap",
        #Class="AnnDbBimap",
       	Class="DOTermsAnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_obsolete",
                Lcolname="do_id",
                Rcolname="do_id",
                Rattribnames=c(
                    Term="{term}",
                    #Ontology="{ontology}",
                    #Definition="{definition}",
                    ## The RSQLite driver crashes on queries like
                    ##   SELECT NULL, ... FROM ...
                    ## so a temporary workaround is to use
                    ##   SELECT '', ... FROM ...
                    #Synonym="NULL",
                    #Secondary="NULL"
                    Synonym="''",
                    Secondary="''"
                )
            )
        )
    ),
    list(
        objName="SYNONYM",
        #Class="GOTermsAnnDbBimap",
        #Class="AnnDbBimap",
       	Class="DOTermsAnnDbBimap",
        L2Rchain=list(
            list(
                tablename="do_synonym",
                Lcolname="synonym",
                Rcolname="_id",
                filter="{like_do_id}=1"
            ),
            list(
                tablename="do_term",
                Lcolname="_id",
                Rcolname="do_id",
                Rattribnames=c(
                    Term="{term}",
                    #Ontology="{ontology}",
                    #Definition="{definition}",
                    Synonym="do_synonym.synonym",
                    Secondary="do_synonym.secondary"
                ),
                Rattrib_join="LEFT JOIN do_synonym ON {_id}=do_synonym._id"
            )
        )
    )
)

createAnnObjs.DO_DB <- function(prefix, objTarget, dbconn, datacache)
{
    #Now skip here
    #checkDBSCHEMA(dbconn, "DO_DB") 

    ## AnnDbBimap objects
    seed0 <- list(
        objTarget=objTarget,
        datacache=datacache
    )
    #ann_objs <- createAnnDbBimaps(DO_DB_AnnDbBimap_seeds, seed0)
    ann_objs <- AnnotationDbi:::createAnnDbBimaps(DO_DB_AnnDbBimap_seeds, seed0)

    ## Reverse maps
    #I am not sure whether it is suitable for diease ontology
    revmap2 <- function(from, to)
    {
        map <- revmap(ann_objs[[from]], objName=to)
        L2Rchain <- map@L2Rchain
        tmp <- L2Rchain[[1]]@filter
        L2Rchain[[1]]@filter <- L2Rchain[[length(L2Rchain)]]@filter
        L2Rchain[[length(L2Rchain)]]@filter <- tmp
        map@L2Rchain <- L2Rchain
        map
    }
    ann_objs$CHILDREN <- revmap2("PARENTS", "CHILDREN")
    ann_objs$OFFSPRING <- revmap2("ANCESTOR", "OFFSPRING")

    ## 1 special map that is not an AnnDbBimap object (just a named integer vector)
    #ann_objs$MAPCOUNTS <- createMAPCOUNTS(dbconn, prefix)
    ann_objs$MAPCOUNTS <- AnnotationDbi:::createMAPCOUNTS(dbconn, prefix)

    #prefixAnnObjNames(ann_objs, prefix)	
    AnnotationDbi:::prefixAnnObjNames(ann_objs, prefix)
}




