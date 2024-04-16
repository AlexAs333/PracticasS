/************************************************
* Autores:  Alex Asensio Boj 874252
*           Pablo Báscones Gállego 874802
************************************************/
#pragma once
#include <list>
#include <string>
#include <memory>

class Nodo{
protected:
    std::string _name;
    int tamagno;
public:
    Nodo(std::string n, int t) : _name(n), tamagno(t){}

    virtual int tamagnoNodo() const {
        return tamagno;
    }

    std::string name() const {
        return _name;
    }
};