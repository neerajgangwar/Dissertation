#! /bin/bash

cd '/media/neeraj/Media/Study/5-1/Disseration/MATLAB/Face Recognition with Sparse Representation/TrainingFaces'

N=32

for i in {15..39}
do
    ls "yaleB$i" | sort -R | tail -$N | while read file; do
        mv "yaleB$i/$file" ../TestFaces
    done
done
