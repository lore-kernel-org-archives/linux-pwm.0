From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Mon, 9 Dec 2013 09:52:27 +0100
Message-ID: <20131209085225.GA27868@ulmo.nvidia.com>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33554 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932470Ab3LIIxg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2013 03:53:36 -0500
Received: by mail-bk0-f46.google.com with SMTP id u15so1244147bkz.33
        for <linux-pwm@vger.kernel.org>; Mon, 09 Dec 2013 00:53:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: randy <lxr1234@hotmail.com>
Cc: linux-pwm@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 01:22:02AM +0800, randy wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> The dts for my board tiny4412 is ready, in my board, the pwm 0 is
> connect to a buzzer. I want to test whether it works, but I don't know
> any test util. As I have a oscillograph, there is no problem for me to
> measure whether the output is correct.
> Thanks

You can use the sysfs interface to easily test the PWM functionality.
The documentation for that is in Documentation/pwm.txt and
Documentation/ABI/testing/sysfs-class-pwm.

Generally this should work somewhat like this:

	# echo 0 > /sys/class/pwm/pwmchip0/export
	# echo 50000 > /sys/class/pwm/pwmchip0/pwm0/period
	# echo 25000 > /sys/class/pwm/pwmchip0/pwm0/duty_cycle
	# echo 1 > /sys/class/pwm/pwmchip0/pwm0/enable

Which should configure PWM 0 to run at a period of 50000 ns and a 50%
duty-cycle.

	# echo 0 > /sys/class/pwm/pwmchip0/pwm0/disable

Stops the PWM signal and when you're done with all the testing you can
export the PWM (so that it can be reused):

	# echo 0 > /sys/class/pwm/pwmchip0/unexport

Thierry

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpYTJAAoJEN0jrNd/PrOhbg4P/itgNZmcLVCZUhdZtzDcVyTg
JSTizu4GOaLRmI6lVjyVrHssrQP9WuPTYN81IBOerJ/PCb3+y+bH1VUOXM4VWSfP
wtIehOSWapcZ4Xm0gSSxKCanC8fXH1SypVjdJtENxG9ua+B7AeJHz8sBJPCj2Ei4
A/BuAYOM43TAh+PU9kmh6gKnf+gk+cYODNyzKM8bmxLt2vf+z8VkvDgWBIRCXiAC
PTCRWnPWvGny9ak1Gja3COvbgI3HzTN5IwL60HhMFMJU7vHKw+aSsSIRxL2jJz8Y
mqqkHNKEp6fi4vAsSlj0/tRhbBn9NWH3RyP2YSBYcah+6kITG5OKbntdl/ytWHUJ
JPU0XQaJUJuryNcrkuNqakPF+pDoTR4bHldEN5uRiavxRpo/9RtBYTD08RJoxdU8
Opr7DiM4kVK0iz+zSkZpTbLIrZdH4hw9hIcpk7AB6TDcewqs/t70yDnkgDFzoHqI
l9so+SUJqK+xvSSynJX6QW/3nagODcSwuhfWx7OdInBs1KlLgd2hD+b9dLy+NXFp
hJdS4NCgD5xJxP3zvYYHqmnIsfavOVLDO/qxuGvPNWBMReg94oHZR2CMVKbTxbAo
pr9PNnabwjSB64pa1h9zrjIAmsAv8DWzkupuT3WXmdYaDuXquULwZKqhMLn3dQR0
F1BRPywovD2fWdfT5HIo
=sDuV
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
