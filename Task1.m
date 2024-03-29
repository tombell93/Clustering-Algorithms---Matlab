clear
load('circles3d.mat')

len = 1;
%{
plot3(X(:,1), X(:,2), X(:,3), 'o')
xlabel('X[1]')
ylabel('X[2]')
zlabel('X[3]')
grid on
axis square
%}

D = [];
k = 3;
[n,d]=knnsearch(X, X, 'k', k + 1);
W = zeros(100);
d;
DegMat = zeros(100);

%Calculate weighted adjacency matrix W
for idx1=1:100,
    for idx2=1:100,
        index = 0;
        value = 0;
        for i=1:3,
            %If n(idx1, idx2) is in graph
            if(n(idx1, i+1) == idx2)
                index = i+1;
                value = idx2;
            end
        end
        if (value ~= 0)
            W(idx1, value) = ctranspose(exp(-d(idx1, index)/len));
        end
    end
end


%Compute the degree matrix
for m=1:size(W, 1),
    degreeOfVertex = 0;
    index = m;
    
    %Get ocurrences of each value in matrix
    sumsOfColumns = sum(n==index);
    %Subtract 1 due to index value
    degreeOfVertex = (sum(sumsOfColumns) - 1);
    
    DegMat(m, m) = degreeOfVertex;
end

%Construct corresponding Laplacian matrix L
L = DegMat-W;
LCT = ctranspose(L);
W;

%Find eigencalues of the Laplacian L*
lctEv = eig(LCT)

%Non-symmetric adjacency matrix
spy(W)

%whos




