function h =labyellow(red,d)
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
    
    B=img(1:p,1:q,3);
    B = cast([B],'int16');    
    
    ybouy = B(:,:,1) > d;
    
    ybouymain = (im2double(imgrgb).*ybouy);
    ybouymain = rgb2lab(ybouymain);
    
    LL=ybouymain(:,:,1);
    AA=ybouymain(:,:,2);
    BB=ybouymain(:,:,3);
    
    
     Ll = LL( BB>d);
    Aa = AA(BB>d);
    Bb = BB(BB>d);
    
    yellowinter =[Ll,Aa ,Bb];
    allyellowbouy = vertcat(allyellowbouy,yellowinter);
    h = allyellowbouy;  
    
    
    
end
%plot3(h(:,1),h(:,2),h(:,3),'r.');

end







