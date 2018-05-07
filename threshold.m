function [thresholdValues] = threshold(badtemps, templates)

thresholdTempValues = zeros(1,10);
for i = 1:10
    currentBad = badtemps(:,:,i);
    
    for j = 1:10
        
        
        currentGood = templates(:,:,j);
        diff = 0;
        
        
        for x = 1:26
            for y = 1:26
               diff = diff + abs(currentBad(x,y) - currentGood(x,y))/255; 
                
            end
        end
        thresholdTempValues(1,j) = diff;
        
        
    end

     thresholdValues(1,i) = (thresholdTempValues(1,i));
end
end