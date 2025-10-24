Name:           count-etc-files
Version:        1.0
Release:        1%{?dist}
Summary:        Bash script to count files in /etc excluding directories and links

License:        MIT
URL:            https://github.com/${{ github.repository }}
Source0:        count_etc_files.sh

BuildArch:      noarch

%description
This package contains a Bash script that counts the number of files in /etc,
excluding directories and symbolic links.

%prep
# No build prep needed

%build
# No build step needed

%install
mkdir -p %{buildroot}/usr/local/bin
install -m 0755 %{SOURCE0} %{buildroot}/usr/local/bin/count_etc_files.sh

%files
/usr/local/bin/count_etc_files.sh

%changelog
* Fri Oct 24 2025 Your Name <you@example.com> 1.0-1
- Initial RPM release
