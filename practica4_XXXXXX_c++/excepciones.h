#pragma once

class arbol_ficheros_error{
public:
    virtual const char* what() const throw() {
    	return "";
	}
};

class noExiste : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "El fichero, directorio o enlace no existe en el path";
    }
};

class borradoDentro : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Se está intentando borrar un directorio que está dentro del path";
    }
};

class igualNombre : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Se intenta crear un link con el mismo nombre de un fichero o directorio existente en el path";
    }
};

class estoyRaiz : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Se intenta ir a un fichero padre estando en la raiz";
    }
};

class viDir : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Se intenta cambiar el tamaño de un directorio";
    }
};

class nom : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Nombre no válido";
    }
};

class Etam : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Tamaño no válido";
    }
};

class noDir : public arbol_ficheros_error{
public:
    const char* what() const throw(){
        return "Se intenta hacer cd a algo que no es un directorio";
    }
};