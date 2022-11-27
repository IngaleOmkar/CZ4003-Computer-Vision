% 2.1 Contrast Stretching 

% 2.1 (a) 
Pc = imread(['/Users/omkaringale/Desktop/Computer Vision/Assignments' ...
    '/images/mrt-train.jpg']);
whos Pc;
P = rgb2gray(Pc);
whos P;

%% 

% 2.1 (b)
imshow(P);

%% 

% 2.1 (c)
min(P(:)), max(P(:))

%% 

% 2.1 (d)
P2(:, :) = imsubtract(P, 13); % r - r_min
P2(:, :) = immultiply(P2, 255/(204-13)); % 255/(r_max-r_min)

min(P2(:)), max(P2(:))

%% 

% 2.1 (e)
imshow(P2);

%% 

% 2.2 Histogram Equalization

% 2.2 (a)
imhist(P, 10);
imhist(P, 256);

%% 

% 2.2 (b)
P3 = histeq(P, 255);
imhist(P3, 10);
imhist(P3, 256);

%% 

% 2.2 (c)
P3 = histeq(P3, 255);
imhist(P3, 10);
imhist(P3, 256);

%% 

% 2.3 Linear Spatial Filtering

x = -2:2;
y = -2:2;
[X, Y] = meshgrid(x, y);

% 2.3 (a)(i)

sigmaA1 = 1.0;
PSF1 = exp(-(X.^2 + Y.^2)/(2 * sigmaA1.^2))/(2 * pi * sigmaA1.^2);
PSF1 = PSF1./sum(PSF1(:));
mesh(PSF1);

%% 

% 2.3 (a)(ii)

sigmaA2 = 2.0;
PSF2 = exp(-(X.^2 + Y.^2)/(2 * sigmaA2.^2))/(2 * pi * sigmaA2.^2);
PSF2 = PSF2./sum(PSF2(:));
mesh(PSF2);

%% 

% 2.3 (b)

P4 = imread(['/Users/omkaringale/Desktop/Computer Vision/Assignments' ...
    '/images/ntugn.jpg']);
imshow(P4);

%% 

% 2.3 (c)

P4_PSF1 = uint8(conv2(P4, PSF1));
imshow(P4_PSF1);

P4_PSF2 = uint8(conv2(P4, PSF2));
imshow(P4_PSF2);

%% 

% 2.3 (d)

P5 = imread(['/Users/omkaringale/Desktop/Computer Vision' ...
    '/Assignments/images/ntusp.jpg']);
imshow(P5);

%% 

% 2.3 (e)

P5_PSF1 = uint8(conv2(P5, PSF1));
imshow(P5_PSF1);

P5_PSF2 = uint8(conv2(P5, PSF2));
imshow(P5_PSF2);

%% 

% 2.4 Median Filtering

P6 = medfilt2(P4, [3, 3]);
imshow(P6);

P7 = medfilt2(P4, [5, 5]);
imshow(P7);

P8 = medfilt2(P5, [3, 3]);
imshow(P8);

P9 = medfilt2(P5, [5, 5]);
imshow(P9);

%% 

% 2.5 Suppressing noise interference pattern 

% 2.5 (a)
P10 = imread(['/Users/omkaringale/Desktop/Computer Vision/Assignments' ...
    '/images/pckint.jpg']);
imshow(P10);

%%

% 2.5 (b)
F = fft2(P10);
S = abs(F);
imagesc(fftshift(S.^0.1));
colormap('default');

%%

% 2.5 (c)
imagesc(S.^0.1);
colormap('default');
[y, x] = ginput(2);
x;
y;

%%

% 2.5 (d)
x1 = x(1);
y1 = y(1);
x2 = x(2);
y2 = y(2);

F(x1-2:x1+2, y1-2:y1+2) = 0; % 5x5 neighbourhood
F(x2-2:x2+2, y2-2:y2+2) = 0;

S = abs(F);
imagesc(fftshift(S.^0.1));
colormap('default');

%%

% 2.5 (e)
P11 = uint8(ifft2(F));
imshow(P11);

%%

% 2.5 (f)
P12 = imread(['/Users/omkaringale/Desktop/Computer Vision/Assignments' ...
    '/images/primatecaged.jpg']);
imshow(P12);

% whos P12: Size                Bytes  Class    

%           256x256x3           196608 uint8

P12 = rgb2gray(P12);
imshow(P12);

F = fft2(P12);    
S = abs(F);
imagesc(S.^0.1);
colormap('default');

y1 = 247; x1 = 6;
y2 = 236; x2 = 10;
y3 = 11; x3 = 252;
y4 = 22; x4 = 248;
y5 = 252; x5 = 253;

F(x1-2:x1+2, y1-2:y1+2) = 0;
F(x2-2:x2+2, y2-2:y2+2) = 0;
F(x3-2:x3+2, y3-2:y3+2) = 0;
F(x4-2:x4+2, y4-2:y4+2) = 0;
F(x5-2:x5+2, y5-2:y5+2) = 0;

S = abs(F);
imagesc(S.^0.1);
colormap('default');

P13 = uint8(ifft2(F));
imshow(P13);

%%

% 2.6 Undoing Perspective Distortion of Planar surface

% 2.6 (a)
P14 = imread(['/Users/omkaringale/Desktop/Computer Vision/' ...
    'Assignments/images/book.jpg']);

imshow(P14);

% 2.6 (b)
[X, Y] = ginput(4);

%%

% 2.6 (c)
% A4 dimension 210mm x 297mm
imageX = [0, 0, 210, 210];
imageY = [0, 297, 297, 0];

A = [
        [X(1), Y(1), 1, 0, 0, 0, -imageX(1)*X(1), -imageX(1)*Y(1)];
	    [0, 0, 0, X(1), Y(1), 1, -imageY(1)*X(1), -imageY(1)*Y(1)];
	    [X(2), Y(2), 1, 0, 0, 0, -imageX(2)*X(2), -imageX(2)*Y(2)];
	    [0, 0, 0, X(2), Y(2), 1, -imageY(2)*X(2), -imageY(2)*Y(2)];
	    [X(3), Y(3), 1, 0, 0, 0, -imageX(3)*X(3), -imageX(3)*Y(3)];
	    [0, 0, 0, X(3), Y(3), 1, -imageY(3)*X(3), -imageY(3)*Y(3)];
	    [X(4), Y(4), 1, 0, 0, 0, -imageX(4)*X(4), -imageX(4)*Y(4)];
	    [0, 0, 0, X(4), Y(4), 1, -imageY(4)*X(4), -imageY(4)*Y(4)];
];

v = [imageX(1); imageY(1); imageX(2); imageY(2); imageX(3); imageY(3); 
    imageX(4); imageY(4)];
	
u = A \ v;

U = reshape([u;1], 3, 3)';

w = U*[X'; Y'; ones(1,4)];

w = w ./ (ones(3,1) * w(3,:));

%%

% 2.6 (d)

T = maketform('projective', U');
P15 = imtransform(P14, T, 'XData', [0 210], 'YData', [0 297]);

imshow(P15);

%%

% 2.6 (f)
imshow(P15);
[X, Y] = ginput(4);
imageX = [0, 50, 50, 0];
imageY = [0, 0, 50, 50];

A = [
        [X(1), Y(1), 1, 0, 0, 0, -imageX(1)*X(1), -imageX(1)*Y(1)];
	    [0, 0, 0, X(1), Y(1), 1, -imageY(1)*X(1), -imageY(1)*Y(1)];
	    [X(2), Y(2), 1, 0, 0, 0, -imageX(2)*X(2), -imageX(2)*Y(2)];
	    [0, 0, 0, X(2), Y(2), 1, -imageY(2)*X(2), -imageY(2)*Y(2)];
	    [X(3), Y(3), 1, 0, 0, 0, -imageX(3)*X(3), -imageX(3)*Y(3)];
	    [0, 0, 0, X(3), Y(3), 1, -imageY(3)*X(3), -imageY(3)*Y(3)];
	    [X(4), Y(4), 1, 0, 0, 0, -imageX(4)*X(4), -imageX(4)*Y(4)];
	    [0, 0, 0, X(4), Y(4), 1, -imageY(4)*X(4), -imageY(4)*Y(4)];
];

v = [imageX(1); imageY(1); imageX(2); imageY(2); imageX(3); imageY(3); 
    imageX(4); imageY(4)];
	
u = A \ v;

U = reshape([u;1], 3, 3)';

w = U*[X'; Y'; ones(1,4)];

w = w ./ (ones(3,1) * w(3,:));

T = maketform('projective', U');
P16 = imtransform(P15, T, 'XData', [0 50], 'YData', [0 50]);

imshow(P16);

P17 = histeq(rgb2gray(P16), 255);
imshow(P17);

P18 = uint8(conv2(P17, PSF1));
imshow(P18);
