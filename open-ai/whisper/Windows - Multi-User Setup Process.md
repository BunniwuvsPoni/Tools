# Desktop setup process for Windows 10 (as at 04/11/2023)
	1. Install python (v3.10.11, OpenAI - Whisper does not currently support newer version of Python...)
		a. Add python.exe to PATH
		b. Customize installation
			i. For all users
		c. Install Python 3.10 for all users
		d. Install
	2. Run PowerShell as administrator
		a. Run updates: pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
		b. Check for outdated packages: pip.exe list --outdated
		c. Upgrade any outstanding outdated packages: pip.exe install (package) --upgrade
		d. Install OpenAI - Whisper: pip install -U openai-whisper
			i. Be sure to install this last as this program's compatibility may require older versions of pip packages similar to it's requirement for python...
	3. Install Microsoft Visual C++ Redistributable (if required): https://aka.ms/vs/16/release/vc_redist.x64.exe
	4. Install FFMPEG with PATH configured
		a. Copy FFMPEG to "C:\Program Files\FFMPEG\"
		b. Go to 
			i. Settings
			ii. About
			iii. Advanced System Settings
			iv. Environment Variables…
			v. Path
				1) Add "C:\Program Files\FFMPEG\bin"
