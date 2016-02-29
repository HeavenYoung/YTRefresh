# YTRefresh
A refreshing tool with the support as a UIScrollView category 

- Use Block & Runtime

# How To Use
Please import the HeadFile firstly

``` objective-c
#import "Refresh.h"
```

## RefreshHeader
### Use Block 
``` objective-c
self.tableView.header = [RefreshStateNormalHeader headerWithRefreshingBlock:^{
      do something ...
    }];
```
if you want to do some configuration for the heard  
``` objective-c
    RefreshStateNormalHeader  *header = [RefreshStateNormalHeader headerWithRefreshingBlock:^{
      do something ...
    }];
    
    configure the header 
    
    self.tableView.header = header;
```

### Use SEL
``` objective-c
    RefreshStateNormalHeader *header = [RefreshStateNormalHeader headerWithRefreshingTarget:<#(id)#> refreshingAction:<#(SEL)#>]
    
    configure the header 
    
    self.tableView.header = header;
```
## RefreshFooter 
``` objective-c
    self.tableView.footer = [RefreshAutoStateNormalFooter footerWithRefreshingBlock:^{
      do something ...
    }];
```
if you want to do some configuration for the heard  
``` objective-c
     RefreshAutoStateNormalFooter *footer = [RefreshAutoStateNormalFooter footerWithRefreshingBlock:^{
     do something ...
}];

    
    configure the footer ...
    
    self.tableView.footer = footer;
```

### Use SEL
``` objective-c
    RefreshAutoStateNormalFooter *footer = [RefreshAutoStateNormalFooter footerWithRefreshingTarget:<#(id)#> refreshingAction:<#(SEL)#>]
    
    configure the footer ... 
    
    self.tableView.footer = footer;
```
