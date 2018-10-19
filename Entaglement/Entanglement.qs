namespace Entanglement
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Primitive;

    operation Set (desired: Result, q1: Qubit) : ()
    {
        body
        {
            let current = M(q1);
            if (desired!=current){
                X(q1);
            }
        }
    }

    operation BellTest (count: Int, initial: Result) : (Int, Int, Int, Int)
    {
        body
        {
            mutable num00s = 0;
            mutable num01s = 0;
            mutable num10s = 0;
            mutable num11s = 0;

            using (qubits = Qubit[2])
            {
                for (test in 1..count)
                {
                    Set(initial, qubits[0]);
                    Set(Zero, qubits[1]);

                    H(qubits[0]);
                    CNOT(qubits[0],qubits[1]);
                    let res1 = M(qubits[0]);
                    let res2 = M(qubits[1]);

                    //count the number of times each state is seen:
                    if(res1 == Zero && res2 == Zero)
                    {
                        set num00s = num00s + 1;
                    }
                    elif(res1 == Zero && res2 == One)
                    {
                        set num01s = num01s + 1;
                    }
                    elif(res1 == One && res2 == Zero)
                    {
                        set num10s = num10s + 1;
                    }
                    else
                    {
                        set num11s = num11s + 1;
                    }
                }
                //release the qubits
                Set(Zero, qubits[0]);
                Set(Zero, qubits[1]);
            }
            return (num00s, num01s, num10s, num11s);
        }
    }
}
