From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: ensure pwm_apply_state() doesn't modify the
 state argument
Date: Tue, 12 Mar 2019 12:42:47 +0100
Message-ID: <20190312114247.GJ31026@ulmo>
References: <20190312083537.23748-1-u.kleine-koenig@pengutronix.de>
 <20190312083537.23748-3-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2295942472798456377=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190312083537.23748-3-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--===============2295942472798456377==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 09:35:37AM +0100, Uwe Kleine-K=C3=B6nig wrote:
[...]
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 470d4f71e7eb..52dace9f739e 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
[...]
> @@ -193,17 +193,11 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chi=
p *sun4i_pwm,
>  	*dty =3D div;
>  	*prsclr =3D prescaler;
> =20
> -	div =3D (u64)pval * NSEC_PER_SEC * *prd;
> -	state->period =3D DIV_ROUND_CLOSEST_ULL(div, clk_rate);
> -
> -	div =3D (u64)pval * NSEC_PER_SEC * *dty;
> -	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(div, clk_rate);
> -

Perhaps split this out into a separate patch like you did for Rockchip?

Thierry

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyHmzcACgkQ3SOs138+
s6En1w/+OtBNSufaD4xXqdVJo7Hc7Qlaf7/f3MI0GNRskdXvbElkwZjfN25P/lv2
YCXpoKihJbbJWb6fX9P9sfXeuCnat51T0u8XgS9+NddAdm053hBIa+9HIgwhbhJU
XYTzj4U6nj1T8zHRGpjv82DWJGI6MaTIx/F9nC05V/564YUFCAOlPRwNBFfWCyKt
aLI7H2UdCWHSg4cmm9j9+6A357832tweijEAXPpNK0j6osb+Crjmz0D9bythr/qg
UuaA6WwPYo2b4GIie32H0QTFiGEwzO6on8zijIEqQk9wkWF9wnH4PdMUCM0QHnmy
tNRBsxtUt6WRhxHQq6/JtBImqb0vTI6p3FiyEgi3+nG0HkRpHkiTPAQo/2FjeF0n
PRncC3gtUlpj5CfkzKBvFMoDGs73CAwwFeWrBv23Zw7lHavZuTwBHfBchKf70wT8
r9Lk2NBQPfTSkN+2+PyTI6EsO4/kt5euui+rx4nJOofMMRH1Y5rAXie4YO8/bHAO
4smRwdOctgEYt0+5AZLE9B2AYlHO3qo4jcuwjk1Kp9czlKnOfdAXuc4Qkv9ztMDO
lXUoU7nvZlfAh+iLeOQDjZXTkU5+/d8mpRLdSoreW/53Ii3apVKlpw9arAE5Tm31
RKrnq2Ar3RLMiy+u6MNIegx8ZtdqXbfMnr9EIwiR92zzGj0g/8E=
=/tir
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--


--===============2295942472798456377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============2295942472798456377==--
