From: John Crispin <john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH RESEND 4/4] pwm: mediatek: add MT2712/MT7622 support
Date: Thu, 22 Jun 2017 08:12:47 +0200
Message-ID: <05b53007-44de-a236-f592-aea8e75ced44@phrozen.org>
References: <1498032672-7172-1-git-send-email-zhi.mao@mediatek.com>
 <1498032672-7172-5-git-send-email-zhi.mao@mediatek.com>
 <4600cf23-5e59-df02-37dc-056cb4a9744c@phrozen.org>
 <1498111776.18841.10.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498111776.18841.10.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?WmhlbmJhbyBMaXUgKOWImOaMr+WunSk=?= <Zhenbao.Liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, =?UTF-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, =?UTF-8?B?WWluZ2pvZSBDaGVuICg/P+iLsea0sik=?= <Yingjoe.Chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWMMKQXVYFwzLw@public.gmane.org
List-Id: linux-pwm@vger.kernel.org



On 22/06/17 08:09, Zhi Mao wrote:
> Hi John,
>
> Thanks for your review the code and feedback.
> There are 3 issues in this patch:
> 1.adds PWM_CLK_DIV_MAX which really should go into its own patch
> 2.adds mtk_pwm_com_reg which should also go into its own patch
> 3.remove comments inline /*===*/
>
> for #1 and #3, I will modify them in the next release.
> but for #2, I want to discuss with you,
> adding the structure  "mtk_pwm_com_reg" is only for the registers of 
> MT2712 PWM8,
> so we want to keep this modification in this patch.
>
> what's your opinion about it?
> Any reply is welcome.
>
>
> Regards
> Zhi
>
>
>
>

Hi Zhi,

I just had another look and noticed that the CON registers are not at a 
fixed offset of 0x40 for the new pwm8 register so having 2) inside this 
patch makes sense. please explain in the description that this is the case

     John

>
> On Wed, 2017-06-21 at 20:22 +0800, John Crispin wrote:
>> On 21/06/17 10:11, Zhi Mao wrote:
>> > support multiple chip(MT2712, MT7622, MT7623)
>> This patch does more than add extra SoC support. It also
>> * adds PWM_CLK_DIV_MAX which really should go into its own patch
>> * adds mtk_pwm_com_reg which should also go into its own patch
>>
>> more comments inline
>>
>> >
>> > Signed-off-by: Zhi Mao <zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org <mailto:zhi.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>>
>> > ---
>> >   drivers/pwm/pwm-mediatek.c |   63 +++++++++++++++++++++++++++++++++++---------
>> >   1 file changed, 51 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
>> > index c803ff6..d520356 100644
>> > --- a/drivers/pwm/pwm-mediatek.c
>> > +++ b/drivers/pwm/pwm-mediatek.c
>> > @@ -16,6 +16,7 @@
>> >   #include <linux/module.h>
>> >   #include <linux/clk.h>
>> >   #include <linux/of.h>
>> > +#include <linux/of_device.h>
>> >   #include <linux/platform_device.h>
>> >   #include <linux/pwm.h>
>> >   #include <linux/slab.h>
>> [...]
>> > @@ -215,9 +238,25 @@ static int mtk_pwm_remove(struct platform_device *pdev)
>> >   	return pwmchip_remove(&pc->chip);
>> >   }
>> >
>> > +/*==========================================*/
>>
>> please remove these comment lines
>>
>>       John
>> > +static const struct mtk_com_pwm_data mt2712_pwm_data = {
>> > +	.pwm_nums = 8,
>> > +};
>> > +
>> > +static const struct mtk_com_pwm_data mt7622_pwm_data = {
>> > +	.pwm_nums = 6,
>> > +};
>> > +
>> > +static const struct mtk_com_pwm_data mt7623_pwm_data = {
>> > +	.pwm_nums = 5,
>> > +};
>> > +/*==========================================*/
>> > +
>> >   static const struct of_device_id mtk_pwm_of_match[] = {
>> > -	{ .compatible = "mediatek,mt7623-pwm" },
>> > -	{ }
>> > +	{.compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data},
>> > +	{.compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data},
>> > +	{.compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data},
>> > +	{},
>> >   };
>> >   MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
>> >
>>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
