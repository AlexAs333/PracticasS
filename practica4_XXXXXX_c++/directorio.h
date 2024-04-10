#pragma once
#include "nodo.h"

template <typename T>
class Directorio : public Nodo{
protected:
    list<T> elementos;
    string actual;
    string padre;
public:
    Directorio(string n, string ruta) : Nodo(n, 0, Directorio) {
        actual = ruta + n;
        padre = ruta;
    }

    void guardar(T elemento){
        elementos.push_back(elemento);
    }

    string name() override {
        return _name;
    }
};