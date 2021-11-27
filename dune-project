(lang dune 2.9)

(version 0.0.1)

(name laius)

(license "GPL-3.0")

(authors "The laius programmers")

(maintainers "tim.arnouts@protonmail.com")

(source
 (github Tim-ats-d/Laius))

(bug_reports "https://github.com/Tim-ats-d/Laius/issues")

(homepage "https://github.com/Tim-ats-d/Laius")

(generate_opam_files true)

(package
 (name laius)
 (synopsis "Terminal-based presentations in pure OCaml ")
 (depends
  lambda-term
  (ocaml
   (>= 4.11))))
