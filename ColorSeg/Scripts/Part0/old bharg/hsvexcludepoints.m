function h =hsvexcludepoints(green,d)
h=[];
allgreenbouy=[];
imgcell = green;
[r,c] = size(imgcell);
for i = 1:c
    imgrgb = cell2mat(imgcell(i));
    img = rgb2lab(imgrgb);
    [p q r ] = size(img);
    % Taking Red Green and Blue values %
    
    %     RR=imgrgb(1:p,1:q,1);
    %     RR = cast([RR],'int16');
    %     GG=imgrgb(1:p,1:q,2);
    %     GG = cast([GG],'int16');
    %     BB=imgrgb(1:p,1:q,3);
    %     BB = cast([BB],'int16');
    %     Taking LAB Values
    A=img(1:p,1:q,2);
    A = cast([A],'int16');
    B=img(1:p,1:q,3);
    B = cast([B],'int16');
    
    gbouy = A(:,:,1) <= d;
    greenbouy = (im2double(imgrgb).*gbouy);
    greenr=greenbouy(:,:,1);
    greeng=greenbouy(:,:,2);
    greenb=greenbouy(:,:,3);
    r  =  greenr(gbouy)*255;
    g  =  greeng(gbouy)*255;
    b  =  greenb(gbouy)*255;  
    
    greeninter =[r ,g ,b];
    allgreenbouy = vertcat(allgreenbouy,greeninter);
    h = allgreenbouy;
    
    
    %    rbouy = A(:,:,1) > 18;
    %    redbouy = (im2double(imgrgb).*rbouy);
    %
    %    ybouy = B(:,:,1) > 47;
    %    yellowbouy = (im2double(imgrgb).*ybouy);
    
    
    
    
end
%plot3(h(:,1),h(:,2),h(:,3),'r.');

end







