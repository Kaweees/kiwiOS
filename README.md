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

<a href="https://github.com/Kaweees/c99-template">
  <img alt="C Logo" src="assets/img/c.svg" align="right" width="150">
</a>

<div align="left">
  <h1><em><a href="https://miguelvf.dev/blog/dotfiles/compendium">~c99-template</a></em></h1>
</div>

<!-- ABOUT THE PROJECT -->

A template for developing production-ready C99 applications.

### Built With

[![C][C-shield]][C-url]
[![GitHub Actions][github-actions-shield]][github-actions-url]

<!-- GETTING STARTED -->

## Getting Started

### Prerequisites

Before attempting to build this project, make sure you have [GNU Make](https://www.gnu.org/software/make/) installed on your machine.

### Installation

To get a local copy of the project up and running on your machine, follow these simple steps:

1. Clone the project repository

   ```sh
   git clone https://github.com/Kaweees/c99-template.git
   cd c99-template
   ```

2. Build and execute the project

   ```sh
   clear && make && ./target/release/targetname
   ```

<!-- PROJECT FILE STRUCTURE -->

## Project Structure

```sh
.c99-template/
├── .github/                       - GitHub Actions CI/CD workflows
├── include/                       - Project header files
├── src/                           - Project source files
│   └── main.c                     - Entry point, main function
├── Makefile                       - Build script
├── LICENSE                        - Project license
└── README.md                      - You are here
```

## License

The source code for this project is distributed under the terms of the MIT License, as I firmly believe that collaborating on free and open-source software fosters innovations that mutually and equitably beneficial to both collaborators and users alike. See [`LICENSE`](./LICENSE) for details and more information.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/Kaweees/c99-template.svg?style=for-the-badge
[contributors-url]: https://github.com/Kaweees/c99-template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Kaweees/c99-template.svg?style=for-the-badge
[forks-url]: https://github.com/Kaweees/c99-template/network/members
[stars-shield]: https://img.shields.io/github/stars/Kaweees/c99-template.svg?style=for-the-badge
[stars-url]: https://github.com/Kaweees/c99-template/stargazers

<!-- MARKDOWN SHIELD BAGDES & LINKS -->
<!-- https://github.com/Ileriayo/markdown-badges -->

[C-shield]: https://img.shields.io/badge/C-%23008080.svg?style=for-the-badge&logo=c&logoColor=306998&labelColor=222222&color=306998
[C-url]: https://en.wikipedia.org/wiki/C_(programming_language)
[github-actions-shield]: https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=2671E5&labelColor=222222&color=2671E5
[github-actions-url]: https://github.com/features/actions
