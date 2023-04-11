# Desktop setup process (as at 04/11/2023)
	1. Install python (v3.10.11)
		a. Add python.exe to PATH
		b. Customize installation
			i. For all users
		c. Install Python 3.10 for all users
		d. Install
	2. Run PowerShell as administrator
		a. Install whisper: pip install -U openai-whisper
		b. Run updates: pip freeze | %{$_.split('==')[0]} | %{pip install --upgrade $_}
		c. Check for outdated packages: pip.exe list --outdated
		d. Upgrade any outstanding outdated packages: pip.exe install (package) --upgrade
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
