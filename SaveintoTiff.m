function y= SaveintoTiff(fileno)

res=300;
switch fileno
    case 1
        filename= 'delT vs Duration.tiff';
    case 2
        filename= 'A vs Duration.tiff';
    case 3
        filename= 'C vs Duration.tiff';
    case 4
        filename= 'delTw vs Duration.tiff';
    case 5
        filename= 'delTw vs Power.tiff';
    case 6
        filename= 'C vs Power.tiff';
end

print(filename,'-dtiff',['-r' sprintf('%.0f',res)]);
y=1;

end