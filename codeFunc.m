function result = codeFunc(I)

[h1 w1 ~] = size(I);
%I2=rgb2gray(I);
%SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
%I3=lbp(I2,SP,0,'i');
%I4 = padarray(I3,[1 1],'replicate');
%result=single(I4);

bwI = im2bw(I,graythresh(I));
 
 
 [B,~]=bwboundaries(bwI,'noholes');
 s1 = size(bwI);
 output1 = zeros(s1(1),s1(2));
 hist1=zeros(8,1);
 se = strel('disk',4);
 
 if numel(B) >=1
    boundary=B{1};
    [cc] = chaincode(boundary);
    hist1(1) = numel(find(cc.code ==0));
    hist1(2) = numel(find(cc.code ==1));
    hist1(3) = numel(find(cc.code ==2));
    hist1(4) = numel(find(cc.code ==3));
    hist1(5) = numel(find(cc.code ==4));
    hist1(6) = numel(find(cc.code ==5));
    hist1(7) = numel(find(cc.code ==6));
    hist1(8) = numel(find(cc.code ==7));
    
    hist1=hist1/numel(cc.code);
    for k = 1:numel(boundary(:,1))
        %output1(boundary(k,1),boundary(k,2))=1;
        output1(boundary(k,1),boundary(k,2))=cc.code(k)*31.875;
    end        
    output1 = imclose(bwI,se);
    result=single(output1);
 else
    result=single(output1);
 end
 

% image = im2double(I);                      % @note: you can of course at this point also convert into another color space, e.g. Lab, YUV or ICOPP
% %image = imconvert(image_orig,'rgb','labm[0.8 1 1]');% weighted color space
% 
% %use_colormap = true;                                % @note: I advise the use of colormaps, because they make it much easier to see the differences than grey scale maps
% 
% algorithms = {'fft','dct'};         % @note: specify the names of the algorithms whose saliency maps you would like to see
% s1=size(I);
% saliency_map_resolution = [s1(1) s1(2)];                  % the target saliency map resolution; the most important parameter for spectral saliency approaches
% smap_smoothing_filter_params = {'gaussian',9,2.5};  % filter parameters for the final saliency map
% cmap_smoothing_filter_params = {};                  % optionally, you can also smooth the conspicuity maps
% cmap_normalization = 1;                             % specify the normalization of the conspicuity map here
% extended_parameters = {};                           % @note: here you can specify advanced algorithm parameters for the selected algorithm, e.g. the quaternion axis
% do_figures = false;                                 % enable/disable spectral_saliency_multichannel's integrated visualizations
% 
% %subplot_grid={1,numel(algorithms)+1};
% 
% %figure('name','saliency maps');
% %subplot(subplot_grid{:},1); imshow(image_orig);
% 
% saliency_map = spectral_saliency_multichannel(image,saliency_map_resolution,algorithms{2},smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
% result=single(mat2gray(saliency_map));
 
end