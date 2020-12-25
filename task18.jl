function mark_angles(r)
    num_steps=[]
    while isborder(r,Sud)==false || isborder(r,West)==false # Робот - не в юго-западном углу
        push!(num_steps, moves!(r, West)) # - добавляется в конец массива новый элемент
        push!(num_steps, moves!(r, Sud))
    end
    for side in (Nord,Ost,Sud,West)
        moves!(r,side) # возвращаемый результат игнорируется
        putmarker!(r)
    end
    for (i,n) in enumerate(reverse!(num_steps)) # встроенная функция reverse! переворачивает массив задом на перед
        side = isodd(i) ? Ost : Nord # odd - нечетный
        moves!(r,side,n)
    end
    #УТВ: Робот - в исходном положении
end
  
function moves!(r,side)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end 

moves!(r,side,num_steps) = for _ in 1:num_steps move!(r,side) end


