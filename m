From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v6 0/3] Add MediaTek display PWM driver
Date: Tue, 11 Aug 2015 11:38:29 +0800
Message-ID: <CAGS+omA6NCM_uwrXqz5W+m-dh9r7S_uSmb=Z8JAakQDTXY7pHQ@mail.gmail.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
 <2181696.fQcvS98Cqx@ubix> <1437729058.11386.4.camel@mtksdaap41> <1438582892.19953.4.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438582892.19953.4.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, YH Huang <yh.huang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, linux-pwm@vger.kernel.org, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>
List-Id: linux-pwm@vger.kernel.org

Thierry,

I think these patches are ready.
Will you please consider picking up in your pwm tree?

-Dan


On Mon, Aug 3, 2015 at 2:21 PM, YH Huang <yh.huang@mediatek.com> wrote:
> On Fri, 2015-07-24 at 17:10 +0800, YH Huang wrote:
>> On Fri, 2015-07-24 at 10:42 +0200, Matthias Brugger wrote:
>> > On Monday, July 20, 2015 04:17:14 PM YH Huang wrote:
>> > > This patch series add the use of display PWM driver, documentation
>> > > and device tree for Mediatek SoCs. The driver is used to support
>> > > the backlight of the panel. This is based on v4.2-rc1.
>> > >
>> > > The clock definitions (CLK_MM_DISP_PWM*) are added by James Liao's patch:
>> > > clk: mediatek: Add subsystem clocks of MT8173
>> > >
>> > > Change in v6:
>> > > 1. Enable clocks in the pwm_enable function
>> > > 2. Remove suspend/resume code since pwm-backlight driver has done the same
>> > > things 3. Revise some code to make it easier to read
>> > >
>> >
>> > Can you please provide the whole change log for all versions the next time.
>> > It's easier this way to understand the evolution of the series.
>>
>> Change in v6:
>> 1. Enable clocks in the pwm_enable function.
>> 2. Remove suspend/resume code since pwm-backlight driver has done the
>> same things.
>> 3. Revise some code to make it easier to read.
>>
>> Change in v5:
>> 1. Configure PWM output via pinctrl.
>> 2. Fix the parameter name in dtsi.
>>
>> Change in v4:
>> 1. Codebase is on v4.2-rc1.
>> 2. Add the PWM node in dtsi.
>> 3. Change the dependency in Kconfig.
>> 4. Rewrite some code for readability.
>>
>> Change in v3:
>> 1. Add suspend/resume function.
>> 2. Fix the formula for high_width calculation.
>> 3. Rewrite some code to make it easier to read.
>> 4. Add more information in the commit message.
>>
>> Change in v2:
>> 1. Rewrite descriptions for driver in kconfig to make it much clear.
>> 2. Rename the driver from "pwm-mediatek-disp" to "pwm-mtk-disp".
>> 3. Disable clocks in the error path.
>> 4. Change the shift values in decimal instead of hex.
>> 5. Rename and add some variables or function name for consistency and
>> readability.
>> 6. Drop unnecessary parentheses, spaces, variables and add newlines to
>> make the code easiler to read.
>>
>> Thanks for your suggestion.
>
> Hi Thierry,
>
> Do you have any suggestions?
> Maybe we could apply the patch?
>
> Regards,
> YH Huang
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
