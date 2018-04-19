function h =yellowexcludepoints(red,d)
h=[];
allyellowbouy=[];
imgcell = red;
[r,c] = size(imgcell);
for i = 1:c    
    imgrgb = cell2mat(imgcell(i));
    %imgrgb = imread('5.jpg');
    img = rgb2lab(imgrgb);
    [p q r ] = size(img);
    %     Taking LAB Values
    A=img(1:p,1:q,2);
    A = cast([A],'int16');
    B=img(1:p,1:q,3);
    B = cast([B],'int16');    
    ybouy = B(:,:,1) > d;
   % ybouy = cast(ybouy,'int16');    
    ybouymain = (im2double(imgrgb).*ybouy);
   % ybouymain = cast(ybouymain,'int16');
    yellowr=ybouymain(:,:,1);
    yellowg=ybouymain(:,:,2);
    yellowb=ybouymain(:,:,3);
    r  =  yellowr(ybouy)*255;
    g  =  yellowg(ybouy)*255;
    b  =  yellowb(ybouy)*255;      
    yellowinter =[r ,g ,b];
    allyellowbouy = vertcat(allyellowbouy,yellowinter);
    h = allyellowbouy;  
    
    %    rbouy = A(:,:,1) > 18;
    %    redbouy = (im2double(imgrgb).*rbouy);
    %
    %    ybouy = B(:,:,1) > 47;
    %    yellowbouy = (im2double(imgrgb).*ybouy);
    
    
    
    
end
%plot3(h(:,1),h(:,2),h(:,3),'r.');

end







