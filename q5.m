close all

Filter = [1 1 1 ; 0 0 0 ; -1 -1 -1];

figure
blackwhite = imread('sample_inp.png');
blackwhite_edgeDetect = my_conv(blackwhite,Filter);
imshow(blackwhite_edgeDetect);
title('sample\_inp.png after convolution');

blur = imread('blur.jpg');
test_image(blur,Filter);

lights = imread('lights.jpeg');
test_image(lights,Filter);

plant = imread('plant.jpg');
test_image(plant,Filter);

function test_image(image,filter)
	figure

	subplot(2,2,1);
	horizontal = my_conv(image,filter);
	imshow(horizontal);
	title('Regular Filter');

	subplot(2,2,2);
	vertical = my_conv(image,filter');
	imshow(vertical);
	title('Transpose Filter');

	subplot(2,2,3);
	total = horizontal + vertical;
	imshow(total);
	title('Summation');

	subplot(2,2,4);
	imshow(image);
	title('Original Image');
end


function ret = my_conv(image,filter)
    dim = size(image,3);
    for k = 1:dim
        ret(:,:,k) = my_conv_helper(double(image(:,:,k)),double(filter));
    end
end

function ret = my_conv_helper(image,filter)
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