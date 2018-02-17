close all

input = [12, 20, 3, 10, 22, 19, 23, 16, 0, 21, 23, 16, 18];
output = [75, 52, 33, 97, 251, 211, 63, 65];
filter = findFilter(input,output);

% Test filter obtained
conv(input,filter,'valid') == output

function ret = findFilter(Inp,Out)
    ret_size = size(Inp,2) - size(Out,2) + 1;
    A = zeros(ret_size,ret_size);
    B = zeros(ret_size,1);
    for i = 1:ret_size
        A(i,:) = Inp(i:i+ret_size-1);
        B(i) = Out(i);
    end
    
    ret = round((flipud(linsolve(A,B))'), 0);
end