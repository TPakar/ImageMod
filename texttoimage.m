function [Icomplete, maskedimage] = texttoimage(varargin)

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


%% This function will return text image, which is filled with string with chosen text size



%%
% varargin{1} = text string: Will be printed to the image [char array]
% varargin{2} = Input image size [row, column]
% varargin{3} = Font size [0:inf]
% varargin{4} = Font rotation [in degrees]
% varargin{5} = boolean: if the text is printed multiple times [0 or 1]
% varargin{6} = Spacing between letters [def 5]
% varargin{7} = Spacing between words [def 0.3]
% varargin{8} = Mask image (binary). Sprites will be printed on 0's = black
% varargin{10} = Create frame for the final image (boolean)

% varargout{1} = image filled with text
% varargout{2} = masked text image
%%

path = [pwd, '\Lettersprites'];
mydir = dir(path);

%%
try
        txt = varargin{1};
        imagesize = varargin{2};
        font = varargin{3}; 
        rotangle = varargin{4};
        multiple = varargin{5};
        additionalspacing = round(varargin{6});
        spacebar = varargin{7};
        rowspace = varargin{8};
        createframe = varargin{10};
        cropcircle = varargin{11};
    try
        mask = varargin{9};
    catch
        disp('no mask image');

    end
catch
   disp('error'); 
end

%% Collect right sprites from text
txtsprites = struct;

for i = 1:length(mydir)
  if contains(txt,mydir(i).name(1))
         tempname = mydir(i).name(1);
         if tempname == 'ä'
             tempname = 'a1';
         elseif tempname == 'Ä'
             tempname = 'A1';
         elseif tempname == 'ö'
             tempname = 'o1';
         elseif tempname == 'Ö'
             tempname = 'O1';
         elseif tempname == 'Å'
         tempname = 'A2';
         elseif tempname == 'å'
         tempname = 'a2';
         elseif tempname == '_'
            tempname = 'a3';
         end
         tempim = imread(mydir(i).name);
         txtsprites.(tempname) = im2bw(tempim);
  end
end


%% Print sprites to the image

nams = fieldnames(txtsprites);
sy = zeros(1,length(txtsprites));
sx = zeros(1,length(txtsprites));

% find the largest height and width
for i = 1:length(nams)
    [sy(i), sx(i)] = size(txtsprites.(nams{i}));
end

maxheight = round(max(sy)*0.5) + round(max(sy)*rowspace);
maxwidth = max(sx) + additionalspacing;
spacebar = maxwidth*spacebar;

%% crop all images to same size
minh = maxheight;

for i = 1:length(nams)
    I = txtsprites.(nams{i});
    % center the image
    [X, Y, ~] = find(imcomplement(I));
    tempminx = min(X);
    tempminy = min(Y);
    tempmaxx = max(X);
    tempmaxy = max(Y);
    % Crop edges
    croppedimages.(nams{i}) = imcrop(I, [tempminy tempminx tempmaxy-tempminy tempmaxx-tempminx]);
    [tminh, ~] = size(croppedimages.(nams{i}));
    if tminh < minh
        minh = tminh;
    end
end

%%
exeptupper = {'A1','O1','A2'};
exeptlowerlow = {'j','g','q','p','y'};
exeptlowerhigh = {'k','t','h','i','a1','o1','a2','d','l', 'f'};
exeptlower = {'a1', 'a2', 'o1'};


for i = 1:length(nams)
    shift = 0;
    I = croppedimages.(nams{i});
    [theight, ~] = size(I);
    % Resize upper case letters to same size (exceptions �, � and �):
    % relative resizing
    if find(isstrprop(nams{i},'upper'))
        % Exeption letters
        if contains(nams{i}, exeptupper)
            I2 = imresize(I, round(minh/theight)*0.85);
            shift = 0.45;
        else
            I2 = imresize(I, (minh/theight));
            shift = 0.7;
        end
    elseif isstrprop(nams{i},'lower') & contains(nams{i}, exeptlowerlow)
        if nams{i} == 'j'
            I2 = imresize(I, (minh/theight)/1);
        else
            I2 = imresize(I, (minh/theight)/1.1);
        end
        shift = 1;
    elseif isstrprop(nams{i},'lower') & contains(nams{i}, exeptlowerhigh)
        I2 = imresize(I, (minh/theight)/1.1);
        shift = 1/1.4;
    elseif contains(nams{i}, exeptlower) 
        I2 = imresize(I, (minh/theight)/1.2);
        shift = 1/1.45;
    elseif isstrprop(nams{i},'lower')
        I2 = imresize(I, (minh/theight)/1.4);
        shift = 1/1.3;
    else
        I2 = I;
    end
    
    % Add edges according to the largest sprite heights and the spacing (combination)
    [row,col] = size(I2);
    
    % Extension    

    I3 = [I2,ones(row,additionalspacing*2)];
    I4 = [I3;ones((maxheight-row), col+additionalspacing*2)];   
    %disp([row, maxheight, maxheight-row, size(I4)])
    % Centered image
    Icentered.(nams{i}) = circshift(I4, [round((maxheight-row)*shift), additionalspacing]);
end
%% Create an text image

Iappend = [];

for i = 1:length(txt)
     if find(contains(nams, txt(i)))
        Iappend = [Iappend, Icentered.(txt(i))];
     elseif txt(i) == 'ä'
         Iappend = [Iappend, Icentered.a1];
     elseif txt(i) == 'Ä'
         Iappend = [Iappend, Icentered.A1];
     elseif txt(i) == 'ö'
         Iappend = [Iappend, Icentered.o1];
     elseif txt(i) == 'Ö'
         Iappend = [Iappend, Icentered.O1];
     elseif txt(i) == ' '
         [Iheight, ~] = size(Iappend);
         Iappend = [Iappend, ones(Iheight, round(spacebar))];
    end
end


Iappend = im2bw(imresize(Iappend,font));

%% Fill  up an empty image with the text and rotate
if multiple == 1
    origimagesize = imagesize;
    if rotangle ~= 0
       imagesize(1) = ceil(sqrt(origimagesize(1)^2 + origimagesize(2)^2));
       imagesize(2) = ceil(tan(rotangle)*imagesize(1));
    else
       imagesize(1) = origimagesize(1);
       imagesize(2) = origimagesize(2);
    end


    emptyim = ones(imagesize(1), imagesize(2));
    ratios = size(emptyim)./size(Iappend);
    [happend, ~] = size(Iappend);

    Icompletecol = [];
    currentrow = 1;
    
    %Columnwise
    for j = 1:ratios(2) + 1
        if j~=1
            Icompletecol = [Icompletecol,ones(happend,round(spacebar*font))];
        end

    % Add text until end of the columns
        Icompletecol = [Icompletecol,Iappend]; 
    end

    Icomplete = [];
    % rowwise
    for j = 1:ratios(1) + 1
    % Add text until end of the columns
        Icomplete = [Icomplete;Icompletecol]; 
    end

    % Rotate the image
    if rotangle ~= 1
       Icomplete = imrotate(Icomplete,rotangle); 
    end

    % Resize the rotated image
    [Y, X] = size(Icomplete);
    Icomplete = imcrop(Icomplete, [round(X/2-origimagesize(2)/2) round(Y/2-origimagesize(1)/2) origimagesize(2) origimagesize(1)]);
 
end


%%  Use mask image

[Y,X] = size(mask);

% windowSize = 6; % Whatever odd integer you want that's more than 1.
% kernel = ones(5)/windowSize^2;
% blurredImage = conv2(Icomplete, kernel, 'same');
% Icomplete = blurredImage > 0.5;

if ~isempty(varargin{8})
    try
       maskedimage = imcomplement(mask).*Icomplete;
    catch
       Icomplete = imresize(Icomplete,[Y,X]); 
       maskedimage = imcomplement(mask).*Icomplete;
    end
end

maskedimage = mask + maskedimage;


% Create squares around the image (For milling/laser)
if createframe == 1
    maskedimage = [maskedimage,ones(Y,30)];
    maskedimage = [maskedimage;ones(30,X+30)];

    maskedimage = circshift(maskedimage, [15,15]);
    [Y,X] = size(maskedimage);
    maskedimage(2:Y-2, 2:8) = 0;
    maskedimage(Y-8:Y-2, 2:X-2) = 0;
    maskedimage(2:Y-2, X-8:X-2) = 0;
    maskedimage(2:8, 2:X-2) = 0;
end

% Circular mask

if cropcircle == 1
    [columnsInImage, rowsInImage] = meshgrid(1:X, 1:Y);
    centerX = floor(X/2);
    centerY = floor(Y/2);
    radius = min(centerY,centerX);
    % Create 2D circular mask
    circlePixels = uint8((rowsInImage - centerY).^2 ...
        + (columnsInImage - centerX).^2 <= radius.^2);
    % Mask the image
    maskedimage = uint8(maskedimage) |~circlePixels;
end




