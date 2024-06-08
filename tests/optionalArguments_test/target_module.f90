module target_module
    use auxiliary_module, only  : foo
    implicit none

    contains

    subroutine target_subroutine(result)

        real(kind=8)    :: result
        real(kind=8)    :: result1 = 1.0
        real(kind=8)    :: result2 = 2.0
        real(kind=8)    :: result3 = 3.0
        real(kind=8)    :: result4 = 4.0
        real(kind=16)   :: i_in

        i_in = 2.0

        call foo(result1)
        call foo(result2, i_in, result1)
        call foo(result3, op2_in=result2)
        call foo(result4, op2_in=result3, op1_in=i_in)
        call foo(result)

        result = result1 + result2 + result3 + result4
        
    end subroutine
    
end module target_module