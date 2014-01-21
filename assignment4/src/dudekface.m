function I = dudekface(frame,scale)

I = im2double(imread(sprintf('dudekface/DudekSeq/frame%.4d.pgm',frame)));
I = imresize(I,scale);

end

