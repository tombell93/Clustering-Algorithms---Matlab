clear
load('circles3d.mat')

len = 1;
D = [];
k = 3;
[n,d]=knnsearch(X, X, 'k', k + 1);

W = zeros(100);
DegMat = zeros(100);

%Calculate weighted adjacency matrix W
for idx1=1:100,
    for idx2=1:100,
        index = 0;
        value = 0;
        for i=1:3,
            %If n(idx1, idx2) is in graph
            if((n(idx1, i+1) == idx2)&& (n(idx2, i+1) == idx1))
                index = i+1;
                value = idx2;
            end
        end
        if (value ~= 0)
            %Add weight to both adjacency matrices
            W(idx1, value) = W(idx1, value) + exp(-d(idx1, index)/len);
            W(value, idx1) = W(value, idx1) + exp(-d(idx1, index)/len);
        end
    end
end

%Compute the degree matrix
for m=1:size(W, 1),
    index = m;
    
    %Get ocurrences of each value in matrix
    sumsOfColumns = sum(n==index);
    %Subtract 1 due to index value
    degreeOfVertex = (sum(sumsOfColumns) - 1);
    
    DegMat(m, m) = degreeOfVertex;
end

%Construct corresponding Laplacian matrix L
L = DegMat-W;

%Find eigencalues of the Laplacian L*
lctEv = eig(L);

%Compute eigenvectors
[V, E] = eig(L);

%{
The eigenvectors are 100 long and take 3 non-trivial ones to form the 
new x, y and z. These form the new x, y, and z coordinates. 
Then plot these. 
%}


%Symmetric adjacency matrix
%spy(L);

%whos




