extern void prtchr(char c, int index);

void print(char* buffer, void* argv)
{
	char character = *buffer;
	buffer++;
	char character2 = *buffer;

	int i = 0;
	while (buffer[i] != '\0')
	{
		prtchr(buffer[i], i*2);
		i++;
	}
	return;
}
