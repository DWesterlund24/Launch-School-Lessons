=begin
! is used before an object to represent the opposite boolean of said object.
it is also used at the end of a method to make clear that the method is destructive.
A ? is used after a method to signify that the method returns a boolean
A ? is also used along with a : to write a ternary if statement

1.  != is the opposite of ==, i.e. not equal to. You should use it when comparing two objects in 
    control expressions.
2.  When put before something like in !user_name, ! makes user_name take the opposite boolean value.
    Therefore if user_name had a true boolean value, !user_name would be false and vice versa.
3.  When after something, like in words.uniq!, the ! is telling us that #uniq! is destructive.
    This will mutate the caller. It's kinda like a warning sign. Do note that not all destructive
    methods carry this warning sign and that this is only a naming convention.
4.  When a question mark is put before something it could be part of a ternary expression.
5.  When a ? is after something it could mean a couple different things. The first is that the method
    it is suffixing, returns a boolean value, such as #include? or #empty? from the Array class.
    This is a naming convention for methods though. The other possibility is that the question mark
     is part of a ternary expression.
6.  When !! is put before something, like !!user_name, each ! carries the same functionality that it 
    had in question 2. We are basically asking not not user_name. So if user_name is true, the first
    ! would make user_name false and the second ! would put it back to true therefore returning true.