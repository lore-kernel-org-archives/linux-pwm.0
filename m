From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
Date: Tue, 10 Mar 2020 08:05:58 -0700
Message-ID: <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
 <20200309214822.GA19773@roeck-us.net>
 <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Guru Das Srinagesh <gurus@codeaurora.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 3/10/20 5:08 AM, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Mon, Mar 09, 2020 at 02:48:22PM -0700, Guenter Roeck wrote:
>> On Mon, Mar 09, 2020 at 12:35:06PM -0700, Guru Das Srinagesh wrote:
>>> Because period and duty cycle are defined in the PWM framework structs
>>> as ints with units of nanoseconds, the maximum time duration that can be
>>> set is limited to ~2.147 seconds. Redefining them as u64 values will
>>> enable larger time durations to be set.
>>>
>>> As a first step, prepare drivers to handle the switch to u64 period and
>>> duty_cycle by replacing division operations involving pwm period and duty cycle
>>> with their 64-bit equivalents as appropriate. The actual switch to u64 period
>>> and duty_cycle follows as a separate patch.
>>>
>>> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
>>> macros:
>>> - DIV_ROUND_UP_ULL
>>> - DIV_ROUND_CLOSEST_ULL
>>> - div_u64
>>>
>>> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
>>> DIV64_* macros:
>>> - DIV64_U64_ROUND_CLOSEST
>>> - div64_u64
>>
>> There is no explanation why this is necessary. What is the use case ?
>> It is hard to imagine a real-world use case with a duty cycle of more
>> than 2 seconds.
> 
> When my Laptop is in suspend there is an LED that blinks with a period
> of approximately 5 seconds. (To be fair, the brightness is more a sinus
> than a rectangle, but still.)
> 

I don't see support in the LED subsystem to utilize the PWM framework directly
for blinking. Plus, you say yourself that it isn't a _real_ use case, just a
theoretic one.

Either case, the reason / use case for this series should be explained
in the summary patch. That is what it is for. That case is not made.

Guenter
