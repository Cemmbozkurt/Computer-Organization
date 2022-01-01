#include<iostream>
using namespace std;
#define MAX_SIZE 20
int CheckSumPossibility(int num, int arr[], int size)
{
	int a,b;
	if (num == 0)
        return true;
    if (size == 0)
        return false;
		
	if (arr[size - 1] > num)
      return CheckSumPossibility(num, arr, size-1);
       
    else {	
	 	a = CheckSumPossibility(num, arr, size-1); 
	 	b = CheckSumPossibility(num-arr[size-1],arr, size -1);
	    return a||b;
	}	
}

int main( )
{
 int arraySize;
 int arr[MAX_SIZE];
 int num = 129;
 int returnVal;
 
cout<< "enter array size: "; 
cin >> arraySize;
cout<<"enter Sum number: ";
cin >> num;
 for(int i = 0; i < arraySize; ++i)
 {
 cout<<"Enter array member: ";
 cin >> arr[i];
 }
 
 
 returnVal = CheckSumPossibility(num, arr, arraySize);

 if(returnVal == 1)
 {
 cout << "Possible!" << endl;
 }
 else
 {
 cout << "Not possible!" << endl;
 }

 return 0;
}
