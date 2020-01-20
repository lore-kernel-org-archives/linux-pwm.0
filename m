From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v4 1/2] pwm: mtk_disp: fix pwm clocks not poweroff when
 disable pwm
Date: Mon, 20 Jan 2020 12:52:40 +0100
Message-ID: <20200120115240.GA206171@ulmo>
References: <20191217040237.28238-1-jitao.shi@mediatek.com>
 <20191217040237.28238-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191217040237.28238-2-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, CK Hu <ck.hu@mediatek.com>, linux-mediatek@lists.infradead.org, sj.huang@mediatek.com
List-Id: linux-pwm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2019 at 12:02:36PM +0800, Jitao Shi wrote:
> The clocks of pwm are still in prepare state when disable pwm.
>=20
> Because the clocks is prepared in mtk_disp_pwm_probe() and unprepared
> in mtk_disp_pwm_remove().
>=20
> clk_prepare and clk_unprepare aren't called by mtk_disp_pwm_enable()
> and mtk_disp_pwm_disable().
>=20
> Modified:
> So clk_enable() is instread with clk_prepare_enable().
> clk_disable() is instread with clk_disable_unprepare().
>=20
> And remove the clk_prepare() from mtk_disp_pwm_probe(),
> remove the clk_unprepare from mtk_disp_pwm_remove().

This commit message is basically a description of what the patch does,
which is pretty useless because I can look at the patch to see what it
does.

Use the commit message to describe why you want to make this change and
what the benefits are of doing what you're doing. Describe why and how
the patch improves the driver compared to before.

With regards to clk_prepare()/clk_enable() vs. clk_prepare_enable(),
there are valid reasons for splitting the call up like this driver did.
clk_prepare() for example may sleep, so you can't call it from interrupt
context. clk_enable() on the other hand does not sleep, so it can be
called from interrupt context. So there might be legitimate reasons for
this split in the driver.

When you say that clocks are still in prepared state when you disable
the PWM this probably means that clk_disable() doesn't do anything on
your platform and clk_unprepare() is when the clock is actually
disabled. That's perfectly valid. It should also be safe to do this now,
since a while ago the PWM API as a whole was made "sleepable", so it
should be safe to call clk_prepare_enable() and clk_disable_unprepare()
=66rom any callbacks because users of the PWM API already need to assume
that the API can sleep.

So, I don't object to the patch, I just wanted to make sure that you've
thought about the consequences and to describe in the commit message
what you're actually trying to achieve and why it's better.

In particular it'd be interesting to know what the effects are that you
are noticing if the clock isn't off when the PWM is disabled and how you
found out. Those are the kinds of details that make the commit message
really useful because they help readers of the git log figure out what
the problems where that you encountered and why you fixed them the way
you did.

Thierry

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/pwm/pwm-mtk-disp.c | 43 +++++++++++---------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
> index 83b8be0209b7..c7b14acc9316 100644
> --- a/drivers/pwm/pwm-mtk-disp.c
> +++ b/drivers/pwm/pwm-mtk-disp.c
> @@ -98,13 +98,13 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  	high_width =3D div64_u64(rate * duty_ns, div);
>  	value =3D period | (high_width << PWM_HIGH_WIDTH_SHIFT);
> =20
> -	err =3D clk_enable(mdp->clk_main);
> +	err =3D clk_prepare_enable(mdp->clk_main);
>  	if (err < 0)
>  		return err;
> =20
> -	err =3D clk_enable(mdp->clk_mm);
> +	err =3D clk_prepare_enable(mdp->clk_mm);
>  	if (err < 0) {
> -		clk_disable(mdp->clk_main);
> +		clk_disable_unprepare(mdp->clk_main);
>  		return err;
>  	}
> =20
> @@ -124,8 +124,8 @@ static int mtk_disp_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>  					 0x0);
>  	}
> =20
> -	clk_disable(mdp->clk_mm);
> -	clk_disable(mdp->clk_main);
> +	clk_disable_unprepare(mdp->clk_mm);
> +	clk_disable_unprepare(mdp->clk_main);
> =20
>  	return 0;
>  }
> @@ -135,13 +135,13 @@ static int mtk_disp_pwm_enable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  	struct mtk_disp_pwm *mdp =3D to_mtk_disp_pwm(chip);
>  	int err;
> =20
> -	err =3D clk_enable(mdp->clk_main);
> +	err =3D clk_prepare_enable(mdp->clk_main);
>  	if (err < 0)
>  		return err;
> =20
> -	err =3D clk_enable(mdp->clk_mm);
> +	err =3D clk_prepare_enable(mdp->clk_mm);
>  	if (err < 0) {
> -		clk_disable(mdp->clk_main);
> +		clk_disable_unprepare(mdp->clk_main);
>  		return err;
>  	}
> =20
> @@ -158,8 +158,8 @@ static void mtk_disp_pwm_disable(struct pwm_chip *chi=
p, struct pwm_device *pwm)
>  	mtk_disp_pwm_update_bits(mdp, DISP_PWM_EN, mdp->data->enable_mask,
>  				 0x0);
> =20
> -	clk_disable(mdp->clk_mm);
> -	clk_disable(mdp->clk_main);
> +	clk_disable_unprepare(mdp->clk_mm);
> +	clk_disable_unprepare(mdp->clk_main);
>  }
> =20
>  static const struct pwm_ops mtk_disp_pwm_ops =3D {
> @@ -194,14 +194,6 @@ static int mtk_disp_pwm_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(mdp->clk_mm))
>  		return PTR_ERR(mdp->clk_mm);
> =20
> -	ret =3D clk_prepare(mdp->clk_main);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret =3D clk_prepare(mdp->clk_mm);
> -	if (ret < 0)
> -		goto disable_clk_main;
> -
>  	mdp->chip.dev =3D &pdev->dev;
>  	mdp->chip.ops =3D &mtk_disp_pwm_ops;
>  	mdp->chip.base =3D -1;
> @@ -210,7 +202,7 @@ static int mtk_disp_pwm_probe(struct platform_device =
*pdev)
>  	ret =3D pwmchip_add(&mdp->chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> -		goto disable_clk_mm;
> +		return ret;
>  	}
> =20
>  	platform_set_drvdata(pdev, mdp);
> @@ -229,24 +221,13 @@ static int mtk_disp_pwm_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	return 0;
> -
> -disable_clk_mm:
> -	clk_unprepare(mdp->clk_mm);
> -disable_clk_main:
> -	clk_unprepare(mdp->clk_main);
> -	return ret;
>  }
> =20
>  static int mtk_disp_pwm_remove(struct platform_device *pdev)
>  {
>  	struct mtk_disp_pwm *mdp =3D platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret =3D pwmchip_remove(&mdp->chip);
> -	clk_unprepare(mdp->clk_mm);
> -	clk_unprepare(mdp->clk_main);
> =20
> -	return ret;
> +	return pwmchip_remove(&mdp->chip);
>  }
> =20
>  static const struct mtk_pwm_data mt2701_pwm_data =3D {
> --=20
> 2.21.0

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4llIUACgkQ3SOs138+
s6HWIxAAnULnxFuMUVVfb+pYXq1yOZEiYCdtDOMqqn6OsLVqbL2PNcEVrQJE2KFt
xNZpXsehxGa4P5JRi7a8sJP3uW03xL89tw5vhCBgSRQ0OOM8PsmjJcQlmzZT3/ns
GNP6PODAT5rk+XaPq3y8IA+Y1BDKv1i/SB078suhEA1Suh0OwEXuVO4dPJNSUIbp
fbBBn4Svly5Ew4LZcm5zg9y5/eJh46tmWMElZtcLYaLQjO8Vf2yaYhDQRy/aP5X/
zmZER/Z3MYvF14xtkGD9JJuBHO6EiR3npcm8Taqdbz+bgEO5l8sX781a74/xgtQI
awK8fc/2XAUBgPMXms6vByxlPJsgrnDsWKV4eaNjTDP21xK2aZsGVo0hSeEEUz+k
+EIGzWZOQw4KT9Bic7KssgyiPYrGyZW0ZZJkctZWPNBKrmQx24gXAEYiDpb5rg6+
kwnze5nh+G9iFWqfWsf+SK/Qqphvw6GFosbVjgSmRLh6Ypdcp88dE1IPBXM40cgG
UnAi5BDeRujXttXoLnCucSRsNrJqzxRcD5+IVrqaP5B3vVtEnsssAXPS6hIsB6dE
ZS9suD3hl/NmAIYg0aoVoPM+eKhTLOSTArSTIguszJiUagt2lTSU9pPN/174VbsS
lDLddGbzFBEulJbyqfJFMe4EpeCa6MZnI5h5TNix8ezcHidAhlI=
=DZXz
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
