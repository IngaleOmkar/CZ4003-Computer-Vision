% 3.1 Edge Detection 

% 3.1 (a) Download macritchie.jpg 

P = imread("/Users/omkaringale/Desktop/Computer Vision/Assignments/" + ...
    "Lab2 Edges, Hough Lines, and Disparity/macritchie.jpg");
P = rgb2gray(P);
imshow(P);

%%

% 3.1 (b) Sobel Masks

sobel_1 = [-1 0 1;
           -2 0 2;
           -1 0 1];

sobel_2 = [-1 -2 -1;
            0  0  0;
            1  2  1];

P_sobel1 = conv2(P, sobel_1);
imshow(uint8(P_sobel1));

P_sobel2 = conv2(P, sobel_2);
imshow(uint8(P_sobel2));

%%

% 3.1 (c) Combined Image through squaring 

P_sobel1 = conv2(P, sobel_1);
P_sobel2 = conv2(P, sobel_2);
P2 = P_sobel1.^2 + P_sobel2.^2;
imshow(uint8(P2));

%%

% 3.1 (d) Threshold at value t

% t = 10000
P2_t10k = P2>10000;
imshow(P2_t10k);
%%
% t = 20000
P2_t20k = P2>20000;
imshow(P2_t20k);
%%
% t = 40000
P2_t40k = P2>40000;
imshow(P2_t40k);
%%
% t = 80000
P2_t80k = P2>80000;
imshow(P2_t80k);
%%
% t = 100000
P2_t100k = P2>100000;
imshow(P2_t100k);

%%

% 3.1 (e) Canny Edge Detection

tl=0.04;
th=0.1;
sigma=1.0;

E = edge(P,'canny' ,[tl th],sigma);
imshow(E);

%%

% 3.1 (e)(i) 

sigmas = [1.0, 2.0, 3.0, 4.0, 5.0];

ES1 = edge(P,'canny' ,[tl th],sigmas(1));
imshow(ES1);
%%
ES2 = edge(P,'canny' ,[tl th],sigmas(2));
imshow(ES2);
%%
ES3 = edge(P,'canny' ,[tl th],sigmas(3));
imshow(ES3);
%%
ES4 = edge(P,'canny' ,[tl th],sigmas(4));
imshow(ES4);
%%
ES5 = edge(P,'canny' ,[tl th],sigmas(5));
imshow(ES5);

%%

% 3.1 (e)(ii)

tls = [0.01, 0.02, 0.03, 0.04, 0.05];

ETL1 = edge(P,'canny' ,[tls(1) th], sigma);
imshow(ETL1);
%%
ETL2 = edge(P,'canny' ,[tls(2) th], sigma);
imshow(ETL2);
%%
ETL3 = edge(P,'canny' ,[tls(3) th], sigma);
imshow(ETL3);
%%
ETL4 = edge(P,'canny' ,[tls(4) th], sigma);
imshow(ETL4);
%%
ETL5 = edge(P,'canny' ,[tls(5) th], sigma);
imshow(ETL5);

%%

% 3.2 Line Finding using Hough Transform

% 3.2 (a) 

tl=0.04; th=0.1; sigma=1.0;

E = edge(P,'canny' ,[tl th],sigma);
imshow(E);

%%

% 3.2 (b) 

[H, xp] = radon(E);
imshow(uint8(H));

%%

% 3.2 (c)

[H, xp] = radon(E);
imagesc(uint8(H));
colormap('default');

%%

% 3.2 (d) 

theta = 104;
radius = xp(157);
[A, B] = pol2cart(theta*pi/180, radius);
B = -B;

%%
C = A * (A + 179) + B * (B + 145);

%%

% 3.2 (e)
xl = 0; xr = 357;
yl = (C - A * xl)/B;
yr = (C - A * xr)/B;

%%

% 3.2 (f)
imshow(P);
line([xl xr], [yl yr]);

%%

% 3.3 3D Stereo

% 3.3 (b)

corridor_l = imread("/Users/omkaringale/Desktop/Computer Vision/" + ...
    "Assignments/Lab2 Edges, Hough Lines, and Disparity/corridorl.jpg");
corridor_l = rgb2gray(corridor_l);
imshow(corridor_l);

corridor_r = imread("/Users/omkaringale/Desktop/Computer Vision/" + ...
    "Assignments/Lab2 Edges, Hough Lines, and Disparity/corridorr.jpg");
corridor_r = rgb2gray(corridor_r);
imshow(corridor_r);

%%

% 3.3 (c)

D = map(corridor_l, corridor_r);
imshow(-D,[-15 15]);

%%

% 3.3 (d) 

triclopsi2_l = imread("/Users/omkaringale/Desktop/Computer Vision/" + ...
    "Assignments/Lab2 Edges, Hough Lines, and Disparity/triclopsi2l.jpg");
triclopsi2_l = rgb2gray(triclopsi2_l);
imshow(triclopsi2_l);

triclopsi2_r = imread("/Users/omkaringale/Desktop/Computer Vision/" + ...
    "Assignments/Lab2 Edges, Hough Lines, and Disparity/triclopsi2r.jpg");
triclopsi2_r = rgb2gray(triclopsi2_r);
imshow(triclopsi2_r);
%%
D2 = map(triclopsi2_l, triclopsi2_r);
imshow(-D2,[-15 15]);