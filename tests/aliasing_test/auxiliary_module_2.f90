module auxiliary_module_2

    use auxiliary_module_3, only : bar_alias=>bar, baz_alias=>baz

    implicit none; private

    public  ::  bar_alias, baz_alias

end module auxiliary_module_2