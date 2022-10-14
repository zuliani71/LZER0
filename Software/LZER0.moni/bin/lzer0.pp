#!/bin/tcsh
# create by DZ (Jan. 2019)
#******************** Definizione delle variabili principali ********************
set path = ($path /usr/sbin /sbin /usr/local/bin /usr/bin /bin /home/${user}/bin .) #fundamental to run  scripts inside cron without full path commands
#
# MAIN JOB VALUES
set StarTime = `date +%s`
set JOB = `basename $0`
#
#********************  TUNING VARIABLES BEGIN ********************
set STORAGE     = /mnt/hd
set DUMPDIR     = ${STORAGE}/gnss
set BINDIR      = ${HOME}/bin
set TMPDIR	= ${HOME}/tmp/tmp.lzer0
set RTKCFGFILE  = ${HOME}/Projects/GPS/RTKLIB/EXPTS/CONFS/rnx2rtkp.curr.conf
#********************  TUNING VARIABLES END  ********************
#
# DEFAULT PARAMS
set YEAR  = `date +%Y`
set DOY   = `date +%j`
set HOUR  = `date +%H`
#set SES   = `echo $HOUR | hr2ses`
set RATE  = 30 #sampling rate
set FORCE = "N"
set CFGFILE = ${HOME}/bin/post.cfg
set FIXLIM = 0.10 # to be used for statistic check
if ( -e $CFGFILE ) then
	set SITE  = `cat $CFGFILE | grep -v "#" | gawk 'BEGIN{FS=":"} {if ($1=="rover name") {print $2}}' | tr -d " " | tr "a-z" "A-Z"`
	if ($SITE == "") then
		set SITE  = "UNKN" # ROVER site name
	endif
	set REFV  = `cat $CFGFILE | grep -v "#" | gawk 'BEGIN{FS=":"} {if ($1=="master name") {print $2}}' | tr -d " " | tr "a-z" "A-Z"`
	if ($REFV == "") then
                set SITE  = "UNKN" # ROVER site name
        endif
endif
#
# To avoid problems with the last session X for Hour 00
if ($HOUR == "00" || $HOUR == "0") then
        set HOUR = 24
        if ($DOY == 1) then
                # it happens the 1st of Jannuary at midnight
                set decDoys = -1
        else
                # it happens in all other cases
                @ decDoys = $DOY - 2
        endif
        set DOY = `date -d "$decDoys days ${YEAR}-01-01" +%j`
        set YEAR = `date -d "$decDoys days ${YEAR}-01-01" +%Y`
else
endif
#
# check command line params. First one is used to set the site name, second one for brand
while($#)
        switch($1)
                case "-r":
                        # Rover site name
                        shift
                        set SITE = `echo $1 | tr 'a-z' 'A-Z'`
                        breaksw
                case "-m":
                        # Master site name
                        shift
                        set REFV = `echo $1 | tr 'a-z' 'A-Z'`
                        breaksw
                case "-sr":
                        # Sampling rate
                        shift
                        set RATE = $1
                        breaksw
                case "-y":
                        # Year
                        shift
                        set YEAR = $1
                        breaksw
                case "-d":
                        # DOY
                        shift
                        set DOY = $1
                        breaksw
		case "-h":
                        # HOUR OF DAY
                        shift
                        set HOUR = $1
                        breaksw
                case "-f":
                        #  overwrite old file
                        set FORCE  = "Y"
                        breaksw
                default:
                        shift
                        breaksw
        endsw
        shift
end
set site  	= `echo $SITE | tr 'A-Z' 'a-z'`
set refv  	= `echo $REFV | tr 'A-Z' 'a-z'`
set SES   	= `echo $HOUR | hr2ses`
set ses   	= `echo $SES | tr 'A-Z' 'a-z'`
set HOURONDISK 	= `echo "$HOUR" | awk ' {if (length($0) <=1) print 0$0; else print $0}'`
set DOYONDISK 	= `echo $DOY | awk '{if (length($0) == 1) print "00"$0} {if (length($0) == 2) print "0"$0} {if (length($0) == 3) print $0}'`
set YR 		= `echo $YEAR | awk '{print substr($0,3,2)}'`
#
# Building full date
@ tempDOY = $DOY - 1
set FULLDATE = `date -d "$tempDOY days ${YEAR}-01-01" +"%Y.%m.%d"`
#
# Check TMPDIR
if ( ! -e ${TMPDIR} ) then
	mkdir -p ${TMPDIR}
endif
rm -fR ${TMPDIR}/* >& /dev/null # Cleaning tmp dir at the beginning
#
# Preparing filenames and dirs
set finalDir  	= ${DUMPDIR}/${YEAR}/${DOYONDISK}/1Hpp
set pfixObs 	= ${DOYONDISK}${ses}.${YR}o # RINEX observations 	(e.g. 342a.18o)
set pfixNav     = ${DOYONDISK}${ses}.${YR}n # GPS RINEX NAV 		(e.g. 342a.18n)
set pfixGlo     = ${DOYONDISK}${ses}.${YR}g # GLONASS RINEX NAV		(e.g. 342a.18g)
set pfixHna     = ${DOYONDISK}${ses}.${YR}h # HNAV			(e.g. 342a.18h)
set pfixQna     = ${DOYONDISK}${ses}.${YR}q # QNAV			(e.g. 342a.18q)
set pfixLna     = ${DOYONDISK}${ses}.${YR}l # LNAV			(e.g. 342a.18l)
set pfixSbs 	= ${DOYONDISK}${ses}.${YR}s # SBAS messages		(e.g. 342a.18s)
set tgtPos 	= ${SITE}.${FULLDATE}.${DOYONDISK}.${ses}.pp.pos 	# POS	(e.g. BRU1.2019.01.11.011.a.pp.pos)
set tgtPosM     = ${SITE}.${FULLDATE}.${DOYONDISK}.${ses}.pp.mean.pos 	# POS  (e.g. BRU1.2019.01.11.011.a.pp.mean.pos)
#
# Check finalDir
if ( ! -e ${finalDir} ) then
	mkdir -p ${finalDir}
endif
#
# Check il results pos file in post processing mode is already there
if ( ! -e ${finalDir}/${tgtPos}) then
	echo "Recovering ${SITE} data into ${TMPDIR}..."
	echo "lzer0.getDataOnDev -r ${SITE} -m ${REFV} -d ${DOY} -h ${HOUR} -sr $RATE"
	lzer0.getDataOnDev -r ${SITE} -m ${REFV} -d ${DOY} -h ${HOUR} -sr $RATE
	#
	# elaboration and  moving result to add
	cd ${TMPDIR}
	echo "Doing rnx2rtkp elaboration..."
	# rnx2rtkp command option syntax is  -k for config file and then
	# rover obs, master obs,  rover gps, rover glo, master gps, master glo
	echo "rnx2rtkp -k $RTKCFGFILE ${site}${pfixObs} ${refv}${pfixObs}\
                ${site}${pfixNav} ${site}${pfixGlo} > ${tgtPos}"
	rnx2rtkp -k $RTKCFGFILE ${site}${pfixObs} ${refv}${pfixObs}\
		${site}${pfixNav} ${site}${pfixGlo} > ${tgtPos}
	echo "Copying results to ${finalDir}..."
	echo "cp ${tgtPos} ${finalDir}"
	cp ${tgtPos} ${finalDir}
	#
	# doing mean values
	echo "Doing mean values..."
	echo "lzer0.getPosAvg -f ${finalDir}/${tgtPos} > ${finalDir}/${tgtPosM}"
	lzer0.getPosAvg -f ${finalDir}/${tgtPos} > ${finalDir}/${tgtPosM}
	#
	# doing some statistics
	echo "Doing some statistics..."
	echo "DATE O/E% OTH% STD% FLT% FIX% FFIX%" | gawk '{printf "%-10s %6s %6s %6s %6s %6s %6s\n",$1,$2,$3,$4,$5,$6,$7}' > ${finalDir}/${tgtPos}.stat
	echo "lzer0.getStatPosH -f ${finalDir}/${tgtPos} -s ${SITE} -l $FIXLIM > ${finalDir}/${tgtPos}.stat"
	lzer0.getStatPosH -f ${finalDir}/${tgtPos} -s ${SITE} -l $FIXLIM > ${finalDir}/${tgtPos}.stat
	exit
else
	set sizeTgt = `stat -c %s ${finalDir}/${tgtPos}`
	if (${FORCE} == "Y" || $sizeTgt == 0) then
		echo "Recovering ${SITE} data into ${TMPDIR}..."
		echo "lzer0.getDataOnDev -r ${SITE} -m ${REFV} -d ${DOY} -h ${HOUR} -sr $RATE"
		lzer0.getDataOnDev -r ${SITE} -m ${REFV} -d ${DOY} -h ${HOUR} -sr $RATE
	        #
        	# elaboration and  moving result to add
        	cd ${TMPDIR}
        	echo "Doing rnx2rtkp elaboration..."
        	# rnx2rtkp command option syntax is  -k for config file and then
        	# rover obs, master obs,  rover gps, rover glo, master gps, master glo
		echo "rnx2rtkp -k $RTKCFGFILE ${site}${pfixObs} ${refv}${pfixObs}\
                        ${site}${pfixNav} ${site}${pfixGlo} > ${tgtPos}"
        	rnx2rtkp -k $RTKCFGFILE ${site}${pfixObs} ${refv}${pfixObs}\
                	${site}${pfixNav} ${site}${pfixGlo} > ${tgtPos}
        	echo "Copying results to ${finalDir}..."
		echo "cp ${tgtPos} ${finalDir}"
        	cp ${tgtPos} ${finalDir}
		#
	        # doing mean values
		echo "Doing mean values..."
		echo "lzer0.getPosAvg -f ${finalDir}/${tgtPos} > ${finalDir}/${tgtPosM}"
        	lzer0.getPosAvg -f ${finalDir}/${tgtPos} > ${finalDir}/${tgtPosM}
	        #
        	# doing some statistics
		echo "Doing some statistics..."
		echo "DATE O/E% OTH% STD% FLT% FIX% FFIX%" | gawk '{printf "%-10s %6s %6s %6s %6s %6s %6s\n",$1,$2,$3,$4,$5,$6,$7}' > ${finalDir}/${tgtPos}.stat
        	echo "lzer0.getStatPosH -f ${finalDir}/${tgtPos} -s ${SITE} -l $FIXLIM > ${finalDir}/${tgtPos}.stat"
		lzer0.getStatPosH -f ${finalDir}/${tgtPos} -s ${SITE} -l $FIXLIM > ${finalDir}/${tgtPos}.stat
		exit
	else
		echo "File already present. Use -f option to update it."
		exit
	endif
endif
