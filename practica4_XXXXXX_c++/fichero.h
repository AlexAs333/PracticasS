#include "nodo.h"

class Fichero : public Nodo{
public:
    Fichero(std::string n, int t) : Nodo(n, t){}

    void cambiarTam(int size){
        tamagno = size;
    }
};