function Y = arrayxor(arr)
    Y = 0;
    for i = 1 : size(arr, 1)
      Y = xor(Y, arr(i)); 
    end
end
