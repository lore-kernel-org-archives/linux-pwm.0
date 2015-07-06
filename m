From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Add MediaTek display PWM driver
Date: Mon, 6 Jul 2015 20:43:31 +0800
Message-ID: <1436186611.32512.3.camel@mtksdaap41>
References: <1435590211-38854-1-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omANeUxcRdY-qQzxjtBY5Yhx56mSneuuXh+bGjbahKhDeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omANeUxcRdY-qQzxjtBY5Yhx56mSneuuXh+bGjbahKhDeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Daniel,

I will add PWM dtsi in the next patch and also fix the code with your
suggestions in other mails.

Regards,
YH Huang

On Tue, 2015-06-30 at 14:35 +0800, Daniel Kurtz wrote:
> Hi YH,
> 
> Please also include a patch that adds PWM bindings to mt8173.dtsi.
> The clock definitions (CLK_MM_DISP_PWM*) are added by James LIao's patch:
>   clk: mediatek: Add subsystem clocks of MT8173
> 
> I think it is ok to mention in the cover-letter that the PWM .dtsi
> change depends on that other patch.
> 
> Also, cover-letters usually contain a "shortlog" and diffstatm that
> gives summary of patches and changed files, generated along with the
> patches using:
>  git format-patch --cover-letter
> 
> Thanks,
> -Daniel
> 
> On Mon, Jun 29, 2015 at 11:03 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > This patch series add the use of display PWM driver and documentation
> > for Mediatek SoCs. The driver is used to support the backlight of
> > the panel. This is based on v4.1-rc1.
> >
> > Change in v3:
> > 1. Add suspend/resume function
> > 2. Fix the formula for high_width calculation
> > 3. Rewrite some code to make it easier to read
> > 4. Add more information in the commit message
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
