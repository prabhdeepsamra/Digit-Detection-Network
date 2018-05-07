% 
% image = imread('triangle.tif');
% output = zeros(30,30);
% 
% for x = 1:30
%     for y = 1:30
%         if(image(x,y,1)>127)
%         output(x,y) = image(x,y,1);
%         end
%     end
% end
% output = uint8(output);
% imwrite(output,'triangle.tif');



template = zeros(26,26,12);

s1 = '0';
s2 = '_30x30.tif';


for i = 0:9
    s3 = strcat(s1,s2);
    imhold = imread(s3);
    for x =3:28
        for y = 3:28
            template(x-2,y-2,i+1) = imhold(x,y);
        end
    end
   
    s1 = s1+1;
end


s1 = '0';
s2 = '_noise_26x26.tif';

for i = 0:9
    s3 = strcat(s1,s2);
    template(:,:,i+1) = imnoise(template(:,:,i+1),'salt & pepper',.15);
    s1 = s1+1;
    imwrite(template(:,:,i+1), s3);
end


