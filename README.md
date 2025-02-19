# command-wiz
a simple tool for querying shell command in terminal

## Configuration

1. Set the OpenAI API Key  
```bash
export OPENAI_API_KEY="your-api-key-here"
```

2. Modify the Configuration in cw.py  
You can adjust the BASE_URL and MODEL parameters in cw.py as needed to connect to the appropriate service and specify the model.

3. Grant Execution Permission to cw.py  
```bash
chmod +x cw.py
```

4. Place the cw File in the System Path  
To be able to call the cw command directly from the terminal, copy the generated cw file to the /usr/local/bin directory.  
For example:  
```bash
sudo cp cw /usr/local/bin
```

## Example usage
```console
$ cw find all python file in the folder
find . -name "*.py"
```
