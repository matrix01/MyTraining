//
//  main.cpp
//  topCoder
//
//  Created by Md. Milan Mia on 10/30/15.
//  Copyright (c) 2015 Apple. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>
using namespace std;

class BinaryCode {
public:
    vector <string> decode(string message);
};

vector<string> BinaryCode:: decode(string message){
    vector<string> P;
    if ((message[0] - '0') >= 3) {
        P.push_back("NONE");
        P.push_back("NONE");
        return P;
    }
    string p, q;
    p += '0';
    int len = (int)message.length();
    p += '0' + (message[0]-'0') - (p[0]-'0');
    for(int i=2; i<len; i++){
        int n =((message[i-1]-'0') -((p[i-1]-'0')+(p[i-2]-'0')));
        p += '0' + n;
        if(n>1){
            p = "NONE";
            break;
        }
    }
    int last = (p[len-1] - '0') + (p[len-2] -'0');
    if(last == (message[len-1] - '0')){
        p="NONE";
    }
    P.push_back(p);
    p="";
    p += '1';
    p += '0' + (message[0]-'0') - (p[0]-'0');
    for(int i=2; i<len; i++){
        int n =((message[i-1]-'0') -((p[i-1]-'0')+(p[i-2]-'0')));
        p += '0' + n;
        if(n>1){
            p = "NONE";
            break;
        }
    }
    last = (p[len-1] - '0') + (p[len-2] -'0');
    if(last == (message[len-1] - '0')){
        p="NONE";
    }
    P.push_back(p);
    return P;
}

int main(int argc, const char * argv[]) {
    
    BinaryCode *bc;
    string input;
    while(cin>>input){
        bc->decode(input);
    }
    return 0;
}
