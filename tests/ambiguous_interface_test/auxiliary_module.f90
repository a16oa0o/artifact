module auxiliary_module

    implicit none

    public  ::  foo

    interface foo
        module procedure right
        module procedure wrong
    end interface

    contains

    subroutine right(result, op1_in, op2_in)
        real(kind=8), intent(inout)             :: result
        real(kind=8), optional, intent(in)      :: op2_in
        real(kind=16), optional, intent(in)     :: op1_in
        real(kind=16)       :: op1
        real(kind=8)        :: op2


        if (present(op2_in)) then
            op2 = op2_in
        else
            op2 = 3.14159
        endif

        if (present(op1_in)) then
            op1 = op1_in
        else
            op1 = 2.718281828459045235360
        endif

        result = result + op1 + op2

    end subroutine

    subroutine wrong(result)
        real(kind=4) :: result

        result = 0.0
        
    end subroutine

end module auxiliary_module