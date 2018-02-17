close all

A = imread('cameraman.tif');
M = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
B = my_conv(double(A), double(M));
C = my_conv(double(A), double(M'));

subplot(2,2,[3 4]);
imshow(A);
title('Original Image');

subplot(2,2,1);
imshow(B);
title('Convolved with M');

subplot(2,2,2);
imshow(C);
title('Convolved with M^T');

function ret = my_conv(image,filter)
    padded_image = padarray(image, [1 1]);
    flipped_filter = rot90(filter,2);
    [x y] = size(padded_image);
    ret = zeros(x-2,y-2);
    for i = 2:(x-1)
        for j = 2:(y-1)
            ret(i-1,j-1) = sum(sum(padded_image(i-1:i+1,j-1:j+1) .* flipped_filter));
        end
    end
end