#=ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)

РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке
=#

function mark_all_chess(r::Robot)
    num_vert = get_num_steps_movements!(r,Sud)
    num_hor = get_num_steps_movements!(r,West)
    #Переместили робота в угол
    side = Ost
    side_1 = West
    if mod(num_hor+num_vert,2) == 0
        mark_chess_line!(r,side)
        while isborder(r,Nord) == false 
            move!(r,Nord)
            side=inverse(side)
            mark_chess_line!(r,side)
        end
    end
    if mod(num_hor+num_vert,2) !== 0
        move!(r,Ost)
        mark_chess_line!(r,side)
        while isborder(r,Nord) == false 
            move!(r,Nord)
            move!(r,side_1)
            side=inverse(side)
            side_1=inverse(side_1)
            mark_chess_line!(r,side)
        end
    end

    movement!(r,Sud)
    movement!(r,West)
    #Робот в юго-западном углу 

    movements!(r,Ost,num_hor)
    movements!(r,Nord,num_vert)
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

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

function mark_chess_line!(r::Robot,side::HorizonSide)
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        if isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
        end
    end
end
    

movements!(r::Robot,side::HorizonSide,num_step::Int)=
    for i in 1:num_vert
        move!(r,side)
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





