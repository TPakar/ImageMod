function [maskimage, textimage, gray] = createcncim(myfile, mystr, fontsize, fontrot, multiprint, letterspacing, wordspacing, rowspacing,...
    threshold, useimadj, imadjlow, imadjhigh, usehisteq, makeframe, circmask)
% Copyright (C) 2020 Tomppa Pakarinen, pakarinentomppa@gmail.com


% This program is free software: you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the  
% Free Software Foundation, either version 3 of the License, or (at your 
% option) any later version.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of 
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General 
% Public License for more details.
% 
% You should have received a copy of the GNU General Public License along 
% with this program. If not, see http://www.gnu.org/licenses/
% mypath = path to the image
% mystr = str to be printed to the image
% fontsize = font size to the printed text
% fontrot = font rotation angle in degrees
% multiprint = boolean: if the text is printed multiple times

I = imread(myfile);


addpath([pwd, '\Lettersprites']);
%%
subplot(2,2,1);
imshow(I);
subplot(2,2,2);
gray = rgb2gray(I);
if useimadj == 1
    gray = imadjust(gray, [imadjlow imadjhigh],[]);
end

if usehisteq == 1
    J = histeq(gray);
else
    J = gray;
end


try
    imshow(J);
    subplot(2,2,3);
    bw = imbinarize(J,threshold);
catch
   imshow(gray);
    subplot(2,2,3);
    bw = imbinarize(gray,threshold); 
end    
imshow(bw);

sizes = size(bw);

[textimage, maskimage] = texttoimage(mystr, sizes, fontsize, fontrot, multiprint, letterspacing, wordspacing, rowspacing, bw, makeframe, circmask);
% varargin{1} = text string: Will be printed to the image
% varargin{2} = Input image size
% varargin{3} = Font size
% varargin{4} = Font rotation
% varargin{5} = boolean: if the text is printed multiple times
% varargin{6} = Spacing between letters. Can be negative
% varargin{7} = Spacing between words
% varargin{8} = Spacing between rows [0:2]
% varargin{9} = Mask image (binary). Sprites will be printed on 0's = black

% generate a text 

subplot(2,2,4);
imshow(maskimage);


