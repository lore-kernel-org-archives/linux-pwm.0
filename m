From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/58] ARM: at91: rework Atmel TCB drivers
Date: Thu, 6 Jul 2017 08:40:55 +0200
Message-ID: <20170706064055.GE16144@ulmo.fritz.box>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32819 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdGFGlA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Jul 2017 02:41:00 -0400
Content-Disposition: inline
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Antoine Aubert <a.aubert@overkiz.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>, Fabio Porcedda <fabio.porcedda@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Gregory Hermant <gregory.hermant@calao-systems.com>, Joachim Eastwood <manabian@gmail.com>, linux-pwm@vger.kernel.org, Marek Vasut <marex@denx.de>, Martin Reimann <martin.reimann@egnite.de>, Peter Rosin <peda@axentia.se>, Raashid Muhammed <raashidmuhammed@zilogic.com>, Rob Herring <robh+dt@kernel.org>, Rodolfo Giometti <giometti@linux.it>, Se


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 11:50:41PM +0200, Alexandre Belloni wrote:
> Hi,
>=20
> This series reworks the Atmel Timer counter Block drivers. Those blocks
> each have 3 counters with 2 channels each and can be used for
> multiple functions:
>  - timers
>  - PWMs
>  - Quadrature decoders
>  - Stepper motor counters
>=20
> Up until now, each TCB was fully used by each driver, possibly wasting
> counters/channels.
>=20
> There is a second issue motivating that rework. Until now, the PIT is
> still used to boot then later in the boot sequence, the clocksource is
> switched to the TCB. This ends up not working well with preempt-rt
> because on some SoCs, the PIT interrupt is shared with the DBGU uart.
> When using preempt-rt the interrupt flags for the PIT and the DBGU end
> up being incompatible.
>=20
> The rework breaks the DT ABI. Backward compatibility can be kept by
> keeping tcb_clksrc and atmel_tclib but as AVR32 is now gone from the
> kernel, I don't think it makes much sense to keep them.
>=20
> Also, there is no other choice than breaking the mainly unused
> pwm-atmel-tcb binding. Only the kizbox is actually using it.
>=20
> I think the bindings are now ok and I hope we can take the DT changes
> for 4.13.

Has anyone volunteered to pick this up? What are the dependencies here
and how did you plan to get this merged?

Thierry

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld23UACgkQ3SOs138+
s6F+DA/+KdAUGMhEpPB0KMsaOP7UCTYmwrqhfC2hIoQwOCpmFXe9e3W+W2cKAHuz
2VTtVmcJY1wCASJM0xB/a2g6WRHUELLgUbU9uaAfPtwKOIwNoeMyBtgp5oNLx+4s
GDm/jevMQcoTG00vNyRKNi86DJxM/ZR2X4msAO8f+nuByj0KB3/OTW6sYq8lzS8N
/jJ91nFrXIhsBdwO8k+xQkF4VUCVA9rKKg/dgUMw8uiTXfmbj3RbKyOOfjGjLW+w
xngjhI2pNRg5n3A5Exh5jVouf4XtNn3qhvviGjkgaBMEUUIXdXuqi+AUqTdxqhl/
qXrPSfWh45GHqZO10GOhc9sOexF+vF7eVEFWXug8w/FsupRMRlILvTIQt73Mv4Iu
+9Jp2jdQzKNM/bS+EBnDTF6JQjoF1VSW7i1xxFtD7WsIfsvw7K9ZTEBFFAaoIbEU
UTrvl4ygkmgIJtNxseifPZWbUKVAp/g2/Rj1/lmLYlN4CUR0fNAArCjyC8VYO5fv
48BMuZGMPYMGrdE/z+CGL4c94KHzBlMlQciUMHaUbi131yzdOlMOI2+WmmH1DscZ
vXq8CpHdU8wg4RaYEP/ICMi24uuKRCojgcAIDItTw+1p8iwjRdZy5yT3jlW1bQKz
llFDpjkUaBBxeE9kdx8IzS4YCkhq5H8JgWzh/WKMgJu/PUd11Jw=
=c4jJ
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
