#pragma once
#include <list>
#include <string>

template <typename T>
class Nodo{
protected:
    list<T> elementos;
    string _name;
    int tamagno;
    string rutaActiva;
public:
    Nodo(string n, int t, T elemento) : _name(n), tamagno(t) {
        elementos.push_back(elemento);
    }
    string name(){
        return _name;
    }
};