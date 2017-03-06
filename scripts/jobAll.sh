
### runnning the 20 iteration benchmark
###qsub -v sample=350,effect=0.02,log=log1,output=output,iter=20 jobTest.sh
###qsub -v sample=350,effect=0.03,log=log1,output=output,iter=20 jobTest.sh
###qsub -v sample=350,effect=0.04,log=log1,output=output,iter=20 jobTest.sh

### running the single iteration benchmark
###qsub -v sample=350,effect=0.02,log=log1_1,output=output jobSingleTest.sh
###qsub -v sample=350,effect=0.03,log=log2_1,output=output jobSingleTest.sh
###qsub -v sample=350,effect=0.04,log=log3_1,output=output jobSingleTest.sh

### runnning the 50 iteration benchmark
###qsub -v sample=350,effect=0.02,log=log1,output=output,iter=50 jobTest.sh
###qsub -v sample=350,effect=0.03,log=log1,output=output,iter=50 jobTest.sh
###qsub -v sample=350,effect=0.04,log=log1,output=output,iter=50 jobTest.sh

### runnning the 100 iteration benchmark
###qsub -v sample=350,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
###qsub -v sample=350,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
###qsub -v sample=350,effect=0.04,log=log1,output=output,iter=100 jobTest.sh

### runnning the 200 iteration benchmark
###qsub -v sample=350,effect=0.02,log=log1,output=output,iter=200 jobTest.sh
###qsub -v sample=350,effect=0.03,log=log1,output=output,iter=200 jobTest.sh
###qsub -v sample=350,effect=0.04,log=log1,output=output,iter=200 jobTest.sh

### running a comparison test between contains file output and without output
qsub -v sample=300,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.025,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.035,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.04,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.045,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=300,effect=0.05,log=log1,output=output,iter=100 jobTest.sh

qsub -v sample=350,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.025,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.035,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.04,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.045,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=350,effect=0.05,log=log1,output=output,iter=100 jobTest.sh

qsub -v sample=400,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.025,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.035,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.04,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.045,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=400,effect=0.05,log=log1,output=output,iter=100 jobTest.sh

qsub -v sample=500,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.025,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.035,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.04,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.045,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=500,effect=0.05,log=log1,output=output,iter=100 jobTest.sh

qsub -v sample=600,effect=0.02,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.025,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.03,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.035,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.04,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.045,log=log1,output=output,iter=100 jobTest.sh
qsub -v sample=600,effect=0.05,log=log1,output=output,iter=100 jobTest.sh

### then the one without output

qsub -v sample=300,effect=0.02,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.025,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.03,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.035,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.04,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.045,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=300,effect=0.05,log=log1,output=output,iter=100 jobTest_no_output.sh

qsub -v sample=350,effect=0.02,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.025,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.03,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.035,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.04,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.045,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=350,effect=0.05,log=log1,output=output,iter=100 jobTest_no_output.sh

qsub -v sample=400,effect=0.02,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.025,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.03,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.035,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.04,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.045,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=400,effect=0.05,log=log1,output=output,iter=100 jobTest_no_output.sh

qsub -v sample=500,effect=0.02,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.025,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.03,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.035,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.04,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.045,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=500,effect=0.05,log=log1,output=output,iter=100 jobTest_no_output.sh

qsub -v sample=600,effect=0.02,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.025,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.03,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.035,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.04,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.045,log=log1,output=output,iter=100 jobTest_no_output.sh
qsub -v sample=600,effect=0.05,log=log1,output=output,iter=100 jobTest_no_output.sh



