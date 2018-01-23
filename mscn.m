function  [mscn,miu,sub,sigma] = mscn(img,window)
%====================================================================
% 求图像的MSCN值
% Input : (1) an double gray image
%         (2) a filter window
% Output : 
%         (1) the mscn map of the image
%         (2) the miu map of the image
%         (3) the sub map of the image
%         (4) the sigma map of the image
% 参考文献：Mittal, A., Moorthy, A. K., & Bovik, A. C. (2012). 
%          No-reference image quality assessment in the spatial domain. 
%          IEEE Transactions on Image Processing, 21(12), 4695-4708.
%====================================================================

if(nargin<1 || nargin>2)
    mscn = -Inf;
    miu = -Inf;
    sub = -Inf;
    sigma = -Inf;
    return;
end

if(nargin==1)
    window = fspecial('Gaussian',7, 7/6);   % 7是窗口大小，7/6是方差
    window = window/sum(sum(window));
end

miu = filter2(window,img,'same');
sub = img - miu;
miu_sq = miu .* miu;
sigma = sqrt(abs(filter2(window, img.*img, 'same') - miu_sq));
mscn = sub ./ (sigma+1);