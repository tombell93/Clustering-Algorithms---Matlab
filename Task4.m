clear
load('circles3d.mat')

len = 10;
D = [];
k = 12;
[n,d]=knnsearch(X, X, 'k', k + 1);

W = zeros(100);
DegMat = zeros(100);

%Calculate weighted adjacency matrix W
for idx1=1:100,
    for idx2=1:100,
        index = 0;
        value = 0;
        for i=1:k,
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
    
    %{
    %Get ocurrences of each value in matrix
    sumsOfColumns = sum(n==index);
    %Subtract 1 due to index value
    degreeOfVertex = (sum(sumsOfColumns) - 1);
    %}
    
    degreeOfVertex = sum(n(m,:));
    
    DegMat(m, m) = degreeOfVertex;
end

%Construct corresponding Laplacian matrix L
L = DegMat-W;

%Find eigencalues of the Laplacian L*
lctEv = eig(L);

%Compute eigenvectors
[V, E] = eig(L);

%Find smallest 3 eigenvectors
firstIDX = 0;
firstSize = 100;
secondIDX = 0;
secondSize = 100;
thirdIDX = 0;
thirdSize = 100;

for i=1:100,
    size = 0;
    for j=1:100,
        size = size + V(i, j);
    end
    size = size/100;
    
    if ((size < thirdSize) && (size ~= 0)),
        if(size < secondSize),
           if(size < firstSize),
               firstSize = size;
               firstIDX = i;
           else
               secondSize = size;
               secondIDX = i;
           end
        else
            thirdSize = size;
            thirdIDX = i;
        end
    end
end

%plot3(V(firstIDX,:), V(secondIDX,:), V(thirdIDX,:));
scatter3(V(firstIDX,:), V(secondIDX,:), V(thirdIDX,:));
%scatter3(V(1,:), V(2,:), V(3,:));
%scatter3(V(2,:), V(5,:), V(7,:));

%Plot 3 eigenvectors
xlabel('V[first]')
ylabel('V[second]')
zlabel('V[third]')
grid on
axis square





