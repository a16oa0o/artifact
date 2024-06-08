module auxiliary_module_1

    implicit none; private

    public  ::  foo

    contains

    function foo(x)
        real(kind=8)    :: x
        integer         :: foo

        if (x > 0.0) then 
            foo = 1
        else
            foo = -1
        endif
        
    end function

end module auxiliary_module_1