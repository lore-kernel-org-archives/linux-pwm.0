From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 2/3] pwm: push up dynamic printk level on errors in
 of_pwm_get()
Date: Mon, 13 Oct 2014 08:12:13 +0200
Message-ID: <20141013081213.286b775a@ipc1.ka-ro>
References: <1412956207-24008-1-git-send-email-vladimir_zapolskiy@mentor.com>
	<1412956207-24008-3-git-send-email-vladimir_zapolskiy@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:49188 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbaJMGM1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Oct 2014 02:12:27 -0400
In-Reply-To: <1412956207-24008-3-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

Hi,

Vladimir Zapolskiy wrote:
> The changed three user messages on fault are printed under pr_debug()=
,
> however all of them are unrecoverable and result in failed pwm device
> registration, report this to a user.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pwm/core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 681d154..ccf1be7 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -532,19 +532,19 @@ struct pwm_device *of_pwm_get(struct device_nod=
e *np, const char *con_id)
>  	err =3D of_parse_phandle_with_args(np, "pwms", "#pwm-cells", index,
>  					 &args);
>  	if (err) {
> -		pr_debug("%s(): can't parse \"pwms\" property\n", __func__);
> +		pr_warn("%s(): can't parse \"pwms\" property\n", __func__);
>
As this is an error that leads to not loading the driver it should be
printed with ERROR level.

>  		return ERR_PTR(err);
>  	}
> =20
>  	pc =3D of_node_to_pwmchip(args.np);
>  	if (IS_ERR(pc)) {
> -		pr_debug("%s(): PWM chip not found\n", __func__);
> +		pr_warn("%s(): PWM chip not found\n", __func__);
>
dto.

>  		goto put;
>  	}
> =20
>  	if (args.args_count !=3D pc->of_pwm_n_cells) {
> -		pr_debug("%s: wrong #pwm-cells for %s\n", np->full_name,
> +		pr_warn("%s: wrong #pwm-cells for %s\n", np->full_name,
>
dto.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
