import os
import subprocess
import sys


def main():
    # Changes working directory to script's location and executes Maven commands.
    current_dir = os.path.dirname(os.path.realpath(__file__))
    os.chdir(current_dir)

    args = " ".join(sys.argv[1:])
    command = f'mvn clean install && mvn exec:java -Dexec.args="{args}"'
    process = subprocess.Popen(
        command,
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        bufsize=1,  # Line buffered
        universal_newlines=True,
    )

    while True:
        if process.stdout is None:
            continue

        output = process.stdout.readline()
        if output == "" and process.poll() is not None:
            break
        if output:
            print(output.strip())

    if process.stderr is None:
        return

    stderr = process.stderr.read()
    if stderr:
        print("An error occurred:\n", stderr)


if __name__ == "__main__":
    main()
