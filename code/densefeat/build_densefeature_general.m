%
% build the dense feature for further processing
% INPUT
%   data and parameter options
%
% OUTPUT
%   see input directorys
%   dense features in feat_dir e.g., feat1.mat densefeat[dim][ny*nx]
%
% Created by Rui Zhao, on May 20, 2013. 
% This code is release under BSD license, 
% any problem please contact Rui Zhao rzhao@ee.cuhk.edu.hk
%
% Please cite as
% Rui Zhao, Wanli Ouyang, and Xiaogang Wang. Unsupervised Salience Learning
% for Person Re-identification. In IEEE Conference of Computer Vision and
% Pattern Recognition (CVPR), 2013. 
%

index = 1:length(files);

for i = 1:length(index)
    data{i} = imread([dnorm_dir, files(index(i)).name]);
end

% common options for extracting dense color sift feature
clear options1;
options1.gridspacing                = gridstep;
options1.patchsize                  = patchsize;
options1.scale                        = [0.5 , 0.75 , 1];
options1.nbins                        = 32;
options1.sigma                       = 0.6;
options1.clamp                       = 0.2;
% common options for dense SIFT features
clear options2;
options2.gridspacing                        = gridstep;
options2.patchsize                           = patchsize;
options2.color                                 = 3;
options2.nori                                  = 8;
options2.alpha                                 = 9;
options2.nbins                                 = 4;
options2.norm                                  = 4;
options2.clamp                                 = 0.2;
options2.sigma_edge                            = 1.2;
[options2.kernely , options2.kernelx]          = gen_dgauss(options2.sigma_edge);

% common options for dense texture feature (added by Wei Dai)
clear options3;
options3.gridspacing                       = gridstep;
options3.patchsize                         = patchsize;
options3.color                             = 3;
options3.clamp                             = 0.2;

dim = options1.nbins*3*3 + 128*3 + 160 *3;
% featset = zeros(options1.nbins*3*3 + 128*3, nx, ttsize);
batchsize = 8;
densefeat_bat = zeros(dim, ny*nx, batchsize);

% matlabpool;
% extracting dense feature ...
tlen = length(index);
hwait = waitbar(0, 'Extracting features ...');
for s = 1:floor(tlen/batchsize)
    start = 0 + (s-1)*batchsize;
%     for i = 1:batchsize
    parfor i = 1:batchsize
        fprintf('computing dense feature for %d-th image ...\n', start+i);
        densefeat_bat(:, :, i) = get_densefeature(data{start+i}, options1, options2, options3, ny*nx);
    end
    for i = 1:batchsize
        densefeat = densefeat_bat(:, :, i);
        save([feat_dir, 'feat', num2str(index(start+i)), '.mat'], 'densefeat', 'ny', 'nx');
    end
    waitbar(start/tlen, hwait);
end

start = s*batchsize;
res = tlen - start;
densefeat_bat = zeros(options1.nbins*3*3 + 128*3, ny*nx, res);
parfor i = 1:res
    fprintf('computing dense feature for %d-th image ...\n', start+i);
    densefeat_bat(:, :, i) = get_densefeature(data{start+i}, options1, options2, ny*nx);
end
for i = 1:res
    densefeat = densefeat_bat(:, :, i);
    save([feat_dir, 'feat', num2str(index(start+i)), '.mat'], 'densefeat', 'ny', 'nx');
    waitbar((start+i)/tlen, hwait);
end
% matlabpool close;
close(hwait);
clear densefeat_bat;
clear data;

