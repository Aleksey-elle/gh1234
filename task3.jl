#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
=#


function mark_all(r::Robot)
    num_vert = get_num_steps_movements!(r,Sud)
    num_hor = get_num_steps_movements!(r,West)
    #Переместили робота в угол

    side = Ost
    mark_rowl!(r,side)
    while isborder(r,Nord)==false
        move!(r,Nord)
        side=inverse(side)
        mark_rowl!(r,side)
    end
    #Робот у верхней границы ,  в одном из углов 

    movement!(r,Sud)
    movement!(r,West)
    #Робот в юго-западном углу 

    movements!(r,Ost,num_hor)
    movements!(r,Nord,num_vert)
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))




movements!(r::Robot,side::HorizonSide,num_hor::Int)=
    for i in 1:num_hor
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

   
function mark_rowl!(r::Robot,side::HorizonSide)
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

               





