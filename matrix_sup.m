function newmatrix = matrix_sup( matrix )
a=size(matrix,1);
while (a >= 1)
    if (matrix(a,4) < 60)
        matrix(a,:)=[];
        %a = a-1;
    end
    a = a-1;
end
newmatrix = matrix;

end

