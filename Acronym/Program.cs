using System;

namespace Multi_Term
{
    class Program
    {
    static void Main(string[] args)
        {
            Console.WriteLine("Enter a multi word term");
            string input = Console.ReadLine().ToUpper();
            string[] x = input.Split(' ');
            foreach(var y in x)
            {
                Console.WriteLine($"{y[0]}");
            }

        }
    }
}
