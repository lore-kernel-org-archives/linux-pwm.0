From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH RFT] PWM: twl: actually disable twl6030 PWMs
Date: Wed, 9 Apr 2014 12:32:31 +0300
Message-ID: <534513AF.9030905@ti.com>
References: <1397035286.1002.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41199 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaDIJcf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Wed, 9 Apr 2014 05:32:35 -0400
In-Reply-To: <1397035286.1002.1.camel@phoenix>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On 04/09/2014 12:21 PM, Axel Lin wrote:
> Current twl6030_pwm_disable() implementation writes TWL6030_TOGGLE3_R=
EG twice,
> the second write sets TWL6030_PWMXEN bits so the PWM clock does not d=
isable.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi Peter,
> I don't have this h/w handy to test.
> I'd appreciate if you can review and test this patch.

You are right. The code was disabling the given PWM and then set the EN=
 bit to
one :o
I don't have any explanation why it was like that, thanks for finding i=
t!

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
> Regards,
> Axel
>  drivers/pwm/pwm-twl.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
> index b99a50e..04f7672 100644
> --- a/drivers/pwm/pwm-twl.c
> +++ b/drivers/pwm/pwm-twl.c
> @@ -265,14 +265,6 @@ static void twl6030_pwm_disable(struct pwm_chip =
*chip, struct pwm_device *pwm)
> =20
>  	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_R=
EG);
>  	if (ret < 0) {
> -		dev_err(chip->dev, "%s: Failed to read TOGGLE3\n", pwm->label);
> -		goto out;
> -	}
> -
> -	val |=3D TWL6030_PWM_TOGGLE(pwm->hwpwm, TWL6030_PWMXS | TWL6030_PWM=
XEN);
> -
> -	ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_R=
EG);
> -	if (ret < 0) {
>  		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
>  		goto out;
>  	}
>=20


--=20
P=C3=A9ter
