From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v7 03/13] hwmon: pwm-fan: Use 64-bit division macros for
 period and duty cycle
Date: Tue, 10 Mar 2020 15:24:18 -0700
Message-ID: <20200310222418.GA8053@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
 <b503833e0f58bd6dd9fe84d866124e7c457e099e.1583782035.git.gurus@codeaurora.org>
 <20200309214822.GA19773@roeck-us.net>
 <20200310120814.4kjxmii3c7zxw55y@pengutronix.de>
 <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd6c7679-9569-2cf1-1664-61bf368d82dd@roeck-us.net>
Sender: linux-hwmon-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, Kamil Debski <kamil@wypas.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jean Delvare <jdelvare@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 10, 2020 at 08:05:58AM -0700, Guenter Roeck wrote:
> I don't see support in the LED subsystem to utilize the PWM framework directly
> for blinking. Plus, you say yourself that it isn't a _real_ use case, just a
> theoretic one.

An example use case is a mobile phone OEM that wishes to set a period of
5 seconds or more for, say, a low battery slow blinking indication - currently
this is not possible. The PWM framework not having direct support for
blinking should not be a concern if the PWM peripheral being controlled
supports it via register writes.

> Either case, the reason / use case for this series should be explained
> in the summary patch. That is what it is for. That case is not made.

Will upload a new patchset adding more details in the summary patch.

Thank you.

Guru Das.
