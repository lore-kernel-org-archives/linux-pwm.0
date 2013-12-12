From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Thu, 12 Dec 2013 13:22:04 +0100
Message-ID: <20131212122204.GG11524@ulmo.nvidia.com>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
 <20131209085225.GA27868@ulmo.nvidia.com>
 <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl>
 <20131209115523.GA17693@ulmo.nvidia.com>
 <BLU0-SMTP30A197FE32DA623BBA7713ADD30@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:54310 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab3LLMXU (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2013 07:23:20 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so833992bkb.40
        for <linux-pwm@vger.kernel.org>; Thu, 12 Dec 2013 04:23:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP30A197FE32DA623BBA7713ADD30@phx.gbl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: randy <lxr1234@hotmail.com>
Cc: linux-pwm@vger.kernel.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2013 at 09:06:37PM +0800, randy wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8809=E6=97=A5 19:55, Thierry Reding =E5=
=86=99=E9=81=93:
> > On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote: [...]
> >> Actually, I don't know whether the pwm works or not. In dmesg, I=20
> >> saw: [  853.690000] samsung-pwm 139d0000.pwm: tried to request=20
> >> PWM channel 0 without output [  876.930000] samsung-pwm=20
> >> 139d0000.pwm: tried to request PWM channel 0 without output [=20
> >> 879.615000] samsung-pwm 139d0000.pwm: tried to request PWM=20
> >> channel 1 without output
> >>=20
> >> in my dts, I only add =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> >> pwm@139D0000 { status =3D "okay";
> I added
> samsung,pwm-outputs =3D <0>;
> >> }; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D is it enough to make pwm=20
> >> work, if the driver in kernel has been correct.
> >=20
> > It seems like you're missing the samsung,pwm-outputs property (see
> >  Documentation/devicetree/bindings/pwm/pwm-samsung.txt).
> >=20
> > Thierry
>=20
> Well I have make it output to channel 0 now. But it doesn't work with
> the config below. As it is a buzzer, I change your config.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/enable
>=20
> 1
> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/period
> 1000000
> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle
> 500000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I have used a function generator with Vpp=3D2.2, it works.

Are you sure the function generator runs at the same frequency? Do you
have the possibility to check the PWM output with a scope to see if it
outputs anything?

Thierry

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqapsAAoJEN0jrNd/PrOhc0sP/iSQrl1x82mfQ2CFbv+vHm/Q
dbQDgnNgIqJz5eBQBqn8UeO/GWtFPB8kXWoejRRzWx9zBU9/QBw7BQRtlFd+nkZP
+XyZviNlDoaCMws9tf356Q+yU/zocZ9roG1+fXW4q91bA9UgDj8hf0wct0UU1y6r
X6DUujx+Jro1Q/jBa17YJLCzHNpo8kt5jlNfGYI7qEUvWAuTfoTsuL2FlSpWYGyT
BAhKAWex+wtbh7Hcse1dgz+SCO69ANwgFYL54aD6ZTKEP9zC297s+vsUoKLCA/af
VoAJkhyY018drtW3q63Rj+GKWs6I0hh3njTcdc+5/m4wF0409Wq5vqxfhatiaU7T
T0CLcuyY1/TqcQ0zwIB/4kvXM0bysA75hIYzgRBQAw/Nml31wpvoyyHMWKouOr6t
t6R140PIMfq4ZjTQf9BL91QtQZ5NetNPncG4sQCUDHbazz8G1bJaoNGtiINTH54Y
BSZJ5IWF5nBWmzehBoA7tZ+iB1o92xtYreOYjdf58jxJfZPXdV1wQRL6/BD8lOEp
EcF0aoTRlbUB9qL4Qz52vk2wECTG6kEkgIpFB0H49SkF01eSH5YEGurbl0V9C2YP
7wqfkogXoJRHz4ZZV6WLMVkk8pS6EaHbFI7RPphx7+ts/tSJCsWHMvJdSGG4sBPc
Y0zCiZiKOIlJJj8rLs8G
=v8rY
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
