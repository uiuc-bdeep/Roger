### Set the job name
#PBS -N Energy 0.02 Trail
 
### Use the bourne shell
#PBS -S /bin/bash
 
### To send email when the job is completed:
### be --- before execution
### ae --- after execution
#PBS -m ae
#PBS -M zhang303@illinois.edu
 
### Optionally set the destination for your program's output
### Specify localhost and an NFS filesystem to prevent file copy errors.
#PBS -e localhost:/projects/hackonomics/energy/log/$NOUT_{sample}_${effect}_${log}_${iter}.err
#PBS -o localhost:/projects/hackonomics/energy/log/$NOUT_{sample}_${effect}_${log}_${iter}.log
 
### Specify the number of CPU cores for your job
#PBS -l nodes=1:ppn=20
 
### Tell PBS how much memory you expect to use. Use units of 'b','kb', 'mb' or 'gb'.
#PBS -l mem=200gb
 
### Tell PBS the anticipated run-time for your job, where walltime=HH:MM:SS
### Your job will be terminated if it exceeds this time
#PBS -l walltime=48:00:00

### loading the module of R and gdal
module load R 
module load R gdal-stack

SOURCE_SCRIPT=/projects/hackonomics/energy/test_no_output.R
###SOURCE_SCRIPT=/projects/hackonomics/energy/power_calcs_simulation_V200.R
OUTPUT_PATH=/projects/hackonomics/energy/${output}/NOUT_result_${sample}_${effect}_${log}_${iter}.csv
LOG_PATH=/projects/hackonomics/energy/log/NOUT_${sample}_${effect}_${log}_${iter}

echo $OUTPUT_PATH
echo $LOG_PATH

Rscript --vanilla $SOURCE_SCRIPT ${sample} ${effect} $OUTPUT_PATH $LOG_PATH ${iter}

###Rscript --vanilla $SOURCE_SCRIPT 350 0.02 /projects/hackonomics/energy/output/result_350_002.csv
###Rscript --vanilla $SOURCE_SCRIPT 400 0.02 /projects/hackonomics/energy/output/result_400_002.csv




