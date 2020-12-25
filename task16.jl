function mark_field(r)
    side=Ost
    mark_row(r,side)
    # ИНВАРИАНТ: горизонталный ряд с Роботом и все нижние ряды замаркированы (замаркированы все из доступные 
    # клетки)
    while isborder(r,side)==false
        move!(r,Nord)
        side=inverse(side)
        mark_row(r,side)
    end
    #УТВ: Робот - у северной границы
end


function mark_row(r::Robot,side::HorizonSide)
    putmarker!(r)
    # ИНВАРИАНТ: клетка с Роботом и все ДОСТУПНЫЕ предыдущие в данном ряду (по ходу движения) замаркированы
    while move_if_posible!(r,side) == true
        putmarker!(r)
    end
end

function move_if_possible!(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next(direct_side)
    reverse_side = reverse(orthogonal_side)
    num_steps=0
    while isborder(direct_side) == true
        if isborder(r, orthogonal_side) == false
            move(r, orthogonal_side)
            num_steps += 1
        else
            break
        end
    end
    #УТВ: Робот или уперся в угол внешней рамки поля, или готов сделать шаг (или несколько) в направлении 
    # direct_side
    if isborder(r,direct_side) == false
        while isborder(r,reverse_side) == true
            move!(r,direct_side)
        end
        result = true
    else
        result = false
    end
    move!(r,reverse_side)
    return result
end
