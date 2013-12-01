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
    path_covers = "../img/covers/"
    path_sshots = "../img/screenshots/"
    path_review = "../reviews/_posts/"
    ssurl = "/img/screenshots/"
    coverfile = ""
    
    
    # Parse args
    path = str(sys.argv[1])
    dirname, filename = os.path.split(path)
    postname, ext = os.path.splitext(filename)
    imgdir = os.path.join(dirname, postname)
    
    # Create dir
    if not os.path.exists(imgdir):
        os.makedirs(imgdir)
    
    # Edit file
    newpath = dirname + "/" + postname + "-r" + ext
    f = open(path,'r')
    g = open(newpath, 'w')
    print(newpath)
    
    
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
            line.replace(line,newline)
            g.write(newline)
        elif (line.startswith("cover: ")):
            coverfile = line.replace("cover:","",1)
            coverfile = coverfile.strip()
            coverpath = os.path.join(dirname, coverfile)
            g.write(line)
        else:
            g.write(line)
    
    #print(coverpath)
        
    f.close()
    g.close()
    
    # Rename files
    og_name = f.name
    os.rename(f.name,f.name+"-orig")
    os.rename(g.name,og_name)
    
    # Moving the files to their place
    
    cover_dest = os.path.join(os.path.dirname(os.path.abspath(__file__)),path_covers, coverfile)
    sshots_dest = os.path.join(os.path.dirname(os.path.abspath(__file__)),path_sshots, postname)
    review_dest = os.path.join(os.path.dirname(os.path.abspath(__file__)),path_review, filename)
    
    if os.path.exists(coverpath):
        os.rename(coverpath,cover_dest)
    
    # Convert images
    current_dir = os.getcwd()
    os.chdir(dirname)
    print("actual" + os.getcwd())
    
    thumb_geom = "400x"
    
    for filename in os.listdir("."):
        imgname, ext = os.path.splitext(filename)
        print(filename)
        if ext == ".jpg" or ext == ".png":
            cmdstring = "convert " + filename + " -resize " + thumb_geom + "\> " + imgname+"-th.jpg"
            os.system(cmdstring)
            dest = postname + "/" + filename
            dest2 = postname + "/" + imgname + "-th.jpg"
            #print(dest)
            os.rename(filename,dest)
            os.rename(imgname+"-th.jpg",dest2)
    
    os.chdir(current_dir)
    
    os.rename(imgdir,sshots_dest)
    os.rename(path, review_dest)
    
    # Fin
        
if __name__ == '__main__':
    main()