From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: sun4i: redundant assignment to variable pval
Date: Wed, 2 Oct 2019 12:39:04 +0200
Message-ID: <20191002103904.GI3716706@ulmo>
References: <20191002100844.10490-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6387424612722588094=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191002100844.10490-1-colin.king@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


--===============6387424612722588094==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RwxaKO075aXzzOz0"
Content-Disposition: inline


--RwxaKO075aXzzOz0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 02, 2019 at 11:08:44AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Variable pval is being assigned a value that is never read. The
> assignment is redundant and hence can be removed.
>=20
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Thierry

--RwxaKO075aXzzOz0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2UfkYACgkQ3SOs138+
s6EokA//eXZuyZhqQNANMBM0nG+CkHKuKs+iC0DOXQ4NyZMNNoXNy6I2UvGg7Yxr
hSiF5hYwZqfU12j33qdvne88q+Qh4R6UVyH9+doCh2SYpO928hUyrcBP7cutZ6LQ
pXxUyssDZCWpzr95yrKXhFdtp1KARRdeIjvnu2qdAUXVbJ9LsYpWVKBZQ+5qzrit
p0oR4l9K1T8m4wJ+DM9ejM8SPRsT+LMhaqPDWzqSRy6OewNPhcHiQk26XwZ2SWDH
tUMLk5vuGoHxKHOYorOG3IFjfNjCWqJbsRyYIYdjk0hqBrZ6UWhAI1EKdeb6qK5V
oPyxLIIhiTMZ6JiSN/RgY3zO+/0Mak0YLrouaVCpt6mI/OcsTh6u6++bDvQchQmB
vcNFScHVLuwUnNV1Bh4FEjocX3i5ucDQsAhDQfX1HriCX4MTXt3QArdQLx2s1CYS
AcntnIIYWzT+YIc6FObtL4ml/FPmwBKT6V5F5eA78AwcsRDV6dMcqRO1I8wkkypF
gAh5KLSjWfibX+nYC2vgMsP8Ab6wD40fu8sa8W8q/Q6A4Yc267hqHgsMKTnVQP4t
TK/kv4TqVADa7mV6sGsvQUvtKn2+3rBUnv+WU06VXgw4ZhzyjybuZbGi5rkugGm8
eUDcoodpzE8EJSlgjgpygmouU5EUezWzh/tfCGR3HKeTPQBs47E=
=VQ2m
-----END PGP SIGNATURE-----

--RwxaKO075aXzzOz0--


--===============6387424612722588094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6387424612722588094==--
