/************************************************
* Autores:  Alex Asensio Boj 874252
*           Pablo Báscones Gállego 874802
************************************************/
#pragma once
#include "nodo.h"
#include <iomanip>

class Directorio : public Nodo{
protected:
    std::list<std::shared_ptr<Nodo>> elementos;
public:
    Directorio(std:: string n) : Nodo(n, 0) {}

    //Guarda elementos en la lista
    //No lo guarda si ya hay un elemento con el nombre --> EXCEPCIÓN en el shell
    void guardar(std::shared_ptr<Nodo> e){
        elementos.push_back(e);
    }

    void eliminar(std::shared_ptr<Nodo> e){
        elementos.remove(e);
    }

    int tamagnoNodo() const override {
        int tam = 0;
        for(auto i : elementos){
            tam += i->tamagnoNodo();
        }
        return tam;
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
        }
		return cont;
    }

    std::string contyTamagno() {
        std::stringstream cont;
        cont << std::setw(7) << "tamaño" << std::setw(10) << "nombre\n"; // Establecer el ancho de campo para los encabezados
        for (auto i : elementos) {
            cont << std::setw(7) << i->tamagnoNodo() << std::setw(7) << i->name() << "\n"; // Establecer el ancho de campo para los datos
        }
        return cont.str();
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