From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 12 May 2015 16:34:16 +0200
Message-ID: <CABuKBe+e2pjFmQ9Ne7XAeVwJzS8KOXa09CUUZPbYG=oVmP3ikA@mail.gmail.com>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
	<1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
	<20150512133202.GA24684@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512133202.GA24684-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

2015-05-12 15:32 GMT+02:00 Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Mon, May 11, 2015 at 05:26:22PM +0800, YH Huang wrote:
>> Add display PWM driver support to modify backlight for MT8173/MT6595.
>>
>> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
>> ---
>>  drivers/pwm/Kconfig             |   9 ++
>>  drivers/pwm/Makefile            |   1 +
>>  drivers/pwm/pwm-disp-mediatek.c | 225 ++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 235 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-disp-mediatek.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index b1541f4..9edbb5a 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -111,6 +111,15 @@ config PWM_CLPS711X
>>         To compile this driver as a module, choose M here: the module
>>         will be called pwm-clps711x.
>>
>> +config PWM_DISP_MEDIATEK
>
> Please make this "PWM_MEDIATEK_DISP" so we can keep everything sorted by
> vendor.
>
>> +     tristate "MEDIATEK display PWM driver"
>
> "MediaTek"?
>
>> +     depends on OF
>
> Technically I think you need depends on HAS_IOMEM here to avoid breakage
> on randconfig builds.
>
>> +     help
>> +       Generic PWM framework driver for mediatek disp-pwm device.
>
> "MediaTek"? Also perhaps this should describe what this PWM is instead
> of just the "disp-pwm" which leaves everyone guessing what it is. From
> the name I'd expect it to be the PWM that is used to control the
> backlight brightness for display, but I think this description should
> say that explicitly.
>
>> +
>> +       To compile this driver as a module, choose M here: the module
>> +       will be called pwm-disp-mediatek.
>
> pwm-mediatek-disp

I would prefert pwm-mtk-disp which is in line with the other drivers.
Also I have to admit that unfortunately the naming is not uniformly
throughout the kernel.

Thanks,
Matthias
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
