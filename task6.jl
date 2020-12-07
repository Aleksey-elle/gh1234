#=
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками.

РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
=#

function mark_innerrectangle_perimetr!(r::Robot)
    num_steps=fill(0,3) # - вектор-столбец из 3-х нулей
    for (i,side) in enumerate((Sud,West,Sud))
        num_steps[i]=moves!(r,side)
    end
    #Переместили робота в угол

    side = find_border!(r,Ost,side)
    #УТВ: Робот - у западной границы внутренней перегородки

    mark_innerrectangle_perimetr!(r,side)
    #УТВ: Робот - снова у западной границы внутренней прямоугольной перегородки

    moves!(r,Sud)
    moves!(r,West)
    #УТВ: Робот - в Юго-западном улу внешней рамки

    for (i,side) in enumerate((Nord,Ost,Nord))
        moves!(r,side, num_steps[i])
    end
    #УТВ: Робот - в исходном положении
end

function mark_innerrectangle_perimetr!(r::Robot, side::HorizonSide)
    direction_of_movement, direction_to_border = get_directions(side)
    for i ∈ 1:4   
        putmarkers!(r, direction_of_movement[i], direction_to_border[i]) 
    end
end

function find_border!(r::Robot, direction_to_border::HorizonSide, direction_of_movement::HorizonSide)
    while isborder(r,direction_to_border)==false  
        if isborder(r,direction_of_movement)==false
            move!(r,direction_of_movement)
        else
            move!(r,direction_to_border)
            direction_of_movement=inverse(direction_of_movement)
        end
    end
    #УТВ: непосредственно справа от Робота - внутренняя пергородка
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

moves!(r::Robot,side::HorizonSide)=
    while isborder(r,side)==false
        move!(r,side)
    end

get_directions(side::HorizonSide) = 
    if side == Nord  
    # - обход будет по часовой стрелке      
        return (Nord,Ost,Sud, West), (Ost,Sud,West,Nord)
    else # - обход будет против часовой стрелки
        return (Sud,Ost,Nord,West), (Ost,Nord,West,Sud) 
    end