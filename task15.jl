function mark_perimetr!(r::Robot)
    side=Nord
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West)==false # Робот - не в юго-западном углу
        push!(num_steps, get_num_movements!(r, West))
        push!(num_steps, get_num_movements!(r, Sud))
    end
    #УТВ: Робот - в Юго-Западном углу

    for side in (Nord, Ost, Sud, West)
        putmarkers!(r,side)
    end
    #УТВ: По всему периметру стоят маркеры

    moves!(r,Nord,num_vert)
    moves!(r,Ost,num_hor)
    #УТВ: Робот - в исходном положении
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end

function get_num_movements!(r::Robot,side::HorizonSide)
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
