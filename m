From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [exynos4412]How to test a pwm device, is there a test program?
Date: Sat, 14 Dec 2013 13:44:09 +0100
Message-ID: <20131214124408.GG17467@mithrandir>
References: <BLU0-SMTP2611DD3F4485EEE457F4920ADD00@phx.gbl>
 <20131209085225.GA27868@ulmo.nvidia.com>
 <BLU0-SMTP1651F8FA9BEEB0257791F09ADD30@phx.gbl>
 <20131209115523.GA17693@ulmo.nvidia.com>
 <BLU0-SMTP30A197FE32DA623BBA7713ADD30@phx.gbl>
 <20131212122204.GG11524@ulmo.nvidia.com>
 <BLU0-SMTP4320E405FB7D782DEAD759ADDC0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:33635 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab3LNMoN (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 14 Dec 2013 07:44:13 -0500
Received: by mail-bk0-f53.google.com with SMTP id na10so1729212bkb.40
        for <linux-pwm@vger.kernel.org>; Sat, 14 Dec 2013 04:44:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP4320E405FB7D782DEAD759ADDC0@phx.gbl>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: randy <lxr1234@hotmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-pwm@vger.kernel.org


--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2013 at 10:27:04PM +0800, randy wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8812=E6=97=A5 20:22, Thierry Reding =E5=
=86=99=E9=81=93:
> > On Mon, Dec 09, 2013 at 09:06:37PM +0800, randy wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>=20
> >> =E4=BA=8E 2013=E5=B9=B412=E6=9C=8809=E6=97=A5 19:55, Thierry Reding =
=E5=86=99=E9=81=93:
> >>> On Mon, Dec 09, 2013 at 07:04:12PM +0800, randy wrote: [...]
> >>>> Actually, I don't know whether the pwm works or not. In
> >>>> dmesg, I saw: [  853.690000] samsung-pwm 139d0000.pwm: tried
> >>>> to request PWM channel 0 without output [  876.930000]
> >>>> samsung-pwm 139d0000.pwm: tried to request PWM channel 0
> >>>> without output [ 879.615000] samsung-pwm 139d0000.pwm: tried
> >>>> to request PWM channel 1 without output
> >>>>=20
> >>>> in my dts, I only add =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> >>>> pwm@139D0000 { status =3D "okay";
> >> I added samsung,pwm-outputs =3D <0>;
> >>>> }; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D is it enough to make pwm
> >>>>  work, if the driver in kernel has been correct.
> >>>=20
> >>> It seems like you're missing the samsung,pwm-outputs property
> >>> (see Documentation/devicetree/bindings/pwm/pwm-samsung.txt).
> >>>=20
> >>> Thierry
> >>=20
> >> Well I have make it output to channel 0 now. But it doesn't work
> >> with the config below. As it is a buzzer, I change your config.=20
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D root@mif=
u:~# cat
> >> /sys/class/pwm/pwmchip0/pwm0/enable
> >>=20
> >> 1 root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/period 1000000=20
> >> root@mifu:~# cat /sys/class/pwm/pwmchip0/pwm0/duty_cycle 500000=20
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D I hav=
e used a
> >> function generator with Vpp=3D2.2, it works.
> >=20
> > Are you sure the function generator runs at the same frequency? Do
> > you
> Yes, I am sure.
> > have the possibility to check the PWM output with a scope to see if
> > it outputs anything?
> I have used a oscillograph to capture, nothing(althought it show some
> waves, but it is nosie single captured by autoset). I have a scope but
> I don't think there is any different.
> >=20
> > Thierry
> Ayaka
> Thank you

I don't know what else you could try, so I'm Cc'ing a couple of people
who have worked with this driver before, perhaps they can help resolve
this.

Thierry

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSrFKYAAoJEN0jrNd/PrOhpEwP/3zobCkSern3m8e9jiIRTGf8
B3vAV9r8R8XyfFgbfL0DA54JTk+eKP04kNnxRVZp0MBiYmFqIh8WCZe+zreOhWDd
IQM+/N7Dlk2xhp5yz/ahMQmQVeOINPF8repeVXHyPnZzjCIKFwDd8IEnnP7DddZ1
/aDREAoT484deMwDB/2DmfS9iZ5WuiPP1su3fUbCQvyoQdnsTb2gCWy98CrV+980
PCw007p0m+KZBQYaUpbn/9KMyUAVowAC6gjj6zfjTn2i30TCN/BkrCasMg043wDF
6H8JQ1fDL0XRA+wxbbefWXkNNJf9O8POHFXCo4IXT+dTj26PFiOFKjZN9R1BglK4
7UyihGZhs+9g3/BChEIK6SAcLeoS7TrwBY9M85FfXcEPpbPciCuWo3qFdj96iukg
zeZDokYA5NBYX1lXeWXMGN3grgCNUmN6zPevPrMmqeElz+8Sup8MELYFqD+Iyh9y
Efp+VzH54bNQEc7ybcAyFsSQ1eFFmUYi15smKI91dtfU0vIhYMmYOjzBV65iJhHR
YgHAmIbUFYHwtIEOiBPSDB2Fg+Y7MJTmNebYQ979mSZpbUK8KTI/JEtibu1vceVf
dUJO+iAPrVTtouXmS22P4zhKOntvJJFnP8AQxVtM/nJWSiesSQ7Cpwn/Fpd6gfff
esgY6RUfiaaQ8N2j5buJ
=ywju
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--
