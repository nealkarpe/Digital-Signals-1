close all;

A = imread('polygonellipse.png');
A = rgb2gray(A);
Final = resizeBL(double(A),3);

imshow(uint8(Final));

function ret = resizeBL(Image, X)
    [rows cols depth] = size(Image);
    new_rows = rows * X; new_cols = cols * X;
    ret = zeros(new_rows,new_cols,depth);
    row_array = zeros(1,rows); col_array = zeros(1,cols);
    row_pad = floor((new_rows-rows)/(rows-1)); col_pad = floor((new_cols-cols)/(cols-1));
    row_array(1,1)=1; row_array(1,rows)=new_rows; col_array(1,1)=1; col_array(1,cols)=new_cols;
    for i = 1:rows-2
        row_array(1,i+1) = 1 + i*(row_pad+1);
    end
    for i = 1:cols-2
        col_array(1,i+1) = 1 + i*(col_pad+1);
    end
    for i = 1:rows
        for j = 1:cols
            ret(row_array(1,i),col_array(1,j)) = Image(i,j);
        end
    end
    for i = 1:cols
        colnum = col_array(1,i);
        for j = 1:rows-2
            rownum = row_array(1,j);
            rownumNext = row_array(1,j+1);
            for k = 1:row_pad
                fractionright = k/(row_pad+1);
                fractionleft = 1.0 - fractionright;
                for d = 1:depth
                    ret(rownum+k,colnum,d) = fractionright*Image(j+1,i,d) + fractionleft*Image(j,i,d);
                end
            end
        end
        rownum = row_array(1,rows-1);
        rownumNext = row_array(1,rows);
        space = rownumNext - rownum - 1;
        for k = 1:space
            fractionright = k/(space+1);
            fractionleft = 1.0 - fractionright;
            for d = 1:depth
                ret(rownum+k,colnum,d) = fractionright*Image(rows,i,d) + fractionleft*Image(rows-1,i,d);
            end
        end
    end
    
    for i = 1:new_rows
        for j = 1:cols-2
            colnum = col_array(1,j);
            colnumNext = col_array(1,j+1);
            for k = 1:col_pad
                fractionright = k/(col_pad+1);
                fractionleft = 1.0 - fractionright;
                for d = 1:depth
                    ret(i,colnum+k,d) = fractionright*ret(i,colnumNext,d) + fractionleft*ret(i,colnum,d);
                end
            end
        end
        colnum = col_array(1,cols-1);
        colnumNext = col_array(1,cols);
        space = colnumNext - colnum - 1;
        for k = 1:space
            fractionright = k/(space+1);
            fractionleft = 1.0 - fractionright;
            for d = 1:depth
                ret(i,colnum,d) = fractionright*ret(i,colnumNext,d) + fractionleft*ret(i,colnum,d);
            end
        end
    end
end