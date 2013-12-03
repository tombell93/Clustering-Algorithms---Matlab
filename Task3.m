clear
load('circles3d.mat')

len = 1;
D = [];
k = 3;
[n,d]=knnsearch(X, X, 'k', k + 1);

W1 = zeros(100);
DegMat1 = zeros(100);

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
            W1(idx1, value) = ctranspose(exp(-d(idx1, index)/len));
        end
    end
end

W2 = zeros(100);
DegMat2 = zeros(100);

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
            W2(idx1, value) = W2(idx1, value) + exp(-d(idx1, index)/len);
            W2(value, idx1) = W2(value, idx1) + exp(-d(idx1, index)/len);
        end
    end
end

%Compute the degree matrix
for m=1:size(W1, 1),
    index = m;
    
    %Get ocurrences of each value in matrix
    sumsOfColumns = sum(n==index);
    %Subtract 1 due to index value
    degreeOfVertex = (sum(sumsOfColumns) - 1);
    
    DegMat1(m, m) = degreeOfVertex;
end

%Compute the degree matrix
for m=1:size(W2, 1),
    index = m;
    
    %Get ocurrences of each value in matrix
    sumsOfColumns = sum(n==index);
    %Subtract 1 due to index value
    degreeOfVertex = (sum(sumsOfColumns) - 1);
    
    DegMat2(m, m) = degreeOfVertex;
end

%Construct corresponding Laplacian matrix L1 and L2
L1 = DegMat1-W1;
LCT1 = ctranspose(L1);
L2 = DegMat1-W2;

%Find eigencalues of the Laplacian L*
lctEv1 = eig(LCT1);
lctEv2 = eig(L2);

%Compute eigenvectors
[V1, E] = eig(L1);

%Symmetric adjacency matrix
%spy(LCT1);
%spy(L2);

%whos




