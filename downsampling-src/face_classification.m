function result = face_classification(D, img, alp, atoms_per_class)

    e = [];
    for i = 1 : atoms_per_class : (length(alp) - atoms_per_class + 1)
        d = D(:, i : i + atoms_per_class - 1);
        x = alp(i : i + atoms_per_class - 1, :);
        y = d * x;
        e = [e norm(y - img)]; 
    end
    [C, I] = min(e);
    result = I;
end