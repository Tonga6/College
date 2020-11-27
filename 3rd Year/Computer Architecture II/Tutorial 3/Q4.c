int main(int argc, char *argv[]) {
    computepascal(30, 20);
}

int computepascal(int row,int position)
{
    if(position==1)
    {
    return 1;
    }

    else if(position==row)
    {
        return 1;
    }

    else
    {
        return computepascal(row−1,position)+computepascal(row−1,position−1);
    }
}