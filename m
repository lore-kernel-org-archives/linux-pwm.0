From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH v2] backlight: pwm: reject legacy pwm request for device
 defined in dt
Date: Thu, 15 Oct 2015 13:45:36 +0300
Message-ID: <561F83D0.8040400@mentor.com>
References: <1444652943-19712-1-git-send-email-vladimir_zapolskiy@mentor.com> <561BB2BC.9090907@atmel.com> <20151012153029.62f948d2@bbrezillon> <561BBB9F.6060808@mentor.com> <20151012160608.41f04553@bbrezillon> <561BC177.2050000@mentor.com> <20151012171931.3fb922d2@bbrezillon> <561BD282.70305@mentor.com> <20151013072941.GR17172@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63953 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbJOKrL (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Oct 2015 06:47:11 -0400
In-Reply-To: <20151013072941.GR17172@x1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Nicolas Ferre <nicolas.ferre@atmel.com>, Thierry Reding <thierry.reding@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Lee,

Lee,On 13.10.2015 10:29, Lee Jones wrote:
> On Mon, 12 Oct 2015, Vladimir Zapolskiy wrote:
> 
>> On 12.10.2015 18:19, Boris Brezillon wrote:
>>> On Mon, 12 Oct 2015 17:19:35 +0300
>>> Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com> wrote:
>>>>
>>>>> Thierry's patch makes sure that EPROBE_DEFER is not returned when the
>>>>> PWM device definition is not found using in the PWM lookup tables or
>>>>> the DT definition,
>>>>
>>>> This is okay, but I'm interested in proper handling of cases other than
>>>> EPROBE_DEFER. EPROBE_DEFER and the related issues are on your balance
>>>> and I'm attempting to avoid interfering with it here :)
>>>
>>> I keep thinking we should fix all platforms using the ->pwm_id pdata
>>> field to attach a PWM device to a PWM backlight instead of trying to
>>> guess when falling back to the legacy API is acceptable...
>>>
>>>>
>>>>> and in this case the pwm_bl code will fallback to
>>>>> the legacy PWM API, which AFAICT is what you're trying to solve.
>>>>
>>>> Fallback must happen exclusively under (IS_ERR(pb->pwm) &&
>>>> PTR_ERR(pb->pwm) != -EPROBE_DEFER && !pdev->dev.of_node) condition IMHO.
>>>>
>>>> Before EPROBE_DEFER appeared on the scene the condition was
>>>> (IS_ERR(pb->pwm) && !pdev->dev.of_node).
>>>>
>>>> So, the question is if my change requires any updates or not from your
>>>> point of view.
>>>
>>> ... but from a functional point of view your patch seems correct.
>>
>> Sounds good, thank you for review.
> 
> So should I take this patch, or not?
> 

Robert's testing shows no regression, please apply this change on top of
Nicolas' one.

--
With best wishes,
Vladimir
