using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Entanglement
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                Result[] initials = new Result[]{Result.Zero, Result.One};
                foreach (Result initial in initials)
                {
                    var res = BellTest.Run(sim, 1000, initial).Result;
                    var (num00s, num01s, num10s, num11s) = res;
                    System.Console.WriteLine($"Init:{initial,-4} 00s={num00s,-4} 01s={num01s,-4} 10s={num10s,-4} 11s={num11s,-4}");
                }
            }
            System.Console.WriteLine("Press any key to continue");
            System.Console.ReadKey();
        }
    }
}
