From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Add MediaTek display PWM driver
Date: Tue, 30 Jun 2015 14:35:42 +0800
Message-ID: <CAGS+omANeUxcRdY-qQzxjtBY5Yhx56mSneuuXh+bGjbahKhDeA@mail.gmail.com>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435590211-38854-1-git-send-email-yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi YH,

Please also include a patch that adds PWM bindings to mt8173.dtsi.
The clock definitions (CLK_MM_DISP_PWM*) are added by James LIao's patch:
  clk: mediatek: Add subsystem clocks of MT8173

I think it is ok to mention in the cover-letter that the PWM .dtsi
change depends on that other patch.

Also, cover-letters usually contain a "shortlog" and diffstatm that
gives summary of patches and changed files, generated along with the
patches using:
 git format-patch --cover-letter

Thanks,
-Daniel

On Mon, Jun 29, 2015 at 11:03 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> This patch series add the use of display PWM driver and documentation
> for Mediatek SoCs. The driver is used to support the backlight of
> the panel. This is based on v4.1-rc1.
>
> Change in v3:
> 1. Add suspend/resume function
> 2. Fix the formula for high_width calculation
> 3. Rewrite some code to make it easier to read
> 4. Add more information in the commit message
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
