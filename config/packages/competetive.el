;; -*- coding: utf-8; lexical-binding: t -*-

;; Here is a set of functions I am using for competitive programming
(defvar wl/competitive-last-file nil)

(tasks-register
 (make-task
  :name "Competitive::Compile-C++"
  :visible t
  :dependencies '()
  :function
  (lambda ()
    (let* ((filename (buffer-file-name))
           (base (file-name-sans-extension filename))
           (out (concat base ".out")))
      (setq wl/competitive-last-file out)
      (compilation-start
       (concat
        "g++ "
        "-Wall "
        "-Wextra "
        "-Wpedantic "
        "-std=c++20 "
        "-g "
        filename
        " -o "
        out))))))

(tasks-register
 (make-task
  :name "Competitive::Run-C++"
  :visible t
  :dependencies '()
  :function
  (lambda ()
    (let ((dir (file-name-directory wl/competitive-last-file))
          (file (concat "./" (file-name-base wl/competitive-last-file) ".out")))
      (vterm-other-window)
      (vterm-send-string (concat "cd " dir))
      (vterm-send-return)
      (vterm-send-string (concat file "\n"))))))

(tasks-register
 (make-task
  :name "Competitive::Debug-C++"
  :visible t
  :dependencies '()
  :function
  (lambda ()
    (let ((dir (file-name-directory wl/competitive-last-file))
          (file (concat (file-name-base wl/competitive-last-file) ".out")))
      (vterm-other-window)
      (vterm-send-string (concat "cd " dir))
      (vterm-send-return)
      (vterm-send-string
       (concat
        (if (eq system-type 'darwin)
            "lldb "
          "gdb -q ")
        file
        "\n"))))))

(define-skeleton compprog-cpp-skeleton
  "C++ compprog template"
  nil
  "#include <bits/stdc++.h>\n"
  "using namespace std;\n"
  "\n"
  "typedef long long ll;\n"
  "typedef long double dl;\n"
  "typedef pair<ll, ll> pll;\n"
  "#define vc vector\n"
  "\n"
  "int main() {\n"
  "    ios::sync_with_stdio(false);\n"
  "    cin.tie(nullptr);\n"
  "    cout.tie(nullptr);\n"
  "\n"
  "\n"
  "}\n")
