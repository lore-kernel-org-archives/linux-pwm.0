From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/2] backlight: pwm: don't call legacy pwm request for
 device defined in dt
Date: Fri, 12 Jun 2015 13:31:16 +0200
Message-ID: <20150612113114.GK19400@ulmo.nvidia.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OX7PPUk8qMPP4++R"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34954 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbbFLLbz (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2015 07:31:55 -0400
Content-Disposition: inline
In-Reply-To: <1413035186-11771-2-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, stable@vger.kernel.org


--OX7PPUk8qMPP4++R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2014 at 04:46:25PM +0300, Vladimir Zapolskiy wrote:
> Platform PWM backlight data provided by board's device tree should be
> complete enough to successfully request a pwm device using pwm_get() API.
>=20
> Based on initial implementation done by Dmitry Eremin-Solenikov.
>=20
> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/backlight/pwm_bl.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

This fell off my radar, but I think it's good. I used to have a local
patch somewhere that solved the same problem by initializing the pwm_id
field of platform_pwm_backlight_data to -1 in pwm_backlight_parse_dt(),
but I like this variant better because it's more explicit and doesn't
even attempt to request using the legacy API (which will inevitably fail
in the DT case anyway).

Vladimir, do you think you'd have the time to rebase this patch on top
of something recent and perhaps extend the commit message with some of
the arguments that you brought forth in this thread? Specifically it'd
be useful to mention that this enforces the DT binding and fixes a real
bug where the legacy path would try to request a PWM that's not
necessarily the right one.

Thierry

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index cb5ae4c..dd7aaf7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -272,15 +272,15 @@ static int pwm_backlight_probe(struct platform_devi=
ce *pdev)
>  	}
> =20
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
> -	if (IS_ERR(pb->pwm)) {
> +	if (IS_ERR(pb->pwm) && !pdev->dev.of_node) {
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
> -
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
> -		if (IS_ERR(pb->pwm)) {
> -			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> -			ret =3D PTR_ERR(pb->pwm);
> -			goto err_alloc;
> -		}
> +	}
> +
> +	if (IS_ERR(pb->pwm)) {
> +		dev_err(&pdev->dev, "unable to request PWM\n");
> +		ret =3D PTR_ERR(pb->pwm);
> +		goto err_alloc;
>  	}
> =20
>  	dev_dbg(&pdev->dev, "got pwm for backlight\n");
> --=20
> 1.7.10.4
>=20

--OX7PPUk8qMPP4++R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVesL/AAoJEN0jrNd/PrOh9HMP/0AY6udiX4D+pQ5axNgQwoGq
RoR/PxfU8cDU+S4nW4byJ29oEXdcimzdHK8eflvOE8HuDj3MOHx+aSIQSDr0TpXu
PYJ2xQq3k7rr7qoc4TVUZtcK9fADT/xPVxWXyGROq6as9zQUaOPQXz1UHr2R9QS7
eQZO7B7IH0buRleDRw/cJOZ9QASRPs7BBcL0ajeMMWz6M8vorKO99BAVFZRED1fw
xW1rOZ3x92h6RO385fyib3Dv0+N93nF21lEyu6QGlGtn4oagB5VFz/cEECcpwZ7d
qvEEkN7T4zg3LV1l4d9OrET01IxjqK3kw5BLKYLkUgdCPWU7Bw8jXcwTmcAZjZyq
FHWkTtSQlX2vR5TuKUVsGudfFwNNX8J5pv3K4bDlrrEnK8b0nkb29JMQPfu0AVr4
CjW2ey0HhByRWq1TAQvIIgC4i85YeQOAcvug0eV5SoWpsXlIgiv5U9aBx/YklNgM
3AFaOnasApo9By4VaGRb5yr0h89PNBDod+mTr4GLSlnj816qdcCo0pNOB83kdgI7
ol5e65NbtL1SSczWkYHRpKebOo4uQgTDZLr20l8LvzknRLEU210bBSjF6Gjoa46w
3u/sfzJIVY4KOObHEaMJ3EYwNeU3ISL1iN/LO/ynGFqRAOdYe+NrndjAASxEihK3
cRKVlKufOTvQfpPO6wp/
=6mUO
-----END PGP SIGNATURE-----

--OX7PPUk8qMPP4++R--
