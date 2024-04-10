#pragma once
#include <list>
#include <string>

class Nodo{
protected:
    string _name;
    int tamagno;
    string rutaActiva;
public:
    Nodo(string n, int t) : _name(n), tamagno(t) {}
    virtual string name() const = 0;
};