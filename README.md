Guayaba 2600
============

Código y artículos de la web Guayaba 2600

## Documentación para contribuir textos

* [Manual de estilo](http://guayaba2600.com/autores/docs/manual_de_estilo.html)
* [Guía para el formato de posts](http://guayaba2600.com/autores/docs/guia_tecnica.html)

## Dependencias de software requeridas

* Git LFS
* ruby >= 2.7
    * ruby (paquetes de desarrollo)
    * bundler (usar para instalar dependencias de gemas)
* ImageMagick >= 6.7.7
* NodeJS (jekyll requiere execjs)
* Yarn (opcionalmente NPM)

Se recomienda el desarrollo en GNU/Linux o Mac OS, aunque es posible preparar un entorno de desarrollo en Windows.

## Instalación

En Ubuntu:

    sudo gem install rake bundler
    bundle install

## Copia de librerías

Instalar dependencias localmente

    yarn add -P "jquery@1.9.1 - 3" "popper.js@^1.16.1"
    yarn install

Una vez instaladas, copiar archivos estáticos

    cp node_modules/jquery/dist/jquery.min.js js/lib/
    cp node_modules/popper.js/dist/umd/popper.min.js js/lib/
    cp node_modules/bootstrap/dist/js/bootstrap.min.js js/lib/
