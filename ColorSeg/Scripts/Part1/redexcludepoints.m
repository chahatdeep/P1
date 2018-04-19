function h =redexcludepoints(red,d)
h=[];
allredbouy=[];
imgcell = red;
[r,c] = size(imgcell);
for i = 1:c
    imgrgb = cell2mat(imgcell(i));
    img = rgb2lab(imgrgb);
    [p q r ] = size(img);
    %     Taking LAB Values
    A=img(1:p,1:q,2);
    A = cast([A],'int16');
    B=img(1:p,1:q,3);
    B = cast([B],'int16');
    
    rbouy = A(:,:,1) > d;
    redbouy = (im2double(imgrgb).*rbouy);
    redr=redbouy(:,:,1);
    redg=redbouy(:,:,2);
    redb=redbouy(:,:,3);
    r  =  redr(rbouy)*255;
    g  =  redg(rbouy)*255;
    b  =  redb(rbouy)*255;  
    
    rgbval = (r + b + g)- 120;
    r = r((rgbval >0));
    g = g((rgbval >0));
    b = b((rgbval >0));
    
    redinter =[r ,g ,b];
    allredbouy = vertcat(allredbouy,redinter);
    h = allredbouy;
       
    %    rbouy = A(:,:,1) > 18;
    %    redbouy = (im2double(imgrgb).*rbouy);
    %
    %    ybouy = B(:,:,1) > 47;
    %    yellowbouy = (im2double(imgrgb).*ybouy);
    
    
    
    
end
%plot3(h(:,1),h(:,2),h(:,3),'r.');

end







