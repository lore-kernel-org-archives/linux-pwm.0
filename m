From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date: Mon, 30 Mar 2020 15:07:57 +0200
Message-ID: <20200330130757.GC2431644@ulmo>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36768 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbgC3NIB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 09:08:01 -0400
Content-Disposition: inline
In-Reply-To: <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2020 at 02:52:27PM +0100, Matthias Schiffer wrote:
> The interaction of the ALL_LED PWM channel with the other channels was
> not well-defined. As the ALL_LED feature does not seem very useful and
> it was making the code significantly more complex, simply remove it.
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
>  1 file changed, 17 insertions(+), 98 deletions(-)

Applied, thanks.

Thierry

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6B7y0ACgkQ3SOs138+
s6GRNQ/9FrIF8ORfn41vZHxjUSMe//QEu+IgYILRVQ6heWO41DJjaplwzIO8cnNa
oxBZOFZw7bXmFE3v38PdrvDGnFP6CwSwRp4FeWLUs1Xk6tvQ36br66uUD+k+iX7/
w0WR4OtcaBPAdGYFyWLq4ecyHwYuw9lM5OUYFVebg5XyvoIIrlXIrjQflE17yLsc
xtlLKKYTBESB0SHR/6Iva0xyRHgwy8SGNuMf7Ps3dBZO97iUqCdjEq6NdA5jlLoh
F6roXyxtkO4TWuBE+lflngPByDpzZOBkaL2LFEQzC14gonCbbVq21PZRKtgwUoFi
zAy3gITJDMQT44ICaKrFJ1U4rdbz1ELf/ep33gz63uBPd0hDd1zMrkeYftrFqpaY
2nZN/Vt+dxfy9GZNBdPHK7r0aoc0h4KWE7d5jNbBklkhl4CK3gG1PLcVaAFtD3ym
VBRi291N+XukN9EY68Ot/1zt2AI+4tJTFxNWxrcWTNcnGcG3vPZxOhfjGSKbLQLg
VahPbbaJUQiFXVsd6huqGDh43daN6HnAuJgd739pndVz0nliHUv+4RJgMG2IZYUy
wVK/l2BQFrX4pAq4rjG+RXwXOlo8Ya0/0HF59dKIXkA8fkBbBKGGoPrwgsiIeqVi
0skMjPmbJ+bayCoouWcBiV0Mvl44GJpVhIBtdB6h81seRP+dxrM=
=Cw/t
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
