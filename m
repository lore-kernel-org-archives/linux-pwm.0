From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] pwm: samsung: fix to use lowest div for large enough
 modulation bits
Date: Tue, 16 Aug 2016 11:10:45 +0200
Message-ID: <369cde8b-f761-4a0b-50b9-a3a01ba0b75d@samsung.com>
References: <1470133006-4272-1-git-send-email-sw0312.kim@samsung.com>
 <CGME20160816073709epcas1p45d975f43e8f7e3fc17e30cf6f6573dfb@epcas1p4.samsung.com>
 <329cb013-4832-c443-d593-327531db7b40@samsung.com>
 <57B2CDF0.8020809@samsung.com>
 <CA+Ln22Ha6qrbXP87wqJdTTsTD8vXbxZejt7aRkoni0YKpFJvZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:29258 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbcHPJKu (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 16 Aug 2016 05:10:50 -0400
In-reply-to: <CA+Ln22Ha6qrbXP87wqJdTTsTD8vXbxZejt7aRkoni0YKpFJvZQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, "sw0312.kim" <sw0312.kim@samsung.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Joonyoung Shim <jy0922.shim@samsung.com>

On 08/16/2016 11:00 AM, Tomasz Figa wrote:
> 2016-08-16 17:25 GMT+09:00 Seung-Woo Kim <sw0312.kim@samsung.com>:
>> Hi Krzysztof,
>>
>> On 2016년 08월 16일 16:37, Krzysztof Kozlowski wrote:
>>> On 08/02/2016 12:16 PM, Seung-Woo Kim wrote:
>>>> >From pwm_samsung_calc_tin(), there is routine to find the lowest
>>>> divider possible to generate lower frequency than requested one.
>>>> But it is always possible to generate requested frequency with
>>>> large enough modulation bits, so this patch fixes to use lowest
>>>> div for the case. This patch removes following UBSAN warning:
>>>>
>>>>    UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
>>>>    shift exponent 32 is too large for 32-bit type 'long unsigned int'
>>>>    [...]
>>>>    [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_out_of_bounds+0xd8/0x120)
>>>>    [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (pwm_samsung_config+0x508/0x6a4)
>>>>    [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0x174/0x40c)
>>>>    [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0x488)
>>>>    [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x70/0x150)
>>>>    [...]
>>>>
>>>> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
>>>> ---
>>>> The UBSAN warning from ARM is reported with the patch in following link:
>>>> https://patchwork.kernel.org/patch/9189575/
>>>> ---
>>>>  drivers/pwm/pwm-samsung.c |   10 +++++++---
>>>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
>>>> index ada2d32..ff0def6 100644
>>>> --- a/drivers/pwm/pwm-samsung.c
>>>> +++ b/drivers/pwm/pwm-samsung.c
>>>> @@ -193,9 +193,13 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
>>>>       * divider settings and choose the lowest divisor that can generate
>>>>       * frequencies lower than requested.
>>>>       */
>>>> -    for (div = variant->div_base; div < 4; ++div)
>>>> -            if ((rate >> (variant->bits + div)) < freq)
>>>> -                    break;
>>>> +    if (fls(rate) <= variant->bits) {
>>>> +            div = variant->div_base;
>>>> +    } else {
>>>> +            for (div = variant->div_base; div < 4; ++div)
>>>> +                    if ((rate >> (variant->bits + div)) < freq)
>>>> +                            break;
>>>> +    }
>>>
>>> I have trouble with understanding the idea behind initial code from
>>> Tomasz (commit 11ad39ede24ee). The variant->bits for all SoC except
>>> S3C24xx is 32. This means the shift:
>>>       if ((rate >> (variant->bits + div)) < freq)
>>> will be always by 32 or more... In practice this will choose always a
>>> "div" of 0 because in first iteration of this loop, the shift will be by 32.
>>
>> I also confused that part, but I figured out that the bit is used to
>> consider modulation bit to generate pwm signal from the input clock.
>>
>> Only the old s3c2440 has 16 bit modulation timer for pwm, and all later
>> soc has 32 bit modulation timer. So 32 bit timer cases, with the lowest
>> div, it can generate all frequencies which can be assigned with 32bit
>> variable.
>> But I uses fls() to consider 64bit case also even though there is no
>> really that kind of clock.
> 
> The code may look complicated (in fact I had to think a bit to recall
> what exactly it was supposed to do), but I'm not sure how it could be
> simplified. It's generally intended to handle variant->bits < 32 cases
> only and is effectively a no-op when variant->bits >= 32.

Right, a comment for this behavior would be very useful. No need to
waste time for re-thinking it later.

> I would suggest just making rate an u64 and be done with the warning.
> IMHO adding this kind of special cases only complicates the (already
> complicated) code unnecessarily.

u64 could solve the warning but then one would have to figure out
whether the casts are safe or not. Unsigned long is assigned to rate and
then returned.

How about specific check (+comment) like:
if (variant->bits < 32) {
	/* Only for s3c24xx */
	// the for loop as it was
} else {
	/* For other variants just choose lowest divider always */
	div = variant->div_base;
}

For me this is quite obvious and error-prone (explicit check for value
to be used in shift).

Best regards,
Krzysztof
