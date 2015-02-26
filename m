From: Ajay kumar <ajaynumb@gmail.com>
Subject: Re: [PATCH 2/2] backlight: pwm: Add backlight-boot-off property
Date: Thu, 26 Feb 2015 11:17:04 +0530
Message-ID: <CAEC9eQP-jFJpneinkjD_VDKi83+SiBE2rcwf2vm2ZmbHV-vdOQ@mail.gmail.com>
References: <1424920366-7626-1-git-send-email-hl@rock-chips.com>
	<1424921954-8621-1-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:43007 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbBZFrF (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Feb 2015 00:47:05 -0500
In-Reply-To: <1424921954-8621-1-git-send-email-hl@rock-chips.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: huang lin <hl@rock-chips.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, linux-rockchip@lists.infradead.org

Hi Huang,

On Thu, Feb 26, 2015 at 9:09 AM, huang lin <hl@rock-chips.com> wrote:
> Add backlight-boot-off property, so we can keeping the
> backlight disabled at boot until it is enabled implicitly
> by a panel driver, or explicitly by userspace
>
> Signed-off-by: huang lin <hl@rock-chips.com>
>
> ---
>
>  drivers/video/backlight/pwm_bl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 3a145a6..dece351 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -319,6 +319,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>         }
>
>         bl->props.brightness = data->dft_brightness;
> +
> +       if (of_find_property(pdev->dev.of_node, "backlight-boot-off", NULL))
> +               bl->props.power = FB_BLANK_POWERDOWN;
> +

You need to check this. Originally, Thierry proposed it.
http://permalink.gmane.org/gmane.linux.drivers.devicetree/84604

>         backlight_update_status(bl);
>
>         platform_set_drvdata(pdev, bl);
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
