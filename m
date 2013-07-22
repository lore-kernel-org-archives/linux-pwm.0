Return-Path: <daniel.lezcano@linaro.org>
Return-Path: <daniel.lezcano@linaro.org>
Message-ID: <51ED9C8C.10803@linaro.org>
Date: Mon, 22 Jul 2013 22:56:44 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 02/20] clocksource: samsung_pwm_timer: Correct definition
 of AUTORELOAD bit
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com> <1374278673-25615-4-git-send-email-tomasz.figa@gmail.com> <51ECABF1.4040600@linaro.org> <9612221.r4mx9bHE64@flatron>
In-Reply-To: <9612221.r4mx9bHE64@flatron>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-pwm.vger.kernel.org>
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On 07/22/2013 09:43 AM, Tomasz Figa wrote:
> On Monday 22 of July 2013 05:50:09 Daniel Lezcano wrote:
>> On 07/20/2013 02:04 AM, Tomasz Figa wrote:
>>> PWM channel 4 has its autoreload bit located at different position.
>>> This patch fixes the driver to account for that.
>>>
>>> This fixes a problem with the clocksource hanging after it overflows
>>> because it is not reloaded any more.
>>>
>>> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
>>> ---
>>>
>>>  drivers/clocksource/samsung_pwm_timer.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/samsung_pwm_timer.c
>>> b/drivers/clocksource/samsung_pwm_timer.c index 3fa5b07..e238fb0
>>> 100644
>>> --- a/drivers/clocksource/samsung_pwm_timer.c
>>> +++ b/drivers/clocksource/samsung_pwm_timer.c
>>> @@ -47,7 +47,8 @@
>>>
>>>  #define TCON_START(chan)		(1 << (4 * (chan) + 0))
>>>  #define TCON_MANUALUPDATE(chan)		(1 << (4 * (chan) + 1))
>>>  #define TCON_INVERT(chan)		(1 << (4 * (chan) + 2))
>>>
>>> -#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) + 3))
>>> +#define TCON_AUTORELOAD(chan)		(1 << (4 * (chan) \
>>> +						+ (((chan) < 5) ? 3 : 2)))
>>
>> This macro is not readable. Please, fix it up with a comment please.
> 
> /*
>  * Channel 4 (logically 5 in TCON register) has different position
>  * of autoreload bit.
>  */
> #define _TCON_AUTORELOAD(chan)			(1 << (4 * (chan) + 3))
> #define _TCON_AUTORELOAD4(chan)			(1 << (4 * (chan) + 2))
> #define TCON_AUTORELOAD(chan)			((chan < 5) ? 
> 		_TCON_AUTORELOAD(chan) : _TCON_AUTORELOAD4(chan))
> 
> What do you think?

I don't get the arithmetic here and the code is poor in comment. A nice
comment would valuable here.

May be you can replace 1 << bla by BIT(bla) ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
