From: randy <lxr1234@hotmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Mon, 9 Dec 2013 21:06:37 +0800
Message-ID: <BLU0-SMTP30A197FE32DA623BBA7713ADD30@phx.gbl>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl> <20131209085225.GA27868@ulmo.nvidia.com> <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl> <20131209115523.GA17693@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from blu0-omc4-s11.blu0.hotmail.com ([65.55.111.150]:48698 "EHLO
	blu0-omc4-s11.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932548Ab3LING6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 9 Dec 2013 08:06:58 -0500
In-Reply-To: <20131209115523.GA17693@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

=E4=BA=8E 2013=E5=B9=B412=E6=9C=8809=E6=97=A5 19:55, Thierry Reding =E5=
=86=99=E9=81=93:
> On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote: [...]
>> Actually, I don't know whether the pwm works or not. In dmesg, I=20
>> saw: [  853.690000] samsung-pwm 139d0000.pwm: tried to request=20
>> PWM channel 0 without output [  876.930000] samsung-pwm=20
>> 139d0000.pwm: tried to request PWM channel 0 without output [=20
>> 879.615000] samsung-pwm 139d0000.pwm: tried to request PWM=20
>> channel 1 without output
>>=20
>> in my dts, I only add =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
>> pwm@139D0000 { status =3D "okay";
I added
samsung,pwm-outputs =3D <0>;
>> }; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D is it enough to make pwm=20
>> work, if the driver in kernel has been correct.
>=20
> It seems like you're missing the samsung,pwm-outputs property (see
>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt).
>=20
> Thierry

Well I have make it output to channel 0 now. But it doesn't work with
the config below. As it is a buzzer, I change your config.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/enable

1
root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/period
1000000
root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle
500000
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I have used a function generator with Vpp=3D2.2, it works.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJSpcBdAAoJEPb4VsMIzTzir6kH/izw1ALJVXhEw3C28tj5grKk
zgJ5eTh4fiATR6nMg9539YTmkH65nmrK7C7QdrwAmsb9t/lnX5ulcZUZmrrRKE+j
03r+L45PH7Vqx7ZMt3UO74jMThs9+vHFY+Kj0dALoxZsnBS1aaheGaHuShrcTbpG
ZaKOZs7lSuxuZsWKr1njodYG3hL3z418JISII7DQ7J8RHYQF88JwIAMPw8Ybt1U8
7J2qA4DDKmQmL/kPQqTiPMfj64fcZ6E8jtLY5jZ0OLN78T8+juHrm+8l5xBm0AFa
3HNzLrmyAKPYD4yjPI8LYdNhk3EVVOaxA+lcDy26aYJ1PpIHxHuFgGdvqM47eq4=3D
=3D1SNZ
-----END PGP SIGNATURE-----
