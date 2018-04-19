function h =labgreen(green,d)
h=[];
allgreenbouy=[];
imgcell = green;
[r,c] = size(imgcell);
for i = 1:c
    imgrgb = cell2mat(imgcell(i));
    img = rgb2lab(imgrgb);
    [p q r ] = size(img);
   
    A=img(1:p,1:q,2);
    A = cast([A],'int16');
%     B=img(1:p,1:q,3);
%     B = cast([B],'int16');
    
    gbouy = A(:,:,1) <= d;
    
    greenbouy = (im2double(imgrgb).*gbouy);
    greenbouy = rgb2lab(greenbouy);
    LL=greenbouy(:,:,1);
    AA=greenbouy(:,:,2);
    BB=greenbouy(:,:,3);
    
    Ll = LL( AA<=d);
    Aa = AA(AA<=d);
    Bb = BB(AA<=d);
  
    
    greeninter =[Ll ,Aa ,Bb];
    allgreenbouy = vertcat(allgreenbouy,greeninter);
    h = allgreenbouy;
    
      
    
end
%plot3(h(:,1),h(:,2),h(:,3),'r.');

end







