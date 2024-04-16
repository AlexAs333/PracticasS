/************************************************
* Autores:  Alex Asensio Boj 874252
*           Pablo Báscones Gállego 874802
************************************************/
#pragma once
#include "nodo.h"

class Enlace : public Nodo{
protected:
    std::shared_ptr<Nodo> link;
public:
    Enlace(std::string n, int t, std::shared_ptr<Nodo> l) : Nodo(n, t), link(l) {}

    std::shared_ptr<Nodo> Plink() const{
        return link;
    }

    void cambiarTam(int size){
        tamagno = size;
    }
};