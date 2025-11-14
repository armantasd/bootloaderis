extern void print(char buffer[], void* argv);
extern void itoa(int a, char buffer[]);

void kernel_main()
{
	int args[] = {10, 12};
	print("SIGMA %i,%i", args);
	return;
}
