From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: mxs: fix period divider computation
Date: Wed, 11 Mar 2015 11:57:30 +0100
Message-ID: <20150311105729.GD22149@ulmo.nvidia.com>
References: <1424264794-12167-1-git-send-email-ghug@induct.be>
 <20150302123206.GD3040@dragon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33901 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbCKK5f (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2015 06:57:35 -0400
Content-Disposition: inline
In-Reply-To: <20150302123206.GD3040@dragon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Gaetan Hug <ghug@induct.be>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, fabio.estevam@freescale.com


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 08:32:09PM +0800, Shawn Guo wrote:
> On Wed, Feb 18, 2015 at 02:06:34PM +0100, Gaetan Hug wrote:
> > The driver computes which clock divider it sould be using from the
> > requested period. This computation assumes that the link between the
> > register value and the actual divider value is raising 2 to the power of
> > the registry value.
> >=20
> >     div =3D 1 << regvalue
> >=20
> > This is true only for the first 5 values out of 8. Next values are 64,
> > 256 and, 1024 - instead of 32, 64, 128.
>=20
> Just checked i.MX28 Reference Manual, and yes, this is the case.
>=20
> > This affects only the users requesting a period > 0.04369s.
> >=20
> > Replace the computation with a look-up table.
>=20
> Your SoB is missing here.  Otherwise,
>=20
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Gaetan,

can you resend with your Signed-off-by added? Or at least provide it
here? I can't really apply this without one.

Thierry

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVAB+ZAAoJEN0jrNd/PrOhWDIP/RDOn5SRwvT9wtmUezZqX2d0
bo+Mgcoz3gsj6hLmSLYY3OH0fyYIxkEvi1h9nH+kFB5/uYj+1e6IMIGIWMhj9xBk
PY7AWPIf/ieXdc7nsq27lKhKXnTd5V5SvkSxD5uRYi6lWi4ThN/yfGCApwYdbhd9
M/QTzgOYhb45ERtoh+m0PnLW8/u4IXxf0Mmga89p6ovTcr2p6RpbK2vv1mm1egQ/
xyI2OiZMQv/FZsOY6+5/uqzn+2wwOjdQP5Gchl8GISFG0s0DLe99nBej0aM0Y7JS
oibitiWXVXbytkmoGImXzWNxJ0nVli5CpBxE1JAHlZVGDjvZiSddOpI4BvJYSIop
zaT1BwjDHS4mBIbbRQ7ap13Ifq7rcOlB675mMjBcXJ3IXHf6MmuQxC/B2N80GR0X
GiRoeZ0UfWPQmE8dGxsf/D5tnwrkdmsxyjQzBoU6v/3z3YBN+804dWYh4cBMAXVe
ztNMNYUc9eGrTW0iSZVCSCQfZNpa5hLA4HxiLtmNtFpFMpBU1hXGtSb+adM1CgLE
qe36M4i/QQJj2tQAYzWzFyswKwdtfUZV9DD6FUK9pIF0DvLG2ynduf+0j2G5O5K5
gbIdYt/oSwqpla0QqoEoFyl2V5QQxgxFJpuIe8pWUYsSnh29hqsRf96MPIxo+rcY
kAJtB+yhM3LNbR0DZFQB
=zGgz
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
