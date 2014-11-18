From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: atmel-hlcdc: add at91sam9x5 and sama5d3 errata
 handling
Date: Tue, 18 Nov 2014 16:00:23 +0100
Message-ID: <20141118150016.GB18586@ulmo>
References: <1416314453-28597-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59457 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbaKRPA2 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Nov 2014 10:00:28 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so2122733wid.3
        for <linux-pwm@vger.kernel.org>; Tue, 18 Nov 2014 07:00:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1416314453-28597-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 01:40:53PM +0100, Boris Brezillon wrote:
> at91sam9x5 has an errata forbidding the use of slow clk as a clk source a=
nd
> sama5d3 SoCs has another errata forbidding the use of div1 prescaler.
>=20
> Take both of these erratas into account.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index eaf8b12..405f8a5 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -36,6 +36,8 @@ struct atmel_hlcdc_pwm {
>  	struct pwm_chip chip;
>  	struct atmel_hlcdc *hlcdc;
>  	struct clk *cur_clk;
> +	bool slow_clk_errata;
> +	bool div1_clk_errata;
>  };
> =20
>  static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip=
 *chip)
> @@ -56,20 +58,28 @@ static int atmel_hlcdc_pwm_config(struct pwm_chip *c,
>  	u32 pwmcfg;
>  	int pres;
> =20
> -	clk_freq =3D clk_get_rate(new_clk);
> -	clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
> -	do_div(clk_period_ns, clk_freq);
> +	if (!chip->slow_clk_errata) {
> +		clk_freq =3D clk_get_rate(new_clk);
> +		clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
> +		do_div(clk_period_ns, clk_freq);
> +	}
> =20
> -	if (clk_period_ns > period_ns) {
> +	/* Errata: cannot use slow clk on some IP revisions */
> +	if (chip->slow_clk_errata || clk_period_ns > period_ns) {
>  		new_clk =3D hlcdc->sys_clk;
>  		clk_freq =3D clk_get_rate(new_clk);
>  		clk_period_ns =3D (u64)NSEC_PER_SEC * 256;
>  		do_div(clk_period_ns, clk_freq);
>  	}
> =20
> -	for (pres =3D 0; pres <=3D ATMEL_HLCDC_PWMPS_MAX; pres++)
> +	for (pres =3D 0; pres <=3D ATMEL_HLCDC_PWMPS_MAX; pres++) {
> +		/* Errata: cannot divide by 1 on some IP revisions */
> +		if (!pres && chip->div1_clk_errata)
> +			continue;
> +
>  		if ((clk_period_ns << pres) >=3D period_ns)
>  			break;
> +	}
> =20
>  	if (pres > ATMEL_HLCDC_PWMPS_MAX)
>  		return -EINVAL;
> @@ -204,6 +214,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_dev=
ice *pdev)
>  	if (ret)
>  		return ret;
> =20
> +	if (of_device_is_compatible(dev->parent->of_node,
> +				    "atmel,sama5d3-hlcdc"))
> +		chip->div1_clk_errata =3D true;
> +
> +	if (of_device_is_compatible(dev->parent->of_node,
> +				    "atmel,at91sam9x5-hlcdc"))
> +		chip->slow_clk_errata =3D true;

Generally I'd prefer this to be done as "SoC data", where the idea is to
not rely on these checks at probe time (because they don't scale very
well in the long term). Somewhat like the following:

	struct atmel_hlcdc_soc {
		bool slow_clk_errata;
		bool div1_clk_errata;
	};

	static const struct atmel_hlcdc_soc sama5d3_hlcdc =3D {
		.slow_clk_errata =3D false,
		.div1_clk_errata =3D true,
	};

	static const struct atmel_hlcdc_soc at91sam9x5_hlcdc =3D {
		.slow_clk_errata =3D true,
		.div1_clk_errata =3D false,
	};

Then put those into a struct of_device_id table and do the matching
using of_match_device(). Then you can simply do something like:

	match =3D of_match_device(dev->parent, atmel_hlcdc_matches);
	if (match)
		chip->soc =3D match->data;

And then check on the fields set therein. This works optimally if the
device isn't a subdevice because you have most of that code anyway. In
this particular case the lookup needs to happen on the parent, which
isn't so nice.

I'm willing to let this go for now, but if this list is going to grow
I'll request that it be done differently so that .probe() doesn't need
to be cluttered.

Also I wonder if it would be better to just add these new compatibles to
the PWM block binding, too, since it's obviously the IP blocks that have
these errata rather than the HLCDC block. So technically I think you'd
have to make the driver support atmel,at91sam9x5-hlcdc-pwm and
atmel,sama5d3-hlcdc-pwm anyway, and then you could just as well move to
the above matching and SoC data.

Thierry

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUa17/AAoJEN0jrNd/PrOhHyYQAK517ZwCCGTwZ6PYQ6MR/un5
FougXB0TOowwwRixbotv/dxc328KVf5Mx+NfSGnglKtOKfeW5d9oR508RjqGvISh
vLHrymycqJ8AphYE9cODIDWU600dsVPPTpQaYyu6k3fTolekOddrQhnt3un9I9uT
XKnYyDZKDOhjbrOI6Q/ailmgOI5PZO+oHd3vqUV4AzojS7ojiMDRIbMyNy4EmhK+
DbckzBYua3hgpUYX8Gj5b2UNhVk5e437ItCEDqYZALTE99/sLTPkvMyOv+Rc81FD
NJ/MCgCtbR8t1ZSh8WKkS+F/ntYnyQHa53WP9IScTS7/Kkx1oUXughUvE5WhHrwM
qH3d3L9mzlaYky0BUowdslWPZ9SyQ5HEuD2zSbzciLG5aA0CknJFJ52eDituIR5s
FKiVe0H5o7bBtPKPXMRR8gGEbHId4Um69i+AaoZKIsLMIi6BMsrjLECS9EFBC4Bu
UlRmPlVZzAOpNhc7+HL7RBNjZENP/DVWt8EuZbmWe0djC4kjv5uKrM8EagNCkenZ
ZToJGEZtC3lupcQMlMJp1v9sCJ7vnRij9/jTRjyUvs7meA1XU6QcHmg4ZeOl8Xmv
czkNukJA/5z03wL+5lUvm3jtQ3I3bdW2rM+8U0eQ+I/xPD4AM2d50tX82ORYXlxw
1M1n9KnQQPRBSB+AlXuj
=rJz8
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
