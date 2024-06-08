module target_module
    use auxiliary_module_1, only  : foo_alias=>foo
    use auxiliary_module_2, only  : bar_alias, baz_alias
    use auxiliary_module_3, only  : buzz

    implicit none

    contains

    subroutine target_subroutine(result)
        real (kind=8)   :: result

        result = -3.14

        call bar_alias()
        result = 2.718281828459045 * foo(result)
        call baz_alias()
        
    end subroutine

    function foo(x)
        integer         :: foo
        real (kind=8)   :: x

        call buzz()
        foo = foo_alias(x)

    end function
    
end module target_module