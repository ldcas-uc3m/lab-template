# Lab report template



## Compilation
This report follows [GUL's UC3M LaTeX report template](https://github.com/guluc3m/report-template/). More information and updated versions on the original repository.

First you must install [LaTeX](https://www.latex-project.org/).

- For Linux, install `texlive-full` (takes a while).
- For Windows, install [MiKTeX](https://miktex.org/download#win), ensure it's added to `PATH`, and install [Strawberry Perl](https://strawberryperl.com/).  
  With [winget](https://github.com/microsoft/winget-cli):
  ```powershell
  winget install MiKTeX.MiKTeX StrawberryPerl.StrawberryPerl
  ```
  Once you install MiKTeX, open it, go to `Update`, and update all packages.
- For MacOS, install [MacTeX](https://www.tug.org/mactex/mactex-download.html).  
    With [brew](https://brew.sh):
    ```
    brew install --cask mactex
    ```

> [!IMPORTANT]
> As we'll use SVG files, you'll need to install [Inkscape](https://inkscape.org/).
> If you're in Windows, make sure to add the executable to your PATH (typically located in `C:\Program Files\Inkscape\bin\`).

To compile the report, use the command:
```
latexmk -cd -shell-escape -pdf report.tex
```

> [!TIP]
> Optionally, you can specify the output directory with the `-outdir` parameter, e.g. `-outdir=build`
> 
> If issues arise, ensure all folders and subfolders exist (e.g. `build/parts/`).



## VS Code
Some useful extensions:
- [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)

> [!IMPORTANT]
> If you are using the extension, please set `-shell-escape` (see [LaTeX Workshop FAQ](https://github.com/James-Yu/LaTeX-Workshop/wiki/FAQ#how-to-pass--shell-escape-to-latexmk))

> [!TIP]
> You can change the output directory in the `latex-workshop.latex.outDir`, setting it for example to `%DIR%/build` (see [LaTeX Workshop Wiki](https://github.com/James-Yu/LaTeX-Workshop/wiki/View#latex-workshoplatexoutdir)).  
> 
> If issues arise, ensure all folders and subfolders exist (e.g. `build/parts/`).

> [!TIP]
> You can enable the wordcount by setting `latex-workshop.wordcount` to `onSave` in the settings. More information [here](https://github.com/James-Yu/LaTeX-Workshop/wiki/ExtraFeatures#counting-words)
- [LTeX+](https://marketplace.visualstudio.com/items?itemName=ltex-plus.vscode-ltex-plus): Grammar checker.
> [!TIP]
> You can change the language through the `ltex.language` setting in VS Code settings.
