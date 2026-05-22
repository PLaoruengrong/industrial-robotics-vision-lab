% Split image in R/G/B values and display output
%im= imlocalbrighten(im);
[R,G,B] = imsplit(im);
disp("Split image in R/G/B")
montage({R,G,B},'Size',[1 3])

disp("Adjust brightness in low-light areas")
im_rgbadj = imlocalbrighten(im);
imshowpair(im,im_rgbadj,"montage")

disp("Camera image (RGB adjusted)")
image_rgbadj = imtool(im_rgbadj)
image_rgbadj.Name = "camera image (RGB-adjust)";
close(image_rgbadj) % closes external image window - comment out if you want to keep it open

% Use the adjusted image from now on
im = im_rgbadj;

% Seperate in R/G/B and display
% red
r = R ./(R+G+B); % see help "rdivide, ./"
figure(1); idisp(r,'title',"Grey scale (R)")
% green
g = G ./(R+G+B);
figure(2); idisp(g,'title',"Grey scale (G)")
% blue
b = B ./(R+G+B);
figure(3); idisp(b,'title',"Grey scale (B)")


bl = (R + G + B) / 3; % normalize overall RBG to 0-1 value
figure(8); idisp(bl,'title',"Grey scale")
bl_thresh = bl < 0.15; % vector of bool type if black threshold intensity < 0.15
figure(9); idisp(bl_thresh,'title',"Binary scale (Black)")

% Define treshhold for the colour and display resulting image
% black is 0, white is 1
% red
r_thresh = r>0.5; % see help "gt, >" 
figure(4); idisp(r_thresh,'title',"Binary scale (R)")
% green
g_thresh = g>0.5;
figure(5); idisp(g_thresh,'title',"Binary scale (G)")
% blue
b_thresh = b>0.5;
figure(6); idisp(b_thresh,'title',"Binary scale (B)")