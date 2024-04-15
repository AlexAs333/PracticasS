#pragma once
#include "nodo.h"

class Directorio : public Nodo{
protected:
    std::list<std::shared_ptr<Nodo>> elementos;
public:
    Directorio(std:: string n) : Nodo(n, 0) {}

    //Guarda elementos en la lista
    //No lo guarda si ya hay un elemento con el nombre --> EXCEPCIÓN en el shell
    void guardar(std::shared_ptr<Nodo> e, int t){
        tamagno += t;
        elementos.push_back(e);
    }

    void eliminar(std::shared_ptr<Nodo> e){
        tamagno -= e->tamagnoNodo();
        elementos.remove(e);
    }

    void cambiarTam(int anterior, int nuevo){
        tamagno -= anterior;
        tamagno += nuevo;
    }

    std::list<std::shared_ptr<Nodo>> listaElementos() const{
        return elementos;
    }

    std::string contenido(){
        std::string cont = "";
        for(auto const& i : elementos){
            cont = cont + i->name() + "\n";
            /*if(&i != &elementos.back()){
                cont = cont + "\n";
            }*/
        }
		return cont;
    }

    std::string contyTamagno(){
		std::string cont = "";
        for(auto i : elementos){
            cont += std::to_string(tamagno) + " " + i->name();
            if(&i != &elementos.back()){
                cont += "\n";
            }
        }
		return cont;
    }

    bool existe(const std::string& f, std::shared_ptr<Nodo>& tipo){
		for (auto i : elementos){
			if(i->name() == f){
				tipo = i;
				return true;
			}
		}
		return false;
    }

	bool existe(const std::string& f){
		for (auto i : elementos){
			if(i->name() == f){
				return true;
			}
		}
		return false;
    }
};