
s2 = '9_30x30.tif';


this = zeros(30,30);

template = imread(s2);

for i = 1:30
    for j = 1:30
        this(i,j) = template(i,j,1);
    end
end
imwrite(this, s2);