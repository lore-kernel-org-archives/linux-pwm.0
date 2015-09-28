From: Nicolas FERRE <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] Revert "backlight: pwm: Handle =?utf-8?b?RVBST0JFX0RFRkVS?= while requesting the PWM"
Date: Mon, 28 Sep 2015 08:57:22 +0000 (UTC)
Message-ID: <loom.20150928T103748-9@post.gmane.org>
References: <1443295482-18687-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47819 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756971AbbI1JAI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
	Mon, 28 Sep 2015 05:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glp-linux-pwm@m.gmane.org>)
	id 1ZgUHz-0007IY-Sz
	for linux-pwm@vger.kernel.org; Mon, 28 Sep 2015 11:00:04 +0200
Received: from 81.80.104.164 ([81.80.104.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2015 11:00:03 +0200
Received: from nicolas.ferre by 81.80.104.164 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2015 11:00:03 +0200
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-pwm@vger.kernel.org

Robert Jarzmik <robert.jarzmik <at> free.fr> writes:

> 
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

Well, why don't you add the needed pwm table to the platforms so that you
comply with the pwm subsystem behaviour.

Otherwise, we may need to test if the platform uses the DT or instantiates
correctly the pwm which may lead to other platforms breaking.

So I would advise to not revert this patch and properly fix the existing
legacy platforms.

> Signed-off-by: Robert Jarzmik <robert.jarzmik <at> free.fr>

So to be clear: NACK for me.
(Can you please add me in CC of the discussion).

Best regards,

> ---
>  drivers/video/backlight/pwm_bl.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c
b/drivers/video/backlight/pwm_bl.c
> index eff379b234cc..57cb9ec8be43 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
>  <at>  <at>  -272,10 +272,6  <at>  <at>  static int
pwm_backlight_probe(struct platform_device *pdev)
> 
>  	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
>  	if (IS_ERR(pb->pwm)) {
> -		ret = PTR_ERR(pb->pwm);
> -		if (ret == -EPROBE_DEFER)
> -			goto err_alloc;
> -
>  		dev_err(&pdev->dev, "unable to request PWM, trying legacy API\n");
>  		pb->legacy = true;
>  		pb->pwm = pwm_request(data->pwm_id, "pwm-backlight");
