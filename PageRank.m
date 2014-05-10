function [p it] = PageRank( G, alpha )
tol = 10^-8;
[num_rows num_cols] = size(G);
R = num_cols;

%Construct Probability matrix P:
P = zeros(length(G));
for col=1:num_cols
    numTimes = 0;
    for row=1:num_cols 
        if G(row, col) == 1
            numTimes = numTimes + 1;
        end
    end
    P_ij = 1 / numTimes;
    for row=1:length(G)
        if G(row, col) == 1
            P(row, col) = P_ij;
        end
    end
end

d = zeros(1, num_cols);
flagged = 1;

%Construct dead matrix d:   
for col=1:num_cols
        elem = P(1, col);
        for row=2:num_rows
            if((P(row, col) == elem) && (elem == 0))
                flagged = flagged + 1;
            end          
        end
        if( flagged == num_rows)
           d(1, col) = 1;
        end
        flagged = 1;
end    


e = ones(R, 1);
p = e / R;
it = 1;
p = (alpha * (P * p + (e * (1/R * (d * p))))) + ((1 - alpha) * (e / R));
last = ones(R, 1) * inf;

while(norm(p - last, inf) > tol)
    it = it + 1;
    last = p;
    p = (alpha * (P * p + (e * (1/R * (d * p))))) + ((1 - alpha) * (e / R));
end

end