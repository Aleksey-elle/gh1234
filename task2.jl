#=
ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)

РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
=#

function mark_perimetr!(r::Robot)
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
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
    for _ in 1:numsteps # символ "_" заменяет фактически не используемую переменную
        move!(r,side)
    end
end