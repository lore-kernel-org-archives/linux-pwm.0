From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Wed, 18 Jan 2017 11:41:05 +0100
Message-ID: <20170118104105.GH18989@ulmo.ba.sec>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34860 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdARKtR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2017 05:49:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id d140so3091113wmd.2
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2017 02:49:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 05:40:56PM +0300, Mika Westerberg wrote:
> The PCA9685 controller has full on/off bit for each PWM channel. Setting
> this bit bypasses the PWM control and the line works just as it would be a
> GPIO. Furthermore in Intel Galileo it is actually used as GPIO output for
> discreet muxes on the board.
>=20
> This patch adds GPIO output only support for the driver so that we can
> control the muxes on Galileo using standard GPIO interfaces available in
> the kernel. GPIO and PWM functionality is exclusive so only one can be
> active at a time on a single PWM channel.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 158 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 157 insertions(+), 1 deletion(-)

I've applied this with some minor stylistic fixups and removing the
PWM chip if the GPIO chip fails to register.

Please shout if that's not okay.

Thierry

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlh/Rj4ACgkQ3SOs138+
s6G8SQ//eBqpgO0m3AXz2eY9MlZ/0o4l0LGOxUap5I4uRzr1PpIQY3jyKOBHEkvc
HBg9H92uUYNWm2JI3740Dn1bgHVTdSArP4ESSXDMdDmqE0p57mYBvGuc/rsjs8aC
ngpNlg05pa8RzGFoQzC9pzBAxWY5Vzx8OcIBJN/Yy5n0SMWkXuuqQNLDdcmulLDn
R8wPlJXE/OWzOkcVNWQ3zqNLCpMh06QPl/LyjkFonUJezeFbirU9k7Vtt/hd5W3i
Z/NYrniZAw1iIrXpv7z0Of+0Xaej/6k3sAut2LtYfwDSHcAsAavWc803FetTkAr9
Xp19YMgoBk8YvOIZdDS6xrOGecpFZewx625dy+YCXHZudgZu1Y4DoBABwsyR8xQ1
5fzZANyRxlG29qwhi8J2/FBqwiJoMWi2+8aCMwvBkFyL9f/mmrtAuwNWXklWj9l4
xI4bFbhpgPtMA/iolCg94heLQTqEhcBBCWGDh0lcgzpEpU7rH2YsYDfVR/pPjvDT
m/FL90LZ7oYJ5Z705v7A8tSqXmquFecGcXWY5Wg3Uer72uBEzG0m+4P1cCNA0QV7
dsEDnkgjjaLLJvbMAm7yx2uW5nbxaQ4f2BJ6J9GdI7unBvxo2cbvExW7Q4KaalX4
RyBR7xXHf3eC16/PmUvmKt5NSB2YTtM+qSDscWjMK3GdgbqdKnc=
=e2sI
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
