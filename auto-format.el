;;; auto-format.el --- Auto format Python code

;;; Commentary:
;; Formats code to follow the PEP 8 style guide (using autopep8).
;; Formats docstrings to follow PEP 257 (using docformatter).
;; Makes strings all use the same type of quote where possible (using unify).

;;; Code:

(defcustom python-pyformat-path (executable-find "pyformat")
  "Pyformat executable path.

Allows working with a virtualenv without actually adding support
for it."
  :group 'python
  :type 'string)

(defun python-auto-format ()
  "Use Pyformat to format code & docstrings.

$ pyformat --in-place not_formateed.py"
  (interactive)
  (when (eq major-mode 'python-mode)
    (shell-command (format "%s --in-place %s"
			   python-pyformat-path
			   (shell-quote-argument (buffer-file-name))))
    (revert-buffer t t t))
  nil)

(eval-after-load 'python
  '(if python-pyformat-path
       (add-hook 'before-save-hook 'python-auto-format)
     (message "Unable to find pyformat. Configure `python-pyformat-path`")))

(provide 'auto-format)

;;; auto-format.el ends here
