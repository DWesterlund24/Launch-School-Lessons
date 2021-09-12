=begin
the method invocation bar(foo) first invokes the foo method. foo has no
arguments which would then set param to its default value "no". The
foo method doesn not actually use this variable in this case though and instead
returns "yes" in all cases. Now the method bar proceeds with the argument "yes"
and does not use it's default parameter. Then, since "yes" does not equal "no",
"no" is returned.