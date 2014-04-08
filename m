From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Tue, 8 Apr 2014 13:43:22 -0700
Message-ID: <CAAYSxhpqe1BVDigMKQ18qEpYNyHGFQ6n5cXWdnUO7HZKSCwzWQ@mail.gmail.com>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
	<20140402055350.GX17250@pengutronix.de>
	<20140407113652.GE26985@ulmo>
	<20140408070259.68923987@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140408070259.68923987@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Lothar_Wa=DFmann?= <LW@karo-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 7, 2014 at 10:02 PM, Lothar Wa=DFmann <LW@karo-electronics.=
de> wrote:
> Thierry Reding wrote:

>> No. You cannot emulate polarity inversion in software.
>>
> Why not?
>
> duty_ns =3D period_ns - duty_ns;

Since I made the same mistake, I will pass along the pointer Thierry ga=
ve me.

In include/linux/pwm.h the second difference for an inverted signal is
described.

/**
 * enum pwm_polarity - polarity of a PWM signal
 * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
 * cycle, followed by a low signal for the remainder of the pulse
 * period
 * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
 * cycle, followed by a high signal for the remainder of the pulse
 * period
 */
enum pwm_polarity {
PWM_POLARITY_NORMAL,
PWM_POLARITY_INVERSED,
};

Of course, I suspect not all PWM hardware respects this definition of
inverted output.

Either way, hacking the duty in software certainly would get the
high/low order wrong.

-Tim
