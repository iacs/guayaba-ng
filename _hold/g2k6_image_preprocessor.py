#!/usr/bin/python
# coding=utf-8
#
# Script que preprocesa las imágenes y enlaces de los artículos de Guayaba 2600
# Herramienta preeliminar
# 
# Autor: Iago Mosquera
#
# Dependencias: imagemagick

import sys
import os, os.path

def main():
    # Parse args
    path = str(sys.argv[1])
    dirname, filename = os.path.split(path)
    postname, ext = os.path.splitext(filename)
    #filename = os.path.basename(path)
    #print(filename)
    #print(dirname)
    #print(postname)
    imgdir = dirname + "/" + postname + "/"
    
    # Create dir
    if not os.path.exists(imgdir):
        os.makedirs(imgdir)
    
    # Edit file
    newpath = dirname + "/" + postname + "-r" + ext
    f = open(path,'r')
    g = open(newpath, 'w')
    print(newpath)
    ssurl = "/img/screenshots/"
    
    for line in f:
        #print(line)
        if (line.startswith("!") and line.endswith("!\n")):
            imgfile = line.strip("!\n")
            imgfile, ext = os.path.splitext(imgfile)
            newline = ("p(pagination-centered). !(entry-screen)" +
                ssurl +
                postname + "/" +
                imgfile +
                "-th.jpg!:"+
                ssurl +
                postname + "/" +
                imgfile +
                ext + "\n"
                )
            #print(newline)
            #line.replace(line,newline)
            g.write(newline)
        else:
            g.write(line)
    
    f.close()
    g.close()
    
    # Convert images
    
    # Fin
        
if __name__ == '__main__':
    main()