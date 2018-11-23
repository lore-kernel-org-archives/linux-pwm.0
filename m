From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: kconfig: enable kona pwm to be built for cygnus
 arch
Date: Fri, 23 Nov 2018 11:25:38 +0100
Message-ID: <20181123102538.7gpabj7idmuraaid@pengutronix.de>
References: <20181121123508.25119-1-peron.clem@gmail.com>
 <20181122200536.ndgrxuxealtovngy@pengutronix.de>
 <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCcdt9Kk3z6gsr68O1JrPfan-ENpRjo0dnBaGxs4xDidOzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hello Clément,

On Fri, Nov 23, 2018 at 10:31:18AM +0100, Clément Péron wrote:
> On Thu, 22 Nov 2018 at 21:05, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > Related to this driver I have a set of questions: If the disable
> > callback completed, does the hardware still drive the pin? If yes, would
> > it be possible to disable the pin driver such that the pin gets high-Z?
> > If yes, how?
> 
> The output pin type is configured with the bit "21:16 PWMOUT_TYPE RW
> default 0x3F" in the Control register
> PWM_CONTROL_TYPE_SHIFT macro in the driver
> Datasheets says : "When set to 1 the PWM Output signal will have a
> push/pull type.When set to 0 the PWM Output signal will have an open
> drain output type.Recommend to leave it push/pull type."
> 
> In the driver we actually set push/pull mode for all channels :
> /* Set push/pull for all channels */
> for (chan = 0; chan < kp->chip.npwm; chan++)
> value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));

So if disabling the output driver was part of the requirements for
.disable the bcm-kona driver could not implement this for both inverted
and uninverted PWMs. (At least not without resorting to pinmuxing.)

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
