#=
ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
=#


function mark_all_strings_decreasing(r::Robot)
    num_vert = get_num_steps_movements!(r,Sud)
    num_hor = get_num_steps_movements!(r,West)
    line_lenght = 11
    #Переместили робота в угол

    side = Ost
    mark_line_decreasing!(r,side,line_lenght)
    while isborder(r,Nord)==false
        move!(r,Nord)
        movement!(r,West)
        line_lenght -= 1
        mark_line_decreasing!(r,side,line_lenght)
    end
  
    movement!(r,Sud)
    movement!(r,West)
    #Робот в юго-западном углу 

    movements!(r,Ost,num_hor)
    movements!(r,Nord,num_vert)
end



function mark_line_decreasing!(r::Robot,side::HorizonSide,line_lenght::Int)
    putmarker!(r)
    for i in 1:line_lenght 
        move!(r,side)
        putmarker!(r)
    end
end

function get_num_steps_movements!(r::Robot,side::HorizonSide)
    num_vert = 0
    num_hor = 0
    if (side == Sud)
        while isborder(r,side)==false
            move!(r,side)
            num_vert += 1
        end
        return num_vert
    end
    if (side == West)
        while isborder(r,side)==false
            move!(r,side)
            num_hor += 1
        end
        return num_hor
    end
end

movement!(r::Robot,side::HorizonSide)=
    while isborder(r,side)==false
        move!(r,side)
    end

movements!(r::Robot,side::HorizonSide,num_vert::Int)=
    for i in 1:num_vert
        move!(r,side)
    end

movements!(r::Robot,side::HorizonSide,num_hor::Int)=
    for i in 1:num_hor
        move!(r,side)
    end


    