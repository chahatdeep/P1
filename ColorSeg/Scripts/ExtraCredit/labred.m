function h =labred(red,d)
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
    
    rbouy = A(:,:,1) > d;
    redbouy = (im2double(imgrgb).*rbouy);
    redbouy = rgb2lab(redbouy);
    
    LL=redbouy(:,:,1);
    AA=redbouy(:,:,2);
    BB=redbouy(:,:,3);
    
    Ll = LL( AA>d);
    Aa = AA(AA>d);
    Bb = BB(AA>d);
  

    
    
    redinter =[Ll ,Aa ,Bb];
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







