function outstr = hamEncode(in)
    
    in = fliplr(in);
    in = in';
    
    if(size(in,1) < 12)
        disp("Oops...");
        return;
    end
    
    dec = [0;0;in(1);0;in(2:4);0;in(5:11);0;in(12)];
    
    out = zeros(17,1);
    out(1)  = arrayxor([dec(3) dec(5) dec(7) dec(9) dec(11) dec(13) dec(15) dec(17)]');
    out(2)  = arrayxor([dec(3) dec(6) dec(7) dec(10) dec(11) dec(14) dec(15)]');
    out(4)  = arrayxor([dec(5) dec(6) dec(7) dec(12) dec(13) dec(14) dec(15)]');
    out(8)  = arrayxor([dec(9) dec(10) dec(11) dec(12)]');
    out(16) = arrayxor([dec(17)]');
    
    out = out + dec;
    %out = out';
    out = flipud(out);
    
    outstr = '';
    for i = 1:17
       outstr = append(outstr, sprintf('%d',out(i)));
    end
end
