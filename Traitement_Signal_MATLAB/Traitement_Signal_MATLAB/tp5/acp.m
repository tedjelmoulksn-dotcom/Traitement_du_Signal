X=dlmread('commune.txt');
[n p] = size(X);
Y = X(:,p);
p = p - 1;
X = X(:,1:p);
mu = mean(X);
st = std(X);
v1 = ones(n,1);
Xcr = (X - mu(v1,:))./st(v1,:);
%%acp normee
[V lambda] = eig(corrcoef(X));
Xacp = Xcr * V(:,diag(lambda) >= 1);
[n k] = size(Xacp);
figure
for i = 1:k
        for j = 1:k
                subplot(k,k,(i-1)*k+j);
                hold on;
                plot(Xacp(Y == 1,i),Xacp(Y == 1,j),'o');
                plot(Xacp(Y == 2,i),Xacp(Y == 2,j),'dk');
                plot(Xacp(Y == 3,i),Xacp(Y == 3,j),'+r');
                grid;
        end
end