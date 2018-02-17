close all;

A = imread('polygonellipse.png');
Final = resizeNN(A,3);

imshow(Final);

function ret = resizeNN(Image, X)
    [rows cols depth] = size(Image);
    new_rows = rows * X;
    new_cols = cols * X;
    ret = zeros(new_rows,new_cols,depth);
    for i = 1:rows
        for j = 1:cols
            for k = 1:depth
                ret((i-1)*X+1:i*X,(j-1)*X+1:j*X,k) = Image(i,j,k);
            end
        end
    end
    ret = uint8(ret);
end