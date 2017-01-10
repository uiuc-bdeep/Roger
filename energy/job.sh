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
#PBS -e localhost:/projects/hackonomics/energy/log/job_name.err
#PBS -o localhost:/projects/hackonomics/energy/log/job_name.log
 
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

Rscript /projects/hackonomics/energy/power_calcs_simulation.R





