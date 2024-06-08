module target_module
    use auxiliary_module, only: prose_foo

    implicit none

    contains

    subroutine target_subroutine(result)

        integer :: i

        real (kind=8)  :: a0_4=-1.0, b0_4=-1.0, c0_4=-1.0, d0_4=-1.0, e0_4=-1.0
        real (kind=8)  :: f0_8=1.0, g0_8=1.0, h0_8=1.0, i0_8=1.0, j0_8=1.0
        real (kind=8)  :: k0=0.0, l0=0.0, m0=0.0, n0=0.0, o0=0.0
        real (kind=8)  :: p0=0.0, q0=0.0, r0=0.0, s0=0.0, t0=0.0
        real (kind=8)  :: u0=0.0, v0=0.0, w0=0.0, x0=0.0, y0=0.0
        real (kind=8)  :: a1=0.0, b1=0.0, c1=0.0, d1=0.0, e1=0.0
        real (kind=8)  :: f1=0.0, g1=0.0, h1=0.0, i1=0.0, j1=0.0
        real (kind=8)  :: k1=0.0, l1=0.0, m1=0.0, n1=0.0, o1=0.0
        real (kind=8)  :: p1=0.0, q1=0.0, r1=0.0, s1=0.0, t1=0.0
        real (kind=8)  :: u1=0.0, v1=0.0, w1=0.0, x1=0.0, y1=0.0
        real (kind=8)  :: a2=0.0, b2=0.0, c2=0.0, d2=0.0, e2=0.0
        real (kind=8)  :: f2=0.0, g2=0.0, h2=0.0, i2=0.0, j2=0.0
        real (kind=8)  :: k2=0.0, l2=0.0, m2=0.0, n2=0.0, o2=0.0
        real (kind=8)  :: p2=0.0, q2=0.0, r2=0.0, s2=0.0, t2=0.0
        real (kind=8)  :: u2=0.0, v2=0.0, w2=0.0, x2=0.0, y2=0.0
        real (kind=8)  :: a3=0.0, b3=0.0, c3=0.0, d3=0.0, e3=0.0
        real (kind=8)  :: f3=0.0, g3=0.0, h3=0.0, i3=0.0, j3=0.0
        real (kind=8)  :: k3=0.0, l3=0.0, m3=0.0, n3=0.0, o3=0.0
        real (kind=8)  :: p3=0.0, q3=0.0, r3=0.0, s3=0.0, t3=0.0
        real (kind=8)  :: u3=0.0, v3=0.0, w3=0.0, x3=0.0, y3=0.0
        real (kind=8)  :: a4=0.0, b4=0.0, c4=0.0, d4=0.0, e4=0.0
        real (kind=8)  :: f4=0.0, g4=0.0, h4=0.0, i4=0.0, j4=0.0
        real (kind=8)  :: k4=0.0, l4=0.0, m4=0.0, n4=0.0, o4=0.0
        real (kind=8)  :: p4=0.0, q4=0.0, r4=0.0, s4=0.0, t4=0.0
        real (kind=8)  :: u4=0.0, v4=0.0, w4=0.0, x4=0.0, y4=0.0
        real (kind=8)  :: a5=0.0, b5=0.0, c5=0.0, d5=0.0, e5=0.0
        real (kind=8)  :: f5=0.0, g5=0.0, h5=0.0, i5=0.0, j5=0.0
        real (kind=8)  :: k5=0.0, l5=0.0, m5=0.0, n5=0.0, o5=0.0
        real (kind=8)  :: p5=0.0, q5=0.0, r5=0.0, s5=0.0, t5=0.0
        real (kind=8)  :: u5=0.0, v5=0.0, w5=0.0, x5=0.0, y5=0.0
        real (kind=8)  :: a6=0.0, b6=0.0, c6=0.0, d6=0.0, e6=0.0
        real (kind=8)  :: f6=0.0, g6=0.0, h6=0.0, i6=0.0, j6=0.0
        real (kind=8)  :: k6=0.0, l6=0.0, m6=0.0, n6=0.0, o6=0.0
        real (kind=8)  :: p6=0.0, q6=0.0, r6=0.0, s6=0.0, t6=0.0
        real (kind=8)  :: u6=0.0, v6=0.0, w6=0.0, x6=0.0, y6=0.0
        real (kind=8)  :: a7=0.0, b7=0.0, c7=0.0, d7=0.0, e7=0.0
        real (kind=8)  :: f7=0.0, g7=0.0, h7=0.0, i7=0.0, j7=0.0
        real (kind=8)  :: k7=0.0, l7=0.0, m7=0.0, n7=0.0, o7=0.0
        real (kind=8)  :: p7=0.0, q7=0.0, r7=0.0, s7=0.0, t7=0.0
        real (kind=8)  :: u7=0.0, v7=0.0, w7=0.0, x7=0.0, y7=0.0
        real (kind=8)  :: a8=0.0, b8=0.0, c8=0.0, d8=0.0, e8=0.0
        real (kind=8)  :: f8=0.0, g8=0.0, h8=0.0, i8=0.0, j8=0.0
        real (kind=8)  :: k8=0.0, l8=0.0, m8=0.0, n8=0.0, o8=0.0
        real (kind=8)  :: p8=0.0, q8=0.0, r8=0.0, s8=0.0, t8=0.0
        real (kind=8)  :: u8=0.0, v8=0.0, w8=0.0, x8=0.0, y8=0.0
        real (kind=8)  :: a9=0.0, b9=0.0, c9=0.0, d9=0.0, e9=0.0
        real (kind=8)  :: f9=0.0, g9=0.0, h9=0.0, i9=0.0, j9=0.0
        real (kind=8)  :: k9=0.0, l9=0.0, m9=0.0, n9=0.0, o9=0.0
        real (kind=8)  :: p9=0.0, q9=0.0, r9=0.0, s9=0.0, t9=0.0
        real (kind=8)  :: u9=0.0, v9=0.0, w9=0.0, x9=0.0, y9=0.0

        real (kind=8)  :: result

        result = 2.718281828459045

        result = result + prose_foo(a0_4) + prose_foo(b0_4) + prose_foo(c0_4) + prose_foo(d0_4) + prose_foo(e0_4)
        result = result + prose_foo(f0_8) + prose_foo(g0_8) + prose_foo(h0_8) + prose_foo(i0_8) + prose_foo(j0_8)
        result = result + k0 + l0 + m0 + n0 + o0
        result = result + p0 + q0 + r0 + s0 + t0
        result = result + u0 + v0 + w0 + x0 + y0
        
        do i = 0, 2
            result = result + a1 + b1 + c1 + d1 + e1
            result = result + f1 + g1 + h1 + i1 + j1
            result = result + k1 + l1 + m1 + n1 + o1
            result = result + p1 + q1 + r1 + s1 + t1
            result = result + u1 + v1 + w1 + x1 + y1
        end do

        do i = 0, 3
            result = result + a2 + b2 + c2 + d2 + e2
            result = result + f2 + g2 + h2 + i2 + j2
            result = result + k2 + l2 + m2 + n2 + o2
            result = result + p2 + q2 + r2 + s2 + t2
            result = result + u2 + v2 + w2 + x2 + y2
        end do

        do i = 0, 4
            result = result + a3 + b3 + c3 + d3 + e3
            result = result + f3 + g3 + h3 + i3 + j3
            result = result + k3 + l3 + m3 + n3 + o3
            result = result + p3 + q3 + r3 + s3 + t3
            result = result + u3 + v3 + w3 + x3 + y3
        end do

        do i = 0, 5
            result = result + a4 + b4 + c4 + d4 + e4
            result = result + f4 + g4 + h4 + i4 + j4
            result = result + k4 + l4 + m4 + n4 + o4
            result = result + p4 + q4 + r4 + s4 + t4
            result = result + u4 + v4 + w4 + x4 + y4
        end do

        result = result + a5 + b5 + c5 + d5 + e5
        result = result + f5 + g5 + h5 + i5 + j5
        result = result + k5 + l5 + m5 + n5 + o5
        result = result + p5 + q5 + r5 + s5 + t5
        result = result + u5 + v5 + w5 + x5 + y5
        result = result + a6 + b6 + c6 + d6 + e6
        result = result + f6 + g6 + h6 + i6 + j6
        result = result + k6 + l6 + m6 + n6 + o6
        result = result + p6 + q6 + r6 + s6 + t6
        result = result + u6 + v6 + w6 + x6 + y6
        result = result + a7 + b7 + c7 + d7 + e7
        result = result + k7 + l7 + m7 + n7 + o7
        result = result + p7 + q7 + r7 + s7 + t7
        result = result + u7 + v7 + w7 + x7 + y7
        result = result + a8 + b8 + c8 + d8 + e8
        result = result + f8 + g8 + h8 + i8 + j8
        result = result + k8 + l8 + m8 + n8 + o8
        result = result + p8 + q8 + r8 + s8 + t8
        result = result + u8 + v8 + w8 + x8 + y8
        result = result + a9 + b9 + c9 + d9 + e9
        result = result + f9 + g9 + h9 + i9 + j9
        result = result + k9 + l9 + m9 + n9 + o9
        result = result + p9 + q9 + r9 + s9 + t9
        result = result + u9 + v9 + w9 + x9 + y9

    end subroutine
    
end module target_module