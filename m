From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] pwm: meson: Fix missing spin_lock_init
Date: Sat, 10 Sep 2016 15:49:31 +0200
Message-ID: <57D40F6B.1030708@baylibre.com>
References: <1473472549-20140-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38628 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbcIJNtf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Sep 2016 09:49:35 -0400
Received: by mail-wm0-f42.google.com with SMTP id 1so75984963wmz.1
        for <linux-pwm@vger.kernel.org>; Sat, 10 Sep 2016 06:49:34 -0700 (PDT)
In-Reply-To: <1473472549-20140-1-git-send-email-axel.lin@ingics.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

Le 10/09/2016 03:55, Axel Lin a écrit :
> The driver uses the spin_lock but not initialize it, fix it.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pwm/pwm-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 381871b..9d5bd7d 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -474,6 +474,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(meson->base))
>  		return PTR_ERR(meson->base);
>  
> +	spin_lock_init(&meson->lock);
>  	meson->chip.dev = &pdev->dev;
>  	meson->chip.ops = &meson_pwm_ops;
>  	meson->chip.base = -1;
> 

Silly error !

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
