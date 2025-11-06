extern void prtchr(char c, int index);

void kernel_main()
{
	prtchr('S', 0);
	prtchr('I', 2);
	prtchr('G', 4);
	prtchr('M', 6);
	prtchr('A', 8);
	return;
}
