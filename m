From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while requesting the PWM"
Date: Thu, 01 Oct 2015 11:06:33 +0200
Message-ID: <877fn7dkkm.fsf@belgarion.home>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
	<87bncjemdk.fsf@belgarion.home> <560CE816.1060307@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:58424 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbbJAJLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Oct 2015 05:11:45 -0400
In-Reply-To: <560CE816.1060307@atmel.com> (Nicolas Ferre's message of "Thu, 1
	Oct 2015 10:00:22 +0200")
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Nicolas Ferre <nicolas.ferre@atmel.com> writes:

> Le 30/09/2015 21:29, Robert Jarzmik a =C3=A9crit :
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>>=20
>>> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
>>> This commit breaks legacy platforms, for which :
>>>  (a) no pwm table is added (legacy platforms)
>>>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and ther=
efore
>>>      chosen =3D=3D NULL, and therefore pwm_get() returns NULL, and =
pwm_get()
>>>      returns -EPROBE_DEFER
>>>  (c) as a consequence, this code is unreachable in pwm_bl.c :
>>>      if (IS_ERR(pb->pwm)) {
>>> 	ret =3D PTR_ERR(pb->pwm);
>>>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
>>>  	if (ret =3D=3D -EPROBE_DEFER)
>>>  		goto err_alloc;
>>>
>>>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n")=
;
>>>  	pb->legacy =3D true;
>>>  	pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>>>
>>> As this code is unreachable, all legacy platforms relying on pwm_id=
 are
>>> broken, amongst which pxa have been tested as broken.
>>>
>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Thierry, would you have a look please ?
>> As I said before, all legacy platform relying on pwm_id are broken. =
I'd like to
>> be sure this lands in the next -rc series.
>
> Well, as I answered on the linux-pwm mailing-list (I was not in copy)=
 here:
> http://article.gmane.org/gmane.linux.pwm/2744
> I wonder if it's not easier to fix the platforms and add the pwm tabl=
es...
No it's not, at least not for a -rc cycle. It's the long term solution =
you're
talking about, not the fix one.

> Otherwise, Boris proposed this fix:
> 8<-----------------------------------------------------------
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlig=
ht/pwm_bl.c
> index eff379b..00483d4 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -273,15 +273,15 @@ static int pwm_backlight_probe(struct platform_=
device *pdev)
>  	pb->pwm =3D devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
>  		ret =3D PTR_ERR(pb->pwm);
> -		if (ret =3D=3D -EPROBE_DEFER)
> -			goto err_alloc;
> =20
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy =3D true;
>  		pb->pwm =3D pwm_request(data->pwm_id, "pwm-backlight");
>  		if (IS_ERR(pb->pwm)) {
>  			dev_err(&pdev->dev, "unable to request legacy PWM\n");
> -			ret =3D PTR_ERR(pb->pwm);
> +			if (ret !=3D -EPROBE_DEFER)
> +				ret =3D PTR_ERR(pb->pwm);
> +
>  			goto err_alloc;
>  		}
>  	}
>
> which is not tested and may add an extra non-valid error log.
I can test that, today, it looks an interesting alternative.

If both solutions do work, someone (Boris) can post a patch for this -r=
c instead
of the revert. If no patch is posted, I maintain my Revert, as this pat=
ch _does_
break platforms (omap is broken too AFAICS).

Cheers.

--=20
Robert

PS: I have not received http://article.gmane.org/gmane.linux.pwm/2744.
    Is it my mailer or MUA which is broken, ie. was I in the "To:" of t=
he mail ?

PPS: Sorry to having forgotten to join you to the revert

PPPS: As long as an other patch is not submitted to fix the issue (othe=
r than
      the Revert), I NAK the NAK. There is a breakage introduced, and I=
 consider
      it a strong enough reason to be maintained for the -rc serie.
