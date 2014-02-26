From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 10:19:21 +0530
Message-ID: <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
	<000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:41974 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbaBZEtV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2014 23:49:21 -0500
Received: by mail-oa0-f49.google.com with SMTP id i4so303992oah.8
        for <linux-pwm@vger.kernel.org>; Tue, 25 Feb 2014 20:49:21 -0800 (PST)
In-Reply-To: <000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

On 26 February 2014 06:39, Jingoo Han <jg1.han@samsung.com> wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pwm/pwm-spear.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
> index 8ad26b8..b4f6d0d 100644
> --- a/drivers/pwm/pwm-spear.c
> +++ b/drivers/pwm/pwm-spear.c
> @@ -179,10 +179,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
>         u32 val;
>
>         pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
> -       if (!pc) {
> -               dev_err(&pdev->dev, "failed to allocate memory\n");

Can you please pin point which/file line will print similar message ?
