function VSMap = SDSP(image,sigmaF,omega0,sigmaD,sigmaC)
% ========================================================================
% SDSP algorithm for salient region detection from a given image.
% Copyright(c) 2013 Lin ZHANG, School of Software Engineering, Tongji
% University
% All Rights Reserved.
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% This is an implementation of the algorithm for calculating the
% SDSP (Saliency Detection by combining Simple Priors).
%
% Please refer to the following paper
%
% Lin Zhang, Zhongyi Gu, and Hongyu Li,"SDSP: a novel saliency detection 
% method by combining simple priors", ICIP, 2013.
% 
%----------------------------------------------------------------------
%
%Input : image: an uint8 RGB image with dynamic range [0, 255] for each
%channel
%        
%Output: VSMap: the visual saliency map extracted by the SDSP algorithm.
%Data range for VSMap is [0, 255]. So, it can be regarded as a common
%gray-scale image.
%        
%-----------------------------------------------------------------------
%convert the image into LAB color space

[oriRows, oriCols, junk] = size(image);
image = double(image);
dsImage(:,:,1) = imresize(image(:,:,1), [256, 256],'bilinear');
dsImage(:,:,2) = imresize(image(:,:,2), [256, 256],'bilinear');
dsImage(:,:,3) = imresize(image(:,:,3), [256, 256],'bilinear');
lab = RGB2Lab(dsImage); 

LChannel = lab(:,:,1);
AChannel = lab(:,:,2);
BChannel = lab(:,:,3);

LFFT = fft2(double(LChannel));
AFFT = fft2(double(AChannel));
BFFT = fft2(double(BChannel));

[rows, cols, junk] = size(dsImage);
LG = logGabor(rows,cols,omega0,sigmaF);
FinalLResult = real(ifft2(LFFT.*LG));
FinalAResult = real(ifft2(AFFT.*LG));
FinalBResult = real(ifft2(BFFT.*LG));

SFMap = sqrt(FinalLResult.^2 + FinalAResult.^2 + FinalBResult.^2);

%the central areas will have a bias towards attention
coordinateMtx = zeros(rows, cols, 2);
coordinateMtx(:,:,1) = repmat((1:1:rows)', 1, cols);
coordinateMtx(:,:,2) = repmat(1:1:cols, rows, 1);

centerY = rows / 2;
centerX = cols / 2;
centerMtx(:,:,1) = ones(rows, cols) * centerY;
centerMtx(:,:,2) = ones(rows, cols) * centerX;
SDMap = exp(-sum((coordinateMtx - centerMtx).^2,3) / sigmaD^2);

%warm colors have a bias towards attention
maxA = max(AChannel(:));
minA = min(AChannel(:));
normalizedA = (AChannel - minA) / (maxA - minA);

maxB = max(BChannel(:));
minB = min(BChannel(:));
normalizedB = (BChannel - minB) / (maxB - minB);

labDistSquare = normalizedA.^2 + normalizedB.^2;
SCMap = 1 - exp(-labDistSquare / (sigmaC^2));
% VSMap = SFMap .* SDMap;
VSMap = SFMap .* SDMap .* SCMap;

VSMap =  imresize(VSMap, [oriRows, oriCols],'bilinear');
VSMap = mat2gray(VSMap);
return;