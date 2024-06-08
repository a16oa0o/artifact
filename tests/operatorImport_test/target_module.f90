module target_module
    use auxiliary_type, only    : MyReal
    use auxiliary_module, only  : operator (+), assignment(=)
    implicit none

    contains

    subroutine target_subroutine(result)

        real(kind=8)                :: result
        real(kind=8)                :: a = 3.14159
        type(MyReal)                :: b

        b%x = 2.718281828459045

        result = a + b
        result = b
        
    end subroutine
    
end module target_module