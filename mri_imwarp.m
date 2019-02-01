load mri;       % 27 horizontal brain slices                

montage(D,map)  % display images as a montage
title('Horizontal Slices');

% Dimension 1: Front to back of head (rostral/anterior to caudal/posterior)
% Dimension 2: Left to right of head
% Dimension 4: Bottom to top of head (inferior to superior).

%
% Display sagittal slices
%

% Take the 64th column of D as a subset
M1 = D(:,64,:,:); size(M1)
% reshape matrix M1 into a 128-by-27 matrix
M2 = reshape(M1,[128 27]); size(M2) 

%figure, imshow(M2,map);
%title('Sagittal - Raw Data');

% perform a 2D affine transformation to rotate image
% and increase sampling in the vertical dimension
tform = affine2d([0 -2.5; 1 0; 0 0]);

% transform M2 according to the geometric transformation tform
B = imwarp(M2,tform);

%figure, imshow(B,map);
%title('Sagittal - imwarp');

% Display sagittal slices as a montage

% refactor to use affine3d() 
T3 = maketform('affine',[-2.5 0 0; 0 1 0; 0 0 0.5; 68.5 0 -14]);
R3 = makeresampler({'cubic','nearest','nearest'},'fill');

S = tformarray(D,T3,R3,[4 1 2],[1 2 4],[66 128 35],[],0);
S2 = padarray(S,[6 0 0 0],0,'both');

figure, montage(S2,map)
title('Sagittal Slices');

%
% Display coronal slices
%

% Take a row of D as a subset
MC1 = D(66,:,:,:); size(MC1)
% reshape matrix M1 into a 128-by-27 matrix
MC2 = reshape(MC1,[128 27]); size(MC2) 

figure, imshow(MC2,map);
title('Coronal - Raw Data');

% perform a 2D affine transformation to rotate image
% and increase sampling in the vertical dimension
tformC = affine2d([0 -2.5; 1 0; 0 0]);

% transform M2 according to the geometric transformation tform
BC = imwarp(MC2,tformC);

figure, imshow(BC,map);
title('Coronal - imwarp');

% Display coronal slices as a montage

% refactor to use affine3d() 
T4 = maketform('affine',[-2.5 0 0; 0 1 0; 0 0 -0.5; 68.5 0 61]);
C = tformarray(D,T4,R3,[4 2 1],[1 2 4],[66 128 45],[],0);
C2 = padarray(C,[6 0 0 0],0,'both');
figure, montage(C2,map)
title('Coronal Slices');