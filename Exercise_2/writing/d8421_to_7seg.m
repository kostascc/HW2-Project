syms b8 b4 b2 b1;
syms a b c d e f g;

a = ~(...
    ((~b8) & b4 & (~b2) & (~b1) ) |...
    ( b1 & (~b2) & (~b4) & (~b8))  ...
);
a = simplify (a)


b = ~(...
    (b1 & (~b2) & b4 & (~b8)) |...
    ((~b1) & b2 & b4 & (~b8))  ...
);
b = simplify (b)


c = ~