From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle EPROBE_DEFER while requesting the PWM"
Date: Wed, 30 Sep 2015 21:29:59 +0200
Message-ID: <87bncjemdk.fsf@belgarion.home>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
	(Robert Jarzmik's message of "Sat, 26 Sep 2015 21:24:42 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This reverts commit 68feaca0b13e453aa14ee064c1736202b48b342f.
> This commit breaks legacy platforms, for which :
>  (a) no pwm table is added (legacy platforms)
>  (b) in this case, in pwm_get(), pmw_lookup_list is empty, and therefore
>      chosen == NULL, and therefore pwm_get() returns NULL, and pwm_get()
>      returns -EPROBE_DEFER
>  (c) as a consequence, this code is unreachable in pwm_bl.c :
>      if (IS_ERR(pb->pwm)) {
> 	ret = PTR_ERR(pb->pwm);
>  	dev_info(&pdev->dev, "%s:%d(): %d\n", __func__, __LINE__, ret);
>  	if (ret == -EPROBE_DEFER)
>  		goto err_alloc;
>
>  	dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  	pb->legacy = true;
>  	pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
>
> As this code is unreachable, all legacy platforms relying on pwm_id are
> broken, amongst which pxa have been tested as broken.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Thierry, would you have a look please ?
As I said before, all legacy platform relying on pwm_id are broken. I'd like to
be sure this lands in the next -rc series.

Cheers.

--
Robert
