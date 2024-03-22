#pragma once
#include "nodo.h"

template <typename T>
class Directorio : public Nodo{
protected:
    string actual;
    string padre;
public:
    Directorio(string n, string ruta) : Nodo(n, 0, Directorio) {
        actual = ruta + n;
        padre = ruta;
        //crear mi lista
    }

    virtual string name() const {
        return _name;
    }
};