function [thresholdValues] = threshold(badtemps, templates)
%initialize
thresholdTempValues = zeros(1,10);

%loop through bad templates
for i = 1:10
    currentBad = badtemps(:,:,i);
    
    %loop through receiving unit templates
    for j = 1:10
        currentGood = templates(:,:,j);
        diff = 0;
        
        %find difference
        for x = 1:26
            for y = 1:26
               diff = diff + abs(currentBad(x,y) - currentGood(x,y))/255;  
            end
        end
        thresholdTempValues(1,j) = diff;
    end

     %set difference from appropriate receiving unit. 
     %right now this is the 'strict' value
     thresholdValues(1,i) = (thresholdTempValues(1,i));
end
end