From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] pwm: tegra: Read PWM clock source rate in driver init
Date: Thu, 13 Apr 2017 17:36:32 +0200
Message-ID: <20170413153632.GE27388@ulmo.ba.sec>
References: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o0ZfoUVt4BxPQnbU"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34555 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdDMPgg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2017 11:36:36 -0400
Content-Disposition: inline
In-Reply-To: <1492092628-843-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jonathanh@nvidia.com, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 07:40:27PM +0530, Laxman Dewangan wrote:
> It is required to know the PWM clock source frequency to
> calculate the PWM period.
>=20
> In driver, the clock source frequency of the PWM does not
> get change and, hence, get the clock source frequency in
> driver initi. Get this values later for period calculation
> from pwm_config().
>=20
> This will help in avoiding the clock call for getting clock rate
> in the pwm_config() each time.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/pwm/pwm-tegra.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAljvmwAACgkQ3SOs138+
s6GK6hAAhk4P6PW5xdj4HuKbpL0MW1bWl742YRZdEe3WJCdIKw3pNxMsUlbMX81p
57qA6RWB+AFulkzVBdYF4z2DOSMiYdQuzloz6EPXwRJ+Pr5Yc1RV5NYoYh6M2JfF
yjhj2gIGlKUxyf6WYWZg5K+1+pwUWzbGYe9lqEjrdFQYk2Vmel1rYcUvq50y6d1Z
G0xWjgsRawNAGg6DmMmKA1QAb00zaJsW9EGNELwLH0f8rkv20Badxg6PjaOg3nLO
lMX2l+ESr9QK8miMN8j+1dBlUlaC9rzL4EJnGLjJDDHCSxTDa58NNJUEmp4Jgqp4
vR0JxLwfuXMJeer176ZEVp0gf1g2yBEsQiHlEBWJY7T87o92L/a1I+oCaIFsNeqk
C4S59LyfrMByEqyGxezXMHeHg5hD56/boYyyfGcUW59MErqh0Nalg1QGuMM0fnLH
Mpjcnn+Fcapb1U/38JGlVq8MFMXMHazu9UZyv+rurv4FXwFMlPL0LTtwuzUkeCnW
SyIiD/jJhdCUVEMdWVfEGGMLFKzzYB9UqQINvqRi4DGQTOKP04prIwPP6v6zMik+
1nHYfgg+QYoKwML74rgeiMQ8z+ikDiCTtJIS8HOZjMEa1L7kwUc3Ox7WkhWR3j6B
xDUmkgseVAWPylIQMWkWFU+KXvSHlS65pCpGRXK3DneGNcacaa8=
=woBu
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
