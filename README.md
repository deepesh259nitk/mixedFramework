# mixedFramework
This is example cocoa pods of how iOS frameworks work in reality containing both Objective c and Swift code. The framework uses Modules to address the issues of accessing private objective C files within the swift ecosystem and still keeping those objective c Files private within the framework and not exposed to the end user. 

Some Known Issue’s which are fixed in iOS mixed frameworks 

1. Debugging Swift code within the framework : This is fixed naming the modules rightly
2. Module not found issue when doing a POD install after you have fixed issue number 1 : After fixing issue 1 which is renaming the pods to canonical form would result in error on the client app using the POD which would be for example  “ Module not found “. But renaming rightly in this case 
    1. Foo.private.modulemap should have the module name as Foo_Privates
    2. module.modulemap should have the module name as Foo_Private
    3. Note : Both Foo_Privates and Foo_Privates are different names with a underscore to silent the warning : “expected canonical name for private module” which then allows the debugging of swift code as expected.
3. Test targets don’t work as expected and don’t have access to Swift or Objective c Code and vice versa 
4. the mixed iOS framework now has a test target written in swift, Which means you can now write your test cases in swift within a mixed framework environment. 

Note : Generally the above mentioned issues should be working be default within the apple ecosystem but unfortunately within a iOS framework things gets a bit complex than expected and using modules and following some right naming convention all of the above can successfully work.
