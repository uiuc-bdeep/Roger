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
#PBS -e localhost:/projects/hackonomics/energy/log/005.err
#PBS -o localhost:/projects/hackonomics/energy/log/005.log
 
### Specify the number of CPU cores for your job
#PBS -l nodes=1:ppn=20
 
### Tell PBS how much memory you expect to use. Use units of 'b','kb', 'mb' or 'gb'.
#PBS -l mem=200gb
 
### Tell PBS the anticipated run-time for your job, where walltime=HH:MM:SS
### Your job will be terminated if it exceeds this time
#PBS -l walltime=12:00:00

### loading the module of R and gdal
module load R 
module load R gdal-stack

Rscript --vanilla /projects/hackonomics/energy/power_calcs_simulation_V200.R 250 0.025 /projects/hackonomics/energy/output/result_200_002.csv
Rscript --vanilla /projects/hackonomics/energy/power_calcs_simulation_V200.R 300 0.025 /projects/hackonomics/energy/output/result_200_0025.csv




