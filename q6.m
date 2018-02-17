close all; clear all;

A = imread('Faces.jpg');
B = imread('F1.jpg');

[X Y Rows Cols] = find(A,B);

figure;
subplot(1,3,[1,2]);
imshow(A);
title('Faces.jpg');
subplot(1,3,3);
imshow(B);
title('F1.jpg');

drawRectangle(A,X,Y,Rows,Cols);

function drawRectangle(Image,X,Y,Rows,Cols)
    size(Image)
    color = [255,0,0];
    for i = X:X+Rows
        for k = 1:3
            Image(i,Y,k) = color(k);
            Image(i,Y+Cols,k) = color(k);
        end
    end
    
    for j = Y:Y+Cols
        for k = 1:3
            Image(X,j,k) = color(k);
            Image(X+Rows,j,k) = color(k);
        end
    end

    figure;
    imshow(Image);
    title('Face Detected!');
end

function [ret_x ret_y ret_rows ret_cols] = find(A,B)
% function returns pixel frame of A which is most similar to B
    A = rgb2gray(A);
    B = rgb2gray(B);
    [A_rows A_cols] = size(A);
    [B_rows B_cols] = size(B);
    coefs_rows = A_rows - B_rows + 1;
    coefs_cols = A_cols - B_cols + 1;
    coefs = zeros(coefs_rows, coefs_cols);
    ret = 0;
    for i = 1:coefs_rows
        for j = 1:coefs_cols
            coefs(i,j) = my_corr(A(i:i+B_rows-1,j:j+B_cols-1),B);
        end
    end
    [max_val, max_index] = max(coefs(:));
    [ret_x ret_y] = ind2sub(size(coefs),max_index);
    [ret_rows ret_cols] = size(B);
end

function ret = my_corr(A,B)
    A = A - mean2(A);
    B = B - mean2(B);
    numerator = sum(sum(A.*B));
    denominator = sum(sum(A.*A))*sum(sum(B.*B));
    ret = numerator/sqrt(denominator);
end