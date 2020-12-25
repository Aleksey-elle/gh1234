function mark_zebra!(robot::Robot, line_side::HorizonSide, ortogonal_line_side::HorizonSide, num_passes::Int, num_start_passes=0)
    start_side = get_start_side(line_side,ortogonal_line_side)
    #УТВ: start_side - кортеж типа NTuple{2,HorizonSide}, например: (Sud,Ost)  

    nun_steps = [get_num_movements!(robot,start_side[i]) for i in 1:2]
    #УТВ: Робот - в стартовом углу

    movements_if_posible!(robot, ortogonal_line_side, num_start_passes) || return
    line_mark!(robot,line_side)
    #ИНВАРИАНТ: линия с Роботом и все предыдущие (по ходу движения в направлении ortogonal_line_side) замаркированы
    while movements_if_posible!(robot,ortogonal_line_side, num_passes) == true
        line_side = inverse(line_side)
        line_mark!(robot,line_side)
    end
    #УТВ: все линии замаркированы

    for s in start_side
        movements!(r,s)
    end
    #УТВ: Робот - снова в стартовом углу

    back_side=inverse(start_side)
    for (i,num) in arange(num_steps)
        movements!(robot,back_side[i], num)
    end
    #УТВ: Робот - в исходном положении
end

function movements_if_posible!(robot, side, max_num_steps)
    for _ in 1:max_num_steps
        isborder(robot,side) && (return false)
        move!(robot,side)
    end
    return true
end

function line_mark!(robot,side)
    putmarker!(robot)
    putmarkers!(robot,side)
end