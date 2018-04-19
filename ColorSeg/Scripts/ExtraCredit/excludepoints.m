function h = excludepoints(red,d)
h=[];
imgcell = red;
[r,c] = size(imgcell);
for i = 1:c
img = cell2mat(imgcell(i));
%img = imread('../CroppedBuoys/y_40.jpg');
[p q r ] = size(img);

% Taking Red Green and Blue values %
RR=img(1:p,1:q,1);
RR = cast([RR],'int16');
GG=img(1:p,1:q,2);
GG = cast([GG],'int16');
BB=img(1:p,1:q,3);

BB = cast([BB],'int16');
rgbval = RR + GG + BB;
r = RR((rgbval+d) >0);
g = GG((rgbval+d) >0);
b = BB((rgbval+d) >0);
inter =[ r ,g ,b]; 
h = vertcat(h,inter);

end
end

