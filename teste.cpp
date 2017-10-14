#include <bits/stdc++.h>
using namespace std;

int binom(int n, int k){

	vector<int> dp(k+1,0);
	dp[0]=1;

	for(int i=1; i<=n; ++i)
		for(int j=min(i,k); j>0; --j)
			dp[j] = dp[j] + dp[j-1];

	return dp[k];
}

int main(){

	for(int i=0; i<=10; ++i)
		cout << binom(2*i,i) << endl;


 return 0;
}
