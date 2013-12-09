From: randy <lxr1234@hotmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Mon, 9 Dec 2013 19:04:12 +0800
Message-ID: <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl> <20131209085225.GA27868@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from blu0-omc4-s14.blu0.hotmail.com ([65.55.111.153]:2286 "EHLO
	blu0-omc4-s14.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932662Ab3LILER (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2013 06:04:17 -0500
In-Reply-To: <20131209085225.GA27868@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

? 2013?12?09? 16:52, Thierry Reding ??:
> On Mon, Dec 09, 2013 at 01:22:02AM +0800, randy wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> The dts for my board tiny4412 is ready, in my board, the pwm 0
>> is connect to a buzzer. I want to test whether it works, but I
>> don't know any test util. As I have a oscillograph, there is no
>> problem for me to measure whether the output is correct. Thanks
> 
> You can use the sysfs interface to easily test the PWM
> functionality. The documentation for that is in
> Documentation/pwm.txt and 
> Documentation/ABI/testing/sysfs-class-pwm.
> 
I am sorry for I didn't notice that documents.
> Generally this should work somewhat like this:
> 
> # echo 0 > /sys/class/pwm/pwmchip0/export
It seems can't work.
root@mifu:~# LANG=C echo 0 > /sys/class/pwm/pwmchip0/export
- -bash: echo: write error: Invalid argument

> # echo 50000 > /sys/class/pwm/pwmchip0/pwm0/period # echo 25000 >
> /sys/class/pwm/pwmchip0/pwm0/duty_cycle # echo 1 >
> /sys/class/pwm/pwmchip0/pwm0/enable
> 
> Which should configure PWM 0 to run at a period of 50000 ns and a
> 50% duty-cycle.
> 
> # echo 0 > /sys/class/pwm/pwmchip0/pwm0/disable
> 
> Stops the PWM signal and when you're done with all the testing you
> can export the PWM (so that it can be reused):
> 
> # echo 0 > /sys/class/pwm/pwmchip0/unexport
> 
> Thierry
Actually, I don't know whether the pwm works or not. In dmesg, I saw:
[  853.690000] samsung-pwm 139d0000.pwm: tried to request PWM channel
0 without output
[  876.930000] samsung-pwm 139d0000.pwm: tried to request PWM channel
0 without output
[  879.615000] samsung-pwm 139d0000.pwm: tried to request PWM channel
1 without output

in my dts, I only add
================================
pwm@139D0000 {
	status = "okay";
};
================================
is it enough to make pwm work, if the driver in kernel has been correct.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJSpaOrAAoJEPb4VsMIzTzicUkH+gJXR61k2/29tnZ01FtMprY+
LFO8taGcFn+P8rHXFm9v6911PBzJtuUtHgGhvjap2nb6cKpvxdGxPey/Jo3tyKwi
KuNsq1SJUcKBoS2RyqwbBEKkFsHHxtUQhu5IQ3ZjqtWIPsefhgUiPV0LlnmnxH6E
eLs9NCtuZx0Gb8PekKZRlNK15wAQNKouUFZvOAmeQ8/kR9cOYreWkmgrJUU5AaE2
qnBqGD8Z4V1I/0qrFlyx5upu87Z3thU6bAy4IxbJGSMb8/ESPsoCIps7EXFLlD3o
LWkPQNbE6a5I+78Ugb44JNgW6gR/fAFAXReupiteXeAfwhugQOIUSqdtBJNrp6I=
=w87N
-----END PGP SIGNATURE-----
