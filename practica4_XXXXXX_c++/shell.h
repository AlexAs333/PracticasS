#pragma once
#include "directorio.h"
#include "fichero.h"
#include "enlace.h"
#include <string>
using namespace std;
template <typename T>
class Shell : public Fichero<T> , public Enlace<T>, public Directorio<T>{
protected:
    //funciones
    //Pre: --
    //Post: si hay '/' en el nombre se guarda ../.../ en ruta, el resto en nombre.
    //      Sino no se cambia el nombre
    void descomponer(string nombre, string ruta){
        size_t posUSlash = nombre.find_last_of('/');
        if (posUSlash != string::npos) { // Si se encuentra al menos un '/'
            ruta = cadena.substr(0, posUSlash);
            string nombre = cadena.substr(posUSlash + 1);
        }
    }
public:
    Shell() : Nodo( "/", 0, Directorio){
        //inicializar árbol
    }
    string pwd(){
        return rutaActiva;
    }
    string ls(){
        //recorrer listas anidadas siguiendo ruta activa
        //función name de todos los elementos de la lista 
    }
    string du(){

    }
    void vi(string name, int size){
        //ponerse en ruta
        if(!fichero){
            Fichero(name, size);
        }
        else{
            cambiarTamaño(name, size);
        }
    }
    void mkdir(string name){
        string ruta;
        descomponer(name&, ruta&);
        Directorio(name, ruta + "/");
    }
    void cd(string path){

    }
    void ln(string path, string name){

    }
    int stat(string path){

    }
    void rm(string path){

    }

};