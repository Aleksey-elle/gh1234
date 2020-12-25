#=ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров

РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток
=#


function sred_temp_markers(r::Robot)
    sred = 0
    side = Nord
    n=0
    sum=0
    sum=take_sum_temp!(r,side)
    while isborder(r,West)==false
        move!(r,West)
    end
    n=take_kol_n!(r,side)
    sred = div(sum,n)
    println("средняя температура = $(sred)")

end

function take_kol_n!(r::Robot,side::HorizonSide)
    n=0
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            if ismarker(r)==true
              n=n+1  
            end
            move!(r,side)
        end
        move!(r,Ost)
        side=inverse(side)
    end
    while isborder(r,Sud)==false
        if ismarker(r)==true
        n=n+1    
        end
        move!(r,Sud)
    end
    return n
end

function take_sum_temp!(r::Robot,side::HorizonSide)
    sum=0
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            if ismarker(r)==true
              x=temperature(r)
              sum=sum+x
            end
            move!(r,side)
        end
        move!(r,Ost)
        side=inverse(side)
    end
    while isborder(r,Sud)==false
        if ismarker(r)==true
            x=temperature(r)
            sum=sum+x
        end
        move!(r,Sud)
    end
    return sum
end
inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))

   




