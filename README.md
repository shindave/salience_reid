# Improving Unsupervised Salience Learning for Person Re-identification

4772 Advanced Machine Learning final project

Modified by Wei Dai (wd2248)

Reference code: MATLAB code for our CVPR 2013 work "R. Zhao, W. Ouyang, and X. Wang. [Unsupervised Salience Learning for Person Re-identification](http://www.ee.cuhk.edu.hk/~rzhao/project/salience_cvpr13/zhaoOWcvpr13.pdf). In CVPR 2013."

Created by [Rui Zhao](www.ee.cuhk.edu.hk/~rzhao), on May 20, 2013.


##Summary
In this package, you find an updated version of MATLAB code for the following paper:
Rui Zhao, Wanli Ouyang, and Xiaogang Wang. Unsupervised Salience Learning for Person Re-identification. In IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2013. 


##Install
- Download VIPeR dataset, and put the subfolders (\cam_a and \cam_b) into directory .\dataset\viper\
- Compile patchmatch component: go to directory ./code/patchmatch and run mex *.cpp in Matlab
- Compile LibSVM: go to directory ./code/libsvm, and run make.m in Matlab
- If you are running on Linux or OS X system, slash characters in following files should be changed from '\' to '/' accordingly: ./code/norm_data.m, ./code/initialcontext_general.m, ./set_paths.m, ./demo_salience_reid_viper.m, ./demo_salience_reid_ethz.m

##Demos
- demo_salience_reid_viper.m : perform evaluation over VIPeR dataset

##Remarks
- This implementation is a little different than the original version in the training / testing partition, so that the result may vary a little, if you use the default settings and parameters, you are supposed to obtain the rank-1 matching rate for the trial 1 on VIPeR dataset: 25.32% (SDC_knn) and 27.22% (SDC_ocsvm). 


