
% Find Peak Funciton to calculate the polynomial fit for selected peak
function [peak, amp] = findPeak(x,y,n)
% Find Peak interpolates around index n
    if n > 1 && n < length(x)-1
        p = polyfit(x(n - 1: n + 1), y(n - 1: n + 1), 2);
        peak = -p(2)/2/p(1);
        amp = polyval(p,peak);

    else
        peak = n;
        amp = y(n);

    end

end
