function [ texture_arr, grid_x, grid_y ] = sp_dense_texture( I, options )
%DENSE_TEXTURE 
%   extract the the texture features from the image.
%   Created by Wei Dai

grid_spacing = options.gridspacing;
patch_size = options.patchsize;
[hgt, wid, dimcolor] = size(I);
Nx = length(patch_size/2:grid_spacing:wid-patch_size/2);
Ny = length(patch_size/2:grid_spacing:hgt-patch_size/2);
grid_x = ceil(linspace(patch_size/2, wid-patch_size/2, Nx));
grid_y = ceil(linspace(patch_size/2, hgt-patch_size/2, Ny));
epsi = 1e-8;

clamp = options.clamp;

texture_arr = zeros(160, Nx*Ny, dimcolor);

for v = 1:dimcolor
    X = repmat(grid_x, Ny, 1);
    Y = repmat(grid_y', 1, Nx);
    grid = [X(:), Y(:)];
    halfpatch = (patch_size-1)/2;
    I_filtered = I(:, :, v);
    parfor i = 1:Nx*Ny
        Ipatch = imcrop(I_filtered, [grid(i, :)-halfpatch+1, patch_size-1, patch_size-1]);
        [iph, ipw, a] = size(Ipatch);
        if iph ~= 10 || ipw ~= 10
            Ipatch = imresize(Ipatch, [10, 10]);
        end
        gaborArray = gaborFilterBank(5,8,39,39);
        featVec = gaborFeatures(Ipatch,gaborArray,5,5);
        norm_tmp = featVec/sqrt(sum(featVec.^2)+epsi^2);
        norm_tmp(norm_tmp >= clamp) = clamp;
        norm_tmp = norm_tmp/sqrt(sum(norm_tmp.^2)+epsi^2);
        
        texture_arr(:, i, v) = norm_tmp;
    end
    
end

[grid_x,grid_y] = meshgrid(grid_x, grid_y);

end

