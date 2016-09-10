From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH -next] pwm: meson: Fix missing spin_lock_init()
Date: Sat, 10 Sep 2016 15:54:11 +0200
Message-ID: <57D41083.3060109@baylibre.com>
References: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35010 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbcIJNyP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Sep 2016 09:54:15 -0400
Received: by mail-wm0-f52.google.com with SMTP id w12so72846313wmf.0
        for <linux-pwm@vger.kernel.org>; Sat, 10 Sep 2016 06:54:14 -0700 (PDT)
In-Reply-To: <1473489518-17981-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org

Le 10/09/2016 08:38, Wei Yongjun a écrit :
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver allocates the spinlock but not initialize it.
> Use spin_lock_init() on it to initialize it correctly.
> 
> This is detected by Coccinelle semantic patch.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pwm/pwm-meson.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index bfbbe7f..778d088 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -465,6 +465,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(meson->base))
>  		return PTR_ERR(meson->base);
>  
> +	spin_lock_init(&meson->lock);
>  	meson->chip.dev = &pdev->dev;
>  	meson->chip.ops = &meson_pwm_ops;
>  	meson->chip.base = -1;
> 

Thanks for the fix, but it was already posted earlier by Axel Lin <axel.lin@ingics.com>

Thierry will decide which one to merge.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
