From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on
 error path
Date: Mon, 11 Jan 2016 09:39:13 +0000
Message-ID: <20160111093913.GN14104@x1>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150921232338.GG11284@x1>
 <568A8DCA.6010301@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34071 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758058AbcAKJjR (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2016 04:39:17 -0500
Received: by mail-wm0-f44.google.com with SMTP id u188so206487997wmu.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2016 01:39:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <568A8DCA.6010301@mentor.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, 04 Jan 2016, Vladimir Zapolskiy wrote:
> On 22.09.2015 02:23, Lee Jones wrote:
> > On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:
> >=20
> >> If pwm is requested by legacy pwm_request() and if the following
> >> backlight_device_register() call fails, add pwm_free() clean-up.
> >>
> >> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> >> ---
> >>  drivers/video/backlight/pwm_bl.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >=20
> > Applied, thanks.
> >=20
>=20
> I've just encountered that this change is not present in v4.4-rc, als=
o it is
> not in yours for-backlight-next branch, could you please double check=
 the
> status of the change?

Looks like this slipped though the gaps.

Reapplied, thanks.

> >> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/back=
light/pwm_bl.c
> >> index 9991cdb..a691247 100644
> >> --- a/drivers/video/backlight/pwm_bl.c
> >> +++ b/drivers/video/backlight/pwm_bl.c
> >> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform=
_device *pdev)
> >>  	if (IS_ERR(bl)) {
> >>  		dev_err(&pdev->dev, "failed to register backlight\n");
> >>  		ret =3D PTR_ERR(bl);
> >> +		if (pb->legacy)
> >> +			pwm_free(pb->pwm);
> >>  		goto err_alloc;
> >>  	}
> >> =20
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
