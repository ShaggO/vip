The code is created to be executed using Matlab 2013b

In order to run the snake on both images (coins.png first and then cubic.jpg),
the script "main.m" should be executed in Matlab. Execute "coins_snake" or
"cubic_snake" to execute the snake algorithm only on coins.png or cubic.jpg
respectively.
When choosing points use Mouse Button 1 for marking points and some other key
(ie. "esc") when no more points are needed.

When running the code the first time, one should choose X number of points which
will be interpolated into a circle.
The original X points will be saved in the source directory as "points.mat" and
"points2.mat" for the coins.png and cubic.jpg images respectively.
When running the code afterwards, the points in the "points.mat" and
"points2.mat" will be loaded (if the files exist) instead of choosing new
points.

In order to be able to re-create our report data, we have supplied a data
directory with the points used for creating our test examples. The "points.mat"
and "points2.mat" in the data directory should be copied/moved to the source
folder and the "main.m" file should be executed in Matlab.
