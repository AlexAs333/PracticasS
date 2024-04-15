#include "nodo.h"

class Fichero : public Nodo{
protected:
    std::shared_ptr<Directorio> directorio;
public:
    Fichero(std::string n, int t, std::shared_ptr<Directorio> d) : Nodo(n, t), directorio(d) {}

    void cambiarTam(int size){
        tamagno = size;
    }

    std::shared_ptr<Directorio> obtenerDir(){
        return directorio;
    }
};