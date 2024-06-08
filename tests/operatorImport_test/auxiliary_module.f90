module auxiliary_module

    use auxiliary_type, only: MyReal

    implicit none

    public  ::  operator(+), assignment(=)

    interface operator (+)
        module procedure foo
    end interface
    
    interface assignment (=)
        module procedure bar 
    end interface

    contains

    real(kind=8) function foo(op1, op2)
        real(kind=8), intent(in)    :: op1
        type(MyReal), intent(in)    :: op2

        foo = 1.0

    end function

    subroutine bar(op1, op2)
        real(kind=8), intent(out)        :: op1
        type(MyReal), intent(in)        :: op2

        op1 = 2.0
        
    end subroutine

end module auxiliary_module