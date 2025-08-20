/* Data*/
/* Text Data */
filename textdata "&_USERHOME/Dataset_Public_mini.xlsx";

proc http
    url="https://github.com/siddharthsky/insurance_claim_NL-p/raw/refs/heads/main/notebooks/Dataset_Public_mini.xlsx"
    method="GET" out=textdata;
run;

proc import datafile=textdata dbms=xlsx out=casuser.EN_TEXTDATA replace;
run;

filename textdata clear;

proc casutil;
    promote casdata='EN_TEXTDATA' casout='EN_TEXTDATA' incaslib='casuser' outcaslib='cafrance';
    save casdata='EN_TEXTDATA' incaslib='casuser' casout="EN_TEXTDATA.sashdat" outcaslib='cafrance';
run;


/* Load and promote files from File Server */
proc casutil;
	load file='&_USERHOME/EN_INSURANCE_CUSTOMER_DATA_DVR.sashdat' 
		casout='EN_INSURANCE_CUSTOMER_DATA' outcaslib='casuser';
run;

proc casutil;
	load 
		file='&_USERHOME/EN_OPENDATA_ACCIDENT.sashdat' 
		casout='EN_OPENDATA_ACCIDENT' outcaslib='casuser';
run;

/* UE_OPENDATA_ACCIDENT */
filename outfile2 "&_USERHOME/UE_OPENDATA_ACCIDENT.sashdat";

proc http
    url="https://github.com/yulia-paramonova/Viya_Experience/raw/main/Data/UE_OPENDATA_ACCIDENT.sashdat"
    method="GET" out=outfile2;
run;

proc casutil;
    load file="&_USERHOME/UE_OPENDATA_ACCIDENT.sashdat" promote
        casout='UE_OPENDATA_ACCIDENT' outcaslib='casuser';
run;

filename outfile2 clear;
/* Flux */
filename flux "&_USERHOME/Viya_Experience.flw";

proc http
    url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Flux/Viya_Experience.flw"
    method="GET" out=flux;
run;

filename flux clear;

filename flux "&_USERHOME/Flux.flw";

proc http
    url="https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Flux/Flux.flw"
    method="GET" out=flux;
run;

filename flux clear;

/* Etapes personnalisées */
/* filename outfile filesrvc folderpath="/Public" filename='Promote.step'; */
filename outfile filesrvc
    folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder"
    filename='Promote.step';

/* filename outfile "&_USERHOME/Divers/Promote.step"; */
proc http
    url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Promote.step'
    method="GET" out=outfile;
run;
filename outfile clear;

/* filename outfile filesrvc folderpath="/Public" filename='Remplacer les valeurs manquantes par 0.step'; */
filename outfile filesrvc
    folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder"
    filename='Remplacer les valeurs manquantes par 0.step';

/* filename outfile "&_USERHOME/Divers/Remplacer les valeurs manquantes par 0.step"; */
proc http
    url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Remplacer%20les%20valeurs%20manquantes%20par%200.step'
    method="GET" out=outfile;
run;
filename outfile clear;

/* filename outfile filesrvc folderpath="/Public" filename='Call_Api.step'; */
filename outfile filesrvc
    folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder"
    filename='Call_Api.step';

/* filename outfile "&_USERHOME/Divers/Call_Api.step"; */
proc http
    url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/Call_Api.step'
    method="GET" out=outfile;
run;
filename outfile clear;

filename outfile filesrvc
    folderpath="/Users/&SYS_COMPUTE_SESSION_OWNER/My Folder"
    filename='etape.step';

proc http
    url='https://raw.githubusercontent.com/yulia-paramonova/Viya_Experience/main/Etapes%20personnalis%C3%A9es/etape.step'
    method="GET" out=outfile;
run;
filename outfile clear;
