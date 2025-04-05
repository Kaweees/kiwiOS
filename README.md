<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
<div align="left">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]

</div>

<a href="https://github.com/Kaweees/kiwiOS">
  <img alt="C Logo" src="assets/img/c.svg" align="right" width="150">
</a>

<div align="left">
  <h1><em><a href="https://miguelvf.dev/blog/dotfiles/compendium">~kiwiOS</a></em></h1>
</div>

<!-- ABOUT THE PROJECT -->

An operating system written in C99.

### Built With

[![C][C-shield]][C-url]
[![NixOS][NixOS-shield]][NixOS-url]
[![GNU Make][GNU-Make-shield]][GNU-Make-url]
[![GitHub Actions][github-actions-shield]][github-actions-url]

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

Before attempting to build this project, make sure you have [GNU Make](https://www.gnu.org/software/make/), [QEMU for x86_64](https://www.qemu.org), a C compiler, and a cross-compiler for x86_64 installed on your machine. These can be also installed via the project's [Nix](https://nixos.org/download.html) environment.

### Installation

To get a local copy of the project up and running on your machine, follow these simple steps:

1. Clone the project repository

   ```sh
   git clone https://github.com/Kaweees/kiwiOS.git
   cd kiwiOS
   ```

2. Install the project dependencies

   ```sh
   nix-shell
   ```

3. Build and execute the project

   ```sh
   clear && make emulate
   ```

<!-- PROJECT FILE STRUCTURE -->

## Project Structure

```sh
.kiwiOS/
├── .github/                       - GitHub Actions CI/CD workflows
├── include/                       - Project header files
├── src/                           - Project source files
│   └── main.c                     - Entry point, main function
├── Makefile                       - Build script
├── LICENSE                        - Project license
└── README.md                      - You are here
```

## License

The source code for this project is distributed under the terms of the GNU General Public License v3.0, as I firmly believe that collaborating on free and open-source software fosters innovations that mutually and equitably beneficial to both collaborators and users alike. See [`LICENSE`](./LICENSE) for details and more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Kaweees/kiwiOS.svg?style=for-the-badge
[contributors-url]: https://github.com/Kaweees/kiwiOS/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Kaweees/kiwiOS.svg?style=for-the-badge
[forks-url]: https://github.com/Kaweees/kiwiOS/network/members
[stars-shield]: https://img.shields.io/github/stars/Kaweees/kiwiOS.svg?style=for-the-badge
[stars-url]: https://github.com/Kaweees/kiwiOS/stargazers

<!-- MARKDOWN SHIELD BAGDES & LINKS -->
<!-- https://github.com/Ileriayo/markdown-badges -->

[C-shield]: https://img.shields.io/badge/C-%23008080.svg?style=for-the-badge&logo=c&logoColor=306998&labelColor=222222&color=306998
[C-url]: https://en.wikipedia.org/wiki/C_(programming_language)
[NixOS-shield]: https://img.shields.io/badge/NIX-%23008080.svg?style=for-the-badge&logo=NixOS&logoColor=5277C3&labelColor=222222&color=5277C3
[NixOS-url]: https://nixos.org/
[GNU-Make-shield]: https://img.shields.io/badge/GNU%20Make-%23008080.svg?style=for-the-badge&logo=gnu&logoColor=A42E2B&labelColor=222222&color=A42E2B
[GNU-Make-url]: https://www.gnu.org/software/make/
[github-actions-shield]: https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=2671E5&labelColor=222222&color=2671E5
[github-actions-url]: https://github.com/features/actions
