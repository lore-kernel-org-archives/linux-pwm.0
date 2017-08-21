From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] extend PWM framework to support PWM dead-times
Date: Mon, 21 Aug 2017 10:25:27 +0200
Message-ID: <20170821082527.GQ18996@ulmo>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34792 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdHUIZb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 04:25:31 -0400
Content-Disposition: inline
In-Reply-To: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 03:15:51PM +0300, Claudiu Beznea wrote:
> Hi all,
>=20
> Please give feedback on these patches which extends the PWM
> framework in order to support multiple PWM signal types.
> Since I didn't receive any inputs on RFC series I'm resending it as
> normal patch series.
>=20
> The current patch series add the following PWM signal types:
> - PWM complementary signals
> - PWM push-pull signal
>=20
> Definition of PWM complementary mode:
> For a PWM controllers with more than one outputs per PWM channel,
> e.g. with 2 outputs per PWM channels, the PWM complementary signals
> have opposite levels, same duration and same starting times,
> as in the following diagram:
>=20
>         __    __    __    __
> PWMH __|  |__|  |__|  |__|  |__
>      __    __    __    __    __
> PWML   |__|  |__|  |__|  |__|
>        <--T-->
> Where T is the signal period.
>=20
> Definition of PWM push-pull mode:
> For PWM controllers with more than one outputs per PWM channel,
> e.g. with 2 outputs per PWM channel, the PWM push-pull signals
> have same levels, same duration and are delayed until the begining
> of the next period, as in the following diagram:
>=20
>         __          __
> PWMH __|  |________|  |________
>               __          __
> PWML ________|  |________|  |__
>        <--T-->
>=20
> Where T is the signal period.
>=20
> These output signals could be configured by setting PWM mode
> (a new input in sysfs has been added in order to support this
> operation).
>=20
> root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/pwm/=
pwmchip0/pwm2# ls -l
> -r--r--r--    1 root     root          4096 Feb  9 10:54 capture
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 period
> -rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
> drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
> -rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent
>=20
> The PWM push-pull mode could be usefull in applications like
> half bridge converters.

Sorry for taking an absurdly long time to get back to you on this.

One problem I see with this is that the PWM framework is built on the
assumption that we have a single output per PWM channel. This becomes
important when you start adding features such as this because now the
users have no way of determining whether or not the PWM they retrieve
will actually be able to do what they want.

For example, let's say you have a half bridge converter driver in the
kernel and it does a pwm_get() to obtain a PWM to use. There's nothing
preventing it from using a simple one-output PWM and there's no way to
check that we're actually doing something wrong.

I think any in-kernel API would have to be more fully-featured,
otherwise we're bound to run into problems. At the very least I think
we'd have to expose some sort of capabilities list.

A possibly simpler approach might be to restrict this to the driver that
you need this for. It looks like you will be mainly using this via sysfs
and in that case you might be able to just extend what information is
exposed in sysfs for the particular PWM you're dealing with.

Thierry

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmamPUACgkQ3SOs138+
s6HSpA/+Oucci/GwlcUsWooTws9Hy1/sGANWSNBNhYAPxfRtL2axFNVSAvJtRKsF
9pdclYG2vZk4Q16N6fYqhL622b3odtfVeontc++wtKq5WcvbjC5SlvYCYyKhAERM
iKk3grKVjBt0UJY8AHzW4We6dOEX7YaagwkLj9J2RoZycm9U6xlJOwLnwWSJPhLf
AkijbRzmrsK+cCvUK3bmPpSRpR99uF+HqCU5SNjV1VnSSfVT8vv05N/zMvxrP9iG
brS+cowxW1xd8rd0BzKvlYBK8MYy0FSk03eP4zqLxAfzPn9PgrQX+UDN+R9/BpcC
qflRQE7Fj+zr3xCy2MHLtWBflXmuvvdUsmQgbHblO1G7y5QCHhC2Ms0sPbtgKfqJ
BrVZVDR2DaHMvgp2npZ8Psj828zh5znRAUb9oWbbLbLy8P6RIFge9rEV/yQL3tso
jrtVilYXvNqYKO5AQbvXyE1tLyjnCLeR7UKIqJEYn+MuKku+13t5yiDT6qbf0vac
XweOKQ9B2cHyQ29I2tsxopeCeP7jPSLoj1nt388GvQDU+5XgKVkzTFPGpaVHUpeN
5AkX5zFeP9NXMaSUhGQX6gBXl00FTjdo/1mPuKNZrNe4DiTKFwoosDLypPpUfNc6
+Pd2tlT91gVXcrEbQvn2iqsXxStw+7fAbgqNJ/bd208jMNFBmFU=
=/6FC
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
