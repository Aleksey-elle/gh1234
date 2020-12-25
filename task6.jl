#=
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками.

РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
=#

function mark_innerrectangle_perimetr!(r::Robot)
    side=Sud
    side_to_border=Ost
    side_of_movement=Nord
    num_vert=0
    num_hor=0
    num_vert_1=0
    num_hor_1=0
    while isborder(r,side)==false
        move!(r,side)
        num_vert=num_vert + 1
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
        num_hor=num_hor + 1
    end
    side=Sud
    while isborder(r,side)==false
        move!(r,side)
        num_vert_1=num_vert_1 + 1
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
        num_hor_1=num_hor_1 + 1
    end 
    #Робот перемещается в угол запоминая путь
    find_border!(r,side_to_border,side_of_movement)
    #Поиск перегородки 
    mark_perimetr!(r,side_to_border,side_of_movement)
    #Маркировка перегородки
    side=West
    while isborder(r,side)==false
        move!(r,side)
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
    end
    side=Sud
    while isborder(r,side)==false
        move!(r,side)
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
    end 
    #Робот снова в углу 
    side=Ost
    movements!(r,side,num_hor_1) 
    side=Nord
    movements!(r,side,num_vert_1)
    side=Ost
    movements!(r,side,num_hor) 
    side=Nord
    movements!(r,side,num_vert) 
    #Перемещение робота по запомненному пути 
    
   
end

function find_border!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) 
    while isborder(r,side_to_border)==false  
        if isborder(r,side_of_movement)==false
            move!(r,side_of_movement)
        else
            move!(r,side_to_border)
            side_of_movement=inverse(side_of_movement)
        end
    end
end

function find_corner!(r::Robot,side::HorizonSide) 
    num_vert=0
    num_hor=0
    num_vert_1=0
    num_hor_1=0
    while isborder(r,side)==false
        move!(r,side)
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
    end
    side=Sud
    while isborder(r,side)==false
        move!(r,side)
    end
    side=next_move(side)
    while isborder(r,side)==false
        move!(r,side)
    end 
end

function mark_perimetr!(r::Robot,side_to_border::HorizonSide, side_of_movement::HorizonSide) 
    for i ∈ 1:4   
        while isborder(r,side_to_border)==true
            putmarker!(r)
            move!(r,side_of_movement)
        end
        side_to_border=next_bord(side_to_border)
        side_of_movement=next_move(side_of_movement)
        putmarker!(r)
        movements!(r,side_of_movement,1)
        i=i+1
    end
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

next_bord(side_to_border::HorizonSide)=HorizonSide(mod(Int(side_to_border)+3,4))
        
next_move(side_of_movement::HorizonSide)=HorizonSide(mod(Int(side_of_movement)+3,4))

movements!(r::Robot,side::HorizonSide,num_vert::Int)=
    for i in 1:num_vert
        move!(r,side)
    end

