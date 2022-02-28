/**
 * @file walk.c
 * @author Dalyn Dalton (dalyn.dalton@usu.edu)
 * @brief
 * @version 0.1
 * @date 2022-02-27
 *
 * Test walking program to help validate the grading scripts
 * @copyright Copyright (c) 2022
 *
 */

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int main()
{
    // INIT GRID
    char grid[10][10];
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            grid[i][j] = '.';
        }
    }

    char current = 'A';
    char dir;
    int x = 0,
        y = 0;
    int path[4] = {1, 1, 1, 1};
    srand(time(NULL));

    grid[x][y] = current++;

    while (path[0] || path[1] || path[2] || path[3])
    {
        dir = rand() % 4;
        if (current > 'Z')
            current = 'A';

        switch (dir)
        {
        case 0: // Up
            if (y - 1 >= 0)
            {
                if (grid[x][y - 1] == '.')
                {
                    grid[x][--y] = current++;
                    path[0] = path[1] = path[2] = path[3] = 1;
                }
                else
                    path[0] = 0;
            }
            else
                path[0] = 0;
            break;
        case 1: // Down
            if (y + 1 < 10)
            {
                if (grid[x][y + 1] == '.')
                {
                    grid[x][++y] = current++;
                    path[0] = path[1] = path[2] = path[3] = 1;
                }
                else
                    path[1] = 0;
            }
            else
                path[1] = 0;
            break;

        case 2: // Left
            if (x - 1 >= 0)
            {
                if (grid[x - 1][y] == '.')
                {
                    grid[--x][y] = current++;
                    path[0] = path[1] = path[2] = path[3] = 1;
                }
                else
                    path[2] = 0;
            }
            else
                path[2] = 0;
            break;

        case 3: // Up
            if (x + 1 < 10)
            {
                if (grid[x + 1][y] == '.')
                {
                    grid[++x][y] = current++;
                    path[0] = path[1] = path[2] = path[3] = 1;
                }
                else
                    path[3] = 0;
            }
            else
                path[3] = 0;
            break;
        default:
            break;
        }
    }
    for (int i = 0; i < 10; i++)
    {
        for (int j = 0; j < 10; j++)
        {
            printf("%c ", grid[i][j]);
        }
        printf("\n");
    }
}
