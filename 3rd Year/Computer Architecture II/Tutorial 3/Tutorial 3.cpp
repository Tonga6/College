// Tutorial 3 - Q4.cpp : This file contains the 'main' function. Program execution begins and ends there.
//

#include <iostream>
int calls, depth, maxDepth, overflows, underflows= 0;
int windows = 2;
int maxWindows;

int computePascal(int row, int position)
{
    if (position == 1)
    {
        return 1;
    }
    else if (position == row)
    {
        return 1;
    }

    else
    {
        return computePascal(row - 1, position) + computePascal(row - 1, position - 1);
    }
}

int computePascalA(int row, int position)
{
    calls++;
    depth++;
    if (depth > maxDepth) 
        maxDepth = depth;
    
    if (windows >= maxWindows)
        overflows++;
    else
        windows++;

    if (position == 1)
    {
        depth--;
        if (windows <= maxWindows)
            underflows++;
        else
            windows--;

        return 1;
    }
    else if (position == row)
    {
        depth--;
        if (windows <= maxWindows)
            underflows++;
        else
            windows--;

        return 1;
    }

    else
    {
        return computePascalA(row-1, position) + computePascalA(row-1, position-1);
    }
}

int computePascalB(int row, int position)
{
    calls++;
    depth++;
    if (depth > maxDepth)
        maxDepth = depth;

    if (windows >= maxWindows - 1)
        overflows++;
    else
        windows++;

    if (position == 1)
    {
        depth--;
        if (windows <= maxWindows)
            underflows++;
        else
            windows--;

        return 1;
    }
    else if (position == row)
    {
        depth--;
        if (windows <= maxWindows)
            underflows++;
        else
            windows--;

        return 1;
    }

    else
    {
        depth--;
        if (windows <= maxWindows)
            underflows++;
        else
            windows--;

        return computePascalB(row - 1, position) + computePascalB(row - 1, position - 1);
    }
}

int main()
{

    maxWindows = 6;
    computePascalA(30, 20);
    std::cout << "\ncomputePascalA - overflow on all windows used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";
    computePascalB(30, 20);
    std::cout << "\ncomputePascalB - overflow on all but one window used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";


    maxWindows = 8; 
    computePascalA(30, 20);
    std::cout << "\ncomputePascalA - overflow on all windows used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";
    computePascalB(30, 20);
    std::cout << "\ncomputePascalB - overflow on all but one window used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";


    maxWindows = 16;
    computePascalA(30, 20);
    std::cout << "\ncomputePascalA - overflow on all windows used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";
    computePascalB(30, 20);
    std::cout << "\ncomputePascalB - overflow on all but one window used:\n" << "\nmaxWindows: " << maxWindows << "\ncalls: " << calls << "\nmaxDepth: " << maxDepth
        << "\nOverflows: " << overflows << "\nUnderflows: " << underflows << "\n";
}
// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
