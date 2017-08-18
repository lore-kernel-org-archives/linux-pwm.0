From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 5/7] pwm: rockchip: Use same pwm ops for each IP
Date: Fri, 18 Aug 2017 17:43:44 +0200
Message-ID: <20170818154344.GF18307@ulmo>
References: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
 <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33283 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdHRPnr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Aug 2017 11:43:47 -0400
Content-Disposition: inline
In-Reply-To: <1502206888-24302-1-git-send-email-david.wu@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, boris.brezillon@free-electrons.com, robh+dt@kernel.org, catalin.marinas@arm.com, briannorris@chromium.org, dianders@chromium.org, mark.rutland@arm.com, huangtao@rock-chips.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2017 at 11:41:28PM +0800, David Wu wrote:
> Just use the same pwm ops for each IP, and get rid of the
> ops in the struct of rockchip_pwm_data, but still define
> the 3 different rockchip_pwm_data to use common interface
> for each IP.
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/pwm/pwm-rockchip.c | 147 ++++++++++++---------------------------=
------
>  1 file changed, 38 insertions(+), 109 deletions(-)

Applied to for-4.14/drivers, thanks.

Thierry

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmXCzAACgkQ3SOs138+
s6FTaRAAj1WBpJEJcBzWUKhb0Th9CtWNxFD6TSgFiVqWbnd8PCMzbBrkVYeAq0fk
87MJjnp8/M3gA+Jvl3JGBmvyPPFTc+yf8HBYoHCWLynLqPRNXngqnBUMGGKv0TQi
ykAfBCp9hBCbVwFvoLqXKysshssDjWdBNQ85lVOHffly30Jx7pqc0efbcyiULdh+
q9Lirb5k+gguTULgtPdN8e2HW8dKxqFgrtPleTZhFQCr3f11dXGKX5hKhZhyFxq/
0uLp69SjP2d2Chz5LrJ6/qnOhDyPj1nRrrd6dj4ZHgdge+xf2zB8c9mWS6P47p7h
SjW2kM3VgfhbkgKT+7HUkZ5xiTdb5Zhi7Q5xJWGKKuyz58NwPEsEor0OMYbDngVD
dUv12Wq1PuGoz4Z6OVQURUVdcE8baPbXoBGB8D96nQlGY9CBsem01Lfr5IpyNXOj
X24oYRWlNEqAJzZTE45W6jcy3HjGJhJ9CwOCvFQqV2iaja5Jc8dhcDyQkkDof/HE
CMgNWfzRoTQjbXAIRMva5IjTlW1jsqb3rmcFGvczJORp8Yu4RcS2ZWzZPp56QJAn
wXjBHoc/cl6su7ddXwJ2JxtGGfEY4tp73FvedKcGOJNiO8MXNruFfjR8TCSB2lJd
0k8Dg9bMKYnYYg7BqKQ7vd5xTCIYcjYBllS+SCv7Qkek5k1j8Dc=
=PBPo
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
