/************************************************
* Autores:  Alex Asensio Boj 874252
*           Pablo Báscones Gállego 874802
************************************************/
#pragma once
#include "directorio.h"
#include "fichero.h"
#include "enlace.h"
#include "excepciones.h"
#include <string>
#include <memory>
#include <iostream>
class Shell{
protected:
    Directorio raiz;
    std::list <std::shared_ptr<Directorio>> ruta;

public:
	//------------------------------CONSTRUCTOR------------------------------
    Shell() : raiz("/"){
        ruta.push_back(std::make_shared<Directorio> (raiz));
    }

	//------------------------------PWD------------------------------
    std::string pwd(){
        std::string camino;
        //Si el árbol de directorios está compuesto solo por raíz
        if(ruta.size() == 1){
            return ruta.front() -> name();
        }
		else{ //Caso general
			char cAtras = 2;
        	for(auto i : ruta){
				if(cAtras){
					camino += i->name();
					cAtras--;
				}
				else{
            		camino = camino + "/" + i->name();
				}
            }
        }
		return camino;	//Para evitar warnings
    }

	//------------------------------LS------------------------------
    std::string ls(){
        //usar contenido
        return ruta.back() -> contenido();
    }

	//------------------------------DU------------------------------
    std::string du(){
        //usar contytamagno
        return ruta.back() -> contyTamagno();
    }

	//------------------------------VI------------------------------
    void vi(std::string name, int size){
        //excepciones
		if ((int)name.find("/") != -1 ||  		//EXCEPCIÓN el nombre contiene una barra diagonal
    		name == "." || name == ".." || 		//o si el nombre es . o ..
    		(int)name.find(" ") != -1) {		//o si contiene espacios
    			throw nom();
		}
		if (size < 0) { //EXCEPCIÓN el tamaño es menor o igual a cero
    		throw Etam();
		}

		std::shared_ptr<Nodo> tipo;
		bool existe = ruta.back()->existe(name, tipo);	//Almacenamos si existe y cual es su tipo.

		if(std::dynamic_pointer_cast<Directorio> (tipo) != nullptr){	//EXCEPCIÓN se intenta modificar con vi un directorio
			throw viDir();
		}

		if(existe){	//El fichero ya existe. Cambiamos su tamaño
			if(std::dynamic_pointer_cast<Enlace> (tipo) != nullptr){	//Es un enlace
				std::shared_ptr<Enlace> link = std::dynamic_pointer_cast<Enlace> (tipo);	//Puntero para poder acceder a los métodos de enlace (Plink)
				if(std::dynamic_pointer_cast<Fichero> (link->Plink()) != nullptr){	//Si es un fichero
					link->cambiarTam(size);
				}
				else if(std::dynamic_pointer_cast<Directorio> (link->Plink()) != nullptr){//EXCEPCIÓN se intenta modificar con vi un el enlace a un directorio
					throw viDir();
				}
				else if(std::dynamic_pointer_cast<Enlace> (link->Plink()) != nullptr){//Vuelve a ser un enlace
					//INICIO FALLO
					while(std::dynamic_pointer_cast<Enlace> (tipo) != nullptr){//Obtenemos el archivo primigenio para saber su tipo
						tipo = std::dynamic_pointer_cast<Enlace>(tipo)->Plink();
					}
					//FIN FALLO
					if(dynamic_pointer_cast<Fichero> (tipo) != nullptr){
						link->cambiarTam(size);
					}
					else{	//Es un directorio
						throw viDir();	//EXCEPCIÓN se intenta modificar con vi un el enlace a un directorio
					}
				}
			}
			else if(std::dynamic_pointer_cast<Fichero> (tipo) != nullptr){	//Es un fichero
				//Cambiar tam Fichero y Directorio
				std::shared_ptr<Fichero> fichero = std::dynamic_pointer_cast<Fichero> (tipo); 	//Puntero para poder acceder a los métodos de fichero
				fichero->cambiarTam(size);
			}
		}
		else{	//El fichero no existe. Creamos uno
			std::shared_ptr<Fichero> nuevo = std::make_shared<Fichero> (Fichero(name, size));
			ruta.back()->guardar(nuevo);
		}
    }

	//------------------------------MKDIR------------------------------
    void mkdir(std::string name){
		if(!ruta.back()->existe(name)){
			std::shared_ptr<Directorio> directorio = std::make_shared<Directorio>(name);
			ruta.back()->guardar(directorio);
		}
		else{
			throw igualNombre();	//EXCEPCIÓN se intentacrear un directorio con nombre igual a uno
		}        
    }

	//------------------------------CD------------------------------
    void cd (std::string path){ 
		//Revisa "un único cd" cuando se le llama  
		if (path != "."){
			//cd /, a raíz
			if (path == "/"){
				std :: shared_ptr<Directorio> root = ruta.front(); //Cogemos la raíz solo 
				ruta.clear(); //Quitamos lo demás
				ruta.push_back(root); //Metemos únicamente la raíz calculada antes
			}
			//cd .. , excepción si estás en raíz (no se puede volver atrás)
			else if(path == ".."){
				if(ruta.size() == 1){	//EXCEPCIÓN se intenta ir para atrás estando en la raíz
					throw estoyRaiz();
				}
				else{
					ruta.pop_back();
				}
			}
		
			else if(path[0] == '.'){ //Tendremos que eliminar de nuestra ruta los ./ o ../ que nos aparezcan para limpiar la ruta 
				if(path[1] == '.'){	//es ..
					ruta.pop_back();	//le tiramos para atrás
					path = path.substr(3); //Quitamos ../ de la ruta
					cd(path);
				}
				else{
					path = path.substr(2); //Quitamos ./ de la ruta
					cd(path);
				}
			}
			else if(path [0] == '/'){
				std :: shared_ptr<Directorio> root = ruta.front(); //Cogemos la raíz solo 
				ruta.clear(); //Quitamos lo demás
				ruta.push_back(root); //Metemos únicamente la raíz calculada antes
				path = path.substr(1);
				cd(path);
			}
			else{
				std::shared_ptr<Nodo> aux;
				long unsigned int aparicionpri = path.find_first_of('/');
				if (aparicionpri == path.npos){
					if(ruta.back()->existe(path, aux)){
						std::shared_ptr<Directorio> aux2 = std::dynamic_pointer_cast<Directorio> (aux);
						if(aux2 == nullptr){	//EXCEPCIÓN se intenta acceder a algo que no es un directorio
						throw noDir();
						}
						ruta.push_back(aux2);
					}
					else{	//EXCEPCIÓN se intenta acceder a algo que no existe
						throw noExiste();
					}
					
				}
				else{
					std :: string subc = path.substr(0, aparicionpri);
					ruta.back()->existe(subc, aux);
					std::shared_ptr<Directorio> aux2 = std::dynamic_pointer_cast<Directorio> (aux);
					if(aux2 == nullptr){	//EXCEPCIÓN se intenta acceder a algo que no es un directorio
						throw noDir();
					}
					ruta.push_back(aux2);
					path = path.substr(aparicionpri+1);
					cd(path);
				}
			}
		}
    }
	//------------------------------LN------------------------------
    void ln(std::string path, std::string name){
		std::string rutaActiva = pwd();
		int posNombre = path.find_last_of("/");

		switch (posNombre){	//Vamos al directorio donde está el archivo al que queremos linkar, para ver si existe
		case 0:	//root
			cd("/");
			break;
		
		default: 	//otro
			cd(path.substr(0, posNombre));	//Vamos a donde indica la ruta. Si vamos a la ruta activa el substr es trivial
			break;
		}
		std::shared_ptr<Nodo> linked;	//Aqui almacenaremos de que tipo es el nodo que vamos a linkar
		if(!ruta.back()->existe(path.substr(posNombre+1, path.size()), linked)){	//EXCEPCIÓN se intenta linkar algo que no existe
			throw noExiste();
		}
		int tam = linked->tamagnoNodo();	//Obtenemos el tamaño del nodo a linkar

		cd(rutaActiva);	//Volvemos a donde estabamos
		std::string nodo = path.substr(1, path.size());
		if(ruta.back()->existe(name)){	//EXCEPCIÓN se intenta crear un link, y ya existe un nodo con ese nombre	
			throw igualNombre();
		}

		//excepciones
		if ((int)name.find("/") != -1 ||  		//EXCEPCIÓN el nombre contiene una barra diagonal
    		name == "." || name == ".." || 		//o si el nombre es . o ..
    		(int)name.find(" ") != -1) {		//o si contiene espacios
    			throw nom();
		}

		std::shared_ptr<Enlace> enlace = std::make_shared<Enlace>(name, tam, linked);	//Creamos el enlace
		ruta.back()->guardar(enlace);	//Guardamos el enlace
    }

	//------------------------------STAT------------------------------
    int stat(std::string path){
		std::string rutaActiva = pwd();
		int posNombre = path.find_last_of("/");

		std::string nodo;	//Aqui almacenamos el directorio del que queremos la info
		switch (posNombre){	//Vemos el directorio al que nos tenemos que mover: actual, root, otro
		case -1:	//actual
			nodo = path;
			break;
		case 0:	//root
			cd("/");	//Vamos a root
			nodo = path.substr(1);
			break;
		default:	//otro
			std::string ruta = path.substr(0, posNombre);	//Obtenemos la ruta del nodo que queremos
			cd(ruta);									//Y vamos a ella
			nodo = path.substr(posNombre+1); 
			break;
		}

		std::shared_ptr<Nodo> Pnodo;	//Almacenaremos el puntero del nodo que queremos la info
		if(path == "/"){
			if((Pnodo = ruta.back()) == nullptr){	//EXCEPCIÓN se intenta saber info de algo que no existe (root)
				throw noExiste();
			}
		}
		else{
			if(!(ruta.back()->existe(nodo, Pnodo))){	//EXCEPCIÓN se intenta borrar algo que no existe
				throw noExiste();
			}
		}
		
		int tam = Pnodo->tamagnoNodo();	//Obtenemos el tamaño paradevolverlo
		cd(rutaActiva);	//Volvemos a donde estábamos
		return tam;
    }

	//------------------------------RM------------------------------
    void rm(std::string path){
		std::string rutaActiva = pwd();
		if (rutaActiva.find(path) == 0) {	//EXCEPCIÓN se intenta borrar un directorio de la rutaActiva
    		throw borradoDentro();
		}

		int posNombre = path.find_last_of("/");					//Posicion de la ultima /
		std::string nombre = path.substr(posNombre+1, path.size());	//Nombre del elemento a borrar

		if(posNombre != 1){		//Si no buscamos en root
			std::shared_ptr<Nodo> tipo;
			if(!ruta.back()->existe(nombre, tipo)){	//EXCEPCIÓN se intenta borrar algo que no existe
				throw noExiste();
			}
			else{
				if(	std::dynamic_pointer_cast<Fichero> (tipo) != nullptr || 				//Si es un fichero
					std::dynamic_pointer_cast<Enlace> (tipo) != nullptr || 				//O un enlace
					std::dynamic_pointer_cast<Directorio> (tipo)->tamagnoNodo() == 0){ 	//O un directorio vacío
					ruta.back()->eliminar(tipo);									//Lo eliminamos directamente
				}
				else{	//Es un directorio NO vacío
					cd(rutaActiva + "/" + path);	//Vamos al directorio a borrar
					std::shared_ptr<Nodo> directorio = ruta.back();	//obtenemos el directorio actual

					//Borramos el contenido del directorio
					std::string content = std::dynamic_pointer_cast<Directorio>(directorio)->contenido();
					std::istringstream iss(content);
					std::string item;
					while (std::getline(iss, item, '\n')) {
    					rm(item);
					}

					cd(rutaActiva);	//Volvemos a la ruta activa
					//Guardamos en directorio el directorio que queriamos borrar desde el principio
					ruta.back()->existe(nombre, directorio);	//No recogemos el valor bool, por lógica ya sabemos que exite.
					rm(directorio->name());
				}
			}
		}
		else{	//Borramos un elemento de root. Se hace de forma recursiva, desde el padre hasta root.
			cd(path.substr(0, posNombre-1));	//Ir al padre
			std::shared_ptr<Nodo> directorio;
			ruta.back()->existe(nombre, directorio);	//Directorio apunta al directorio del que venimos. No recogemos el valor bool, por lógica ya sabemos que exite.
			rm(directorio->name());
		}
    }
};