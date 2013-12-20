From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: pwm-backlight: 3.13-rc1 regression for old arm machine
Date: Fri, 20 Dec 2013 10:47:03 +0100
Message-ID: <20131220094702.GD27787@ulmo.nvidia.com>
References: <87r49c6bea.fsf@free.fr>
 <20131217095658.GD13823@ulmo.nvidia.com>
 <87iounuy6e.fsf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:63348 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3LTJsg (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Dec 2013 04:48:36 -0500
Received: by mail-bk0-f48.google.com with SMTP id r7so1105482bkg.35
        for <linux-pwm@vger.kernel.org>; Fri, 20 Dec 2013 01:48:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87iounuy6e.fsf@free.fr>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2013 at 07:31:21PM +0100, Robert Jarzmik wrote:
> Thierry Reding <thierry.reding@gmail.com> writes:
>=20
> > I hadn't anticipated that =3D(. In fact I had been holding this patch b=
ack
> > for a release cycle because I was waiting for a specific regulator patch
> > to land which provides a dummy regulator if one wasn't specified. It
> > seems that that patch only works when booting from DT, though.
> >
> > The correct way to fix this would be to provide a lookup table with the
> > dummy regulator in the board file. I've attached a patch (compile-tested
> > only) that might work.
> >
> > If it does, please let me know and, if nobody else volunteers, I'll see
> > if I can come up with a set of patches to fix this for any other boards
> > that have the same issue.
> Actually, it needs a very small "tweak" to work :
> -	REGULATOR_SUPPLY("power", "pwm-backlight.0"),
> +	REGULATOR_SUPPLY("power", "pwm-backlight"),
>=20
> Without it regulator_dev_lookup() won't match the device.
>=20
> Moreover, it requires a config option, CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy=
=2E That's
> not a problem for my specific platform,

Okay. I'll submit a patch with that tweak of yours rolled in and Haojian
can merge that via the PXA tree.

> but I haven't seen *any* PXA platform
> with it activated, which means all defconfigs have to be patched, which is
> unfortunate.

Unfortunate indeed!

> As for my specific mioa701, your change with the tweak is perfectly fine =
and
> tested.

Great, I'll add your Tested-by.

Thanks,
Thierry

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStBIWAAoJEN0jrNd/PrOhWIMP/Rw9GlQVaFaunR4E2shNRNMr
k0nzmD+rLahKG9BBpzTOcDckTiDFDntC1LddVB+OmieKniTy/rLapEjb1OyOmivi
ROL/AG7IPjQgePxKfHFlWjd6yepF1q0Dmqo5rlR7uTdVgX7M/3glmHhnvgQ8ZWb6
6fk8xWandPwwpTBK32muZhKaMsvbbjyA5T2XPrT59jsYRoBYytkGPTVwc3V0TTnB
EVqXkTizW6305GvryNzpZmjYluOZEZTQK0R7I8kGLND7qDFS5TTTXVK1i8NtsEzo
+SGC6++n900EZsux8QGoDNpx4RSAeP2EqLfv4iqZT6spdm8AH4TTLu8G2PcmqbuT
k9DEQzTL0RMmB4ni/zj7uhxqxH0u6G32AnSVTzd+613nwDNq+h2WAquhSOeY2wlf
eB1xezLkeH4FZ4+TB2nsRg67lfqFpKWnilCOPMcgh59GvKkkosChbMYS1h826nKT
LGp9os8yKZUXPdtA29eeVkMb+nn+Vkl4F+B13R1GcjDWwPbwQE7dhTaM4sqC2ivm
u9AZmGNvE76hMkv8HfiZUP0YNb5Y79oB0ykWpLsXhs6UkImCWUdR00PvxbYGWfPH
am+oP1hS8up9JbmWsjCkQzkLtM4BHX6yVZTmLQrfpqZLQ3fRk2VqmE34BVuSZd4h
VG1hWp3hzNXoDiRZr7y/
=oaaj
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
