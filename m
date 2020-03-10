From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
Date: Tue, 10 Mar 2020 15:57:34 -0700
Message-ID: <ba406ba4-8a2d-481d-11ab-9e282923e68c@roeck-us.net>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
 <20200309214822.GA19773@roeck-us.net>
 <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
 <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
 <20200310222418.GA8053@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200310222418.GA8053@codeaurora.org>
Content-Language: en-US
Sender: linux-hwmon-owner@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 3/10/20 3:24 PM, Guru Das Srinagesh wrote:
> On Tue, Mar 10, 2020 at 08:05:58AM -0700, Guenter Roeck wrote:
>> I don't see support in the LED subsystem to utilize the PWM framework directly
>> for blinking. Plus, you say yourself that it isn't a _real_ use case, just a
>> theoretic one.
> 
> An example use case is a mobile phone OEM that wishes to set a period of
> 5 seconds or more for, say, a low battery slow blinking indication - currently
> this is not possible. The PWM framework not having direct support for
> blinking should not be a concern if the PWM peripheral being controlled
> supports it via register writes.
> 
>> Either case, the reason / use case for this series should be explained
>> in the summary patch. That is what it is for. That case is not made.
> 
> Will upload a new patchset adding more details in the summary patch.
> 

Well, let's assume that this is a real use case.

Please also add information about alternatives considered, such as keeping
the second-part of the period in a separate variable.

Guenter
