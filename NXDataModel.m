//
//  NXDataModel.m
//  board-mobile
//
//  Created by KIMJOOHWEE on 2013. 12. 4..
//  Copyright (c) 2013년 KIMJOOHWEE. All rights reserved.
//

#import "NXDataModel.h"
#import "LoginViewControlloer.h"

@implementation NXDataModel{
    //NSArray* _itemArray; // 선언
    NSDictionary* _itemDictionary;
    NSMutableDictionary* _loginData;
    NSDictionary* _itemArray;
    NSMutableData* _responseData;
    NSString* _Writer;
}

-(id)init{
    // 항상 아래의 패턴으로 생성자 만들어줌
    self = [super init];
    if (self){
        //_itemArray = @[@"apple", @"orange",@"pear"];
        //_itemDictionary = @{@"name": @"my name is kjhwee", @"age" : @4, @"female" : @YES, @"array" : _itemArray};
        /*
        _itemArray = [@[
                        @{@"text":@"첫번째", @"image":@"1.png"},
                        @{@"text":@"두번째", @"image":@"2.png"},
                        @{@"text":@"세번째", @"image":@"3.png"},
                        ] mutableCopy];
                        
        _loginData = [[NSMutableDictionary alloc] initWithCapacity:2];
        */
        
        _responseData = [[NSMutableData alloc] initWithCapacity:10];
        NSString *aURLString = @"http://localhost:8080/board/list.json";
        NSURL *aURL = [NSURL URLWithString:aURLString];
        NSURLRequest *aRequest = [NSMutableURLRequest requestWithURL:aURL];
        NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:aRequest delegate:self startImmediately:YES];
    }
    return self;
}

-(void)saveId:(NSString*)userId withPassword:(NSString*)password{
        [_loginData setObject:userId forKey:@"userId"];
        [_loginData setObject:password forKey:@"password"];
}



-(BOOL)authenticateID:(NSString*)userid
         withPassword:(NSString*)password{
    //NSURLRequest 만들기
    NSString *aURLString = @"http://localhost:8080/login/result";
    //NSString *aFormData = @"id=kjh&passwd=ios"; // ios, ios 일 경우 정상
    NSString *aFormData = [NSString stringWithFormat:@"strId=%@&password=%@",userid,password];
    
    NSURL *aURL = [NSURL URLWithString:aURLString];
    NSMutableURLRequest *aRequest =
    [NSMutableURLRequest requestWithURL:aURL];
    [aRequest setHTTPMethod:@"POST"];
    [aRequest setHTTPBody:[aFormData dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSURLConnection 으로 Request 전송
    NSHTTPURLResponse *aResponse;
    NSError *aError;
    NSData *aResultData = [NSURLConnection
                           sendSynchronousRequest:aRequest
                           returningResponse:&aResponse error:&aError];
    
    //Response 응답 데이터를 JSON 파싱해서 NSArray로 변환
    NSDictionary *dataArray = [NSJSONSerialization
                          JSONObjectWithData:aResultData
                          options:NSJSONReadingMutableContainers
                          error:nil];
    NSLog(@"login response = %d", aResponse.statusCode);
    NSLog(@"login result = %@", dataArray );
    
    if([dataArray[@"code"] isEqualToNumber:@404]){
        return NO;
    }
    else{
        return YES;
    }
}

-(NSString*)description // 원래 있는 메소드!
{
    //NSString *result = [NSString stringWithFormat : @"array=%@, dict=%@", _itemArray,_itemDictionary];
    return _itemDictionary.description;
}

-(NSDictionary*)objectAtIndex:(NSUInteger)index{
    return _itemArray[@"boards"][index];
}

-(NSUInteger)ArrayLengthCount{
    NSInteger len = ((NSArray*)_itemArray[@"boards"]).count;
    NSLog(@"array length = %ld", (long)len);
    return len;
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data
{
    [_responseData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    _itemArray = [NSJSONSerialization
                            JSONObjectWithData:_responseData
                            options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"result json = %@", _itemArray);
    [_aController.tableView reloadData];
}

// 새 글 올리기
-(void)newPostTitle:(NSString*)title withContent:(NSString*)content withImage:(UIImage*)image withImageTitle:(NSString*)imagetitle{
    
    NSLog(@"first");
    
    NSString *submitURLString = @"http://localhost:8080/board";
    NSURL *submitURL = [NSURL URLWithString:submitURLString];
    NSMutableURLRequest *submitRequest = [NSMutableURLRequest requestWithURL:submitURL];
    [submitRequest setHTTPMethod:@"POST"]; // default는 GET
    
    NSString *boundary = @"------kjfakldsjfklwejqkldfsdafsadrwe------";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [submitRequest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"title\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", title] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"contents\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postBody appendData:[[NSString stringWithFormat:@"%@\r\n", content] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    if(imgData){
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", imagetitle] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"Content-Type: image/jpg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:imgData];
        [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [submitRequest setHTTPBody:postBody];

    NSHTTPURLResponse *submitResponse;
    NSError *submitError;
    NSData *submitResult = [NSURLConnection sendSynchronousRequest:submitRequest returningResponse:&submitResponse error:&submitError];
    NSLog(@"submit response = %d", submitResponse.statusCode); //통신 성공여부

}




@end


/*
json 형태
 2013-12-18 11:20:34.005 board-mobile[11130:70b] result json =
 {   
    boards =
    (
        {
        comments =(
            {
            content = "\Uccab\Ubc88\Uc9f8\Uae00\Uc758 \Uccab\Ubc88\Uc7ac \Ub313\Uae00";
            id = 1;
            writer = "<null>";
            }
        );
        contents = "\Uc548\Ub155!bb";
        filename = "";
        id = 1;
        title = "\Uccab\Ubc88\Uc9f8 \Uae00";
        writer = id;
        },
 
        {
        comments =(
            {
            content = "\Ubb38";
            id = 2;
            writer = "<null>";
            }
        );
        contents = ">.\U3147n\U314b\U314b\U314b\Uc62c?";
        filename = "4.png";
        id = 2;
        title = "\Ub450\Ubc88\Uc9f8";
        writer = id;
        }
    );
 }
*/


/*
 board의 json형태
 {"board":
    {
        "id":3,
        "writer":"kjhwee91",
        "title":"사진없는거",
        "contents":"사진 노노해a",
        "comments":
            [
                {"id":4,"writer":null,"content":"dddd"},
                {"id":5,"writer":null,"content":"aaaa"}
            ],
        "filename":""
    }
}
 */




