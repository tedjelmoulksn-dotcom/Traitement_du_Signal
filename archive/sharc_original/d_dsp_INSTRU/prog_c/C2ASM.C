/*-------------------------------------------------------------
Programme C2ASM.C 
Le seul interet de ce programme est de voir 
le couplage entre le C et l'assembleur natif du DSP
Sert aussi a tester le compilateur et le simulateur
---------------------------------------------------------------*/




int     suivant ( int k )
{
        k++;
        return ( k );
}

int main()
{
        int i=0;
        
        i=suivant(i);
}
