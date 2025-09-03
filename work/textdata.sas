/* Data*/

/* Delete table or view in CASUSER */
proc datasets library = CASUSER memtype = (data view) nolist nowarn;
   delete EN_TEXTDATA ;
quit;


/* region: Text Data */
filename textdata "&_USERHOME/Dataset_Public_mini.xlsx";

proc http
    url="https://github.com/siddharthsky/insurance_claim_NL-p/raw/refs/heads/main/notebooks/Dataset_Public_mini.xlsx"
    method="GET" out=textdata;
run;

proc import datafile=textdata dbms=xlsx out=casuser.EN_TEXTDATA_TMP replace;
run;

filename textdata clear;

data casuser.EN_TEXTDATA;
    set casuser.EN_TEXTDATA_TMP;
    Unique_Id = strip(put(_threadid_,8.))||'_'||strip(Put(_n_,8.));
run; 

proc casutil;
    promote casdata='EN_TEXTDATA' casout='EN_TEXTDATA' incaslib='casuser' outcaslib='casuser';
    save casdata='EN_TEXTDATA' incaslib='casuser' casout="EN_TEXTDATA.sashdat" outcaslib='casuser';
run;
/* endregion : Text Data */


