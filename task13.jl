#=
ДАНО: Робот - в произвольной клетке ограниченного прямоугольной рамкой поля без внутренних перегородок и маркеров.

РЕЗУЛЬТАТ: Робот - в исходном положении в центре косого креста (в 
=#
function mark_krest!(r::Robot)
    x=0
    putmarker!(r)
    vert_side=Sud
    hor_side=Ost
    mark_part!(r,vert_side,hor_side)
    vert_side=Sud
    hor_side=West
    mark_part!(r,vert_side,hor_side)
    vert_side=Nord
    hor_side=Ost
    mark_part!(r,vert_side,hor_side)
    vert_side=Nord
    hor_side=West
    mark_part!(r,vert_side,hor_side)
    
end

function mark_part!(r::Robot,vert_side::HorizonSide,hor_side::HorizonSide)
    x=0
    y=0
    while isborder(r,hor_side)==false
        move!(r,hor_side)
        if isborder(r,vert_side)==false
            move!(r,vert_side)
            putmarker!(r)
            y+=1
        end
        x+=1
    end
    vert_side=inverse(vert_side)
    hor_side=inverse(hor_side)
    while y!==0
        move!(r,vert_side)
        y -=1
    end
    while x!==0
        move!(r,hor_side)
        x -=1
    end


end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))


