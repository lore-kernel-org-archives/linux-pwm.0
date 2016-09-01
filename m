From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: sun8i: Add PWM pin in H3
Date: Thu, 1 Sep 2016 22:06:12 +0900
Message-ID: <998fe271-138b-ea4a-99ac-4cd75eefc9c4@gmail.com>
References: <20160831082520.25962-1-woogyom.kim@gmail.com>
 <20160831082520.25962-2-woogyom.kim@gmail.com>
 <20160831162002.GI14379@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36022 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbcIANGT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2016 09:06:19 -0400
In-Reply-To: <20160831162002.GI14379@lukather>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 09/01/2016 01:20 AM, Maxime Ripard wrote:
> Hi Milo,
>
> On Wed, Aug 31, 2016 at 05:25:17PM +0900, Milo Kim wrote:
>> H3 PA5 pin is assigned for single PWM channel.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Cc: Chen-Yu Tsai <wens@csie.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
>> index fdf9fdb..05d0c4b 100644
>> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
>> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
>> @@ -360,6 +360,13 @@
>>  				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>>  			};
>>
>> +			pwm0_pin_a: pwm0@0 {
>> +				allwinner,pins = "PA5";
>> +				allwinner,function = "pwm0";
>> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>> +			};
>> +
>
> Is it used on any boards?
>
> If not, we have the policy of not merging the pinctrl nodes that are
> not used by anyone to avoid bloating the DT for no particular reason.

Yes, I have. It's Nano Pi M1 which was derived from Orange Pi PC.
The board DTS is ready to be sent out, but I'm not sure which is better.

	a) Send new board DTS file in other patch thread

	[PATCH v3 0/4] Add PWM feature in Allwinner H3
	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
	..
	[PATCH v3 4/4] pwm: sunxi: Add H3 support

	[PATCH] ARM: dts: sun8i: Add Nano Pi M1 support

Or

	b) Include the DTS in next patch-set v3
	[PATCH v3 0/4] Add PWM feature in Allwinner H3
	[PATCH v3 1/4] ARM: dts: sun8i: Add PWM pin in H3
	[PATCH v3 2/4] ARM: dts: sun8i: Add PWM controller node in H3
	[PATCH v3 3/4] ARM: dts: sun8i: Add Nano Pi M1 support
	...

I'd like to have your opinion.

Best regards,
Milo
