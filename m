From: Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 3/4] pwm: jz4740: Obtain regmap from parent node
Date: Mon, 30 Mar 2020 18:41:04 +0200
Message-ID: <GCM08Q.D2GF67F5O2R03@crapouillou.net>
References: <20200323142421.42817-1-paul@crapouillou.net>
        <20200323142421.42817-3-paul@crapouillou.net>
        <20200330143716.GI2431644@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:53590 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgC3QlU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 12:41:20 -0400
In-Reply-To: <20200330143716.GI2431644@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, od@zcrc.me, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>, Artur Rojek <contact@artur-rojek.eu>

Hi Thierry,

Le lun. 30 mars 2020 =E0 16:37, Thierry Reding=20
<thierry.reding@gmail.com> a =E9crit :
> On Mon, Mar 23, 2020 at 03:24:20PM +0100, Paul Cercueil wrote:
> [...]
>>  diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
> [...]
>>  @@ -196,12 +208,19 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
>>   static int jz4740_pwm_probe(struct platform_device *pdev)
>>   {
>>   	struct jz4740_pwm_chip *jz4740;
>>  +	struct device *dev =3D &pdev->dev;
>>=20
>>  -	jz4740 =3D devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
>>  +	jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>>   	if (!jz4740)
>>   		return -ENOMEM;
>>=20
>>  -	jz4740->chip.dev =3D &pdev->dev;
>>  +	jz4740->map =3D device_node_to_regmap(dev->parent->of_node);
>>  +	if (!jz4740->map) {
>=20
> This seems wrong. According to the code, device_node_to_regmap()=20
> returns
> an ERR_PTR()-encoded error code on failure, so I think this should be:
>=20
> 	if (IS_ERR(jz4740->map)) {
> 		...
> 		return PTR_ERR(jz4740->map);
> 	}
>=20
> No need to resend for that, I can take care of that when applying. Let
> me know if that doesn't work.

Yes, that works for me. Good catch.

Thanks,
-Paul

>=20
> Thierry
