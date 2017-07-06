From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 0/3] pwm: sun4i: switch to atomic PWM
Date: Thu, 6 Jul 2017 08:49:22 +0200
Message-ID: <20170706064922.GI16144@ulmo.fritz.box>
References: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+PbGPm1eXpwOoWkI"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34085 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbdGFGt0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 02:49:26 -0400
Content-Disposition: inline
In-Reply-To: <20170530193209.19247-1-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Olliver Schinagl <o.schinagl@ultimaker.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Liu <net147@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--+PbGPm1eXpwOoWkI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 09:32:06PM +0200, Alexandre Belloni wrote:
> Switch to atomic PWM. The main goal is to properly wait for a period befo=
re
> disabling a channel to ensure the correct level is set on the output.
>=20
> Changes in v2:
>  - fixed remaining checkpatch warnings
>  - split the series to ease reviews
>  - changed the delay handling to ensure the proper amount of time has ela=
psed
>    before disabling a channel
>  - dropped RDY bit handling as it doesn't have any real effect.
>=20
> Alexandre Belloni (3):
>   pwm: sun4i: improve hardware read out
>   pwm: sun4i: switch to atomic PWM
>   pwm: sun4i: drop legacy callbacks
>=20
>  drivers/pwm/pwm-sun4i.c | 263 +++++++++++++++++++++++++++---------------=
------
>  1 file changed, 148 insertions(+), 115 deletions(-)

Series applied, though you could've just squashed together patches 2 and
3 because they don't make sense apart.

Thierry

--+PbGPm1eXpwOoWkI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld3XIACgkQ3SOs138+
s6HJDQ//Yec+dKL6q6UdD5aq9g91t6BDQhpETfDXks7QiR4LOef5lUMXyQCUxrgh
iEyZ7iSqfoMGLyIcqfpnpyFfB3gckKOj3s6jJpeeV+t3Tv2GdINmwW3mJ+6LsM9Q
SqJcuyh9CJ9C5Ef+nsBhWhXQkbFTQ9fevuIpB4AuCo16Yx2DKKsfmDvtJjLZTM0F
LFueYK+++gKdMpKVsVXeRv+ZrCbwwdN1v5yvTCM7NWrIsnoIx6qfUhvmouNaKzXx
zUrcyycHl1G7avd9PNnCqF8HebO+KBeUPfph7TRO6m8G2enrTIl5TRZ0dXPzDP0h
+lcFGXiP6xW1NiLKvzdf6biF0/T5sYA9qnml3S2DLEr8wymp+FSMaPl3vNjnocSS
gAcWI+kc9jWLNrWfe181ZCkxjn70BbDzqSSFULaVKgL3XjfVH6DGjvT+7HAU/nwx
b+YLZvd0JGPDdkDTZfwncIgVttl+Yk5bluq/qh0dSFm3XoXa4w5/U/Yt+t4U3nIE
aKUJRF3lvHWXzCqS8Qu6xLohqV0jEhaFSVI+rMPoceQrhYjxKPCUv9CeN3mv12fi
MqG6b0L9y2l6r3JLNF1GwK1/UkAe/fJsBUgIWSvNZ4RB9/JnwkW34wwJDH4RjzKT
PIcg3V5lCN+wSnRnGOIZaEOpmSGJO64qR84h1DVe5o0pMxT0a3M=
=7yi+
-----END PGP SIGNATURE-----

--+PbGPm1eXpwOoWkI--
