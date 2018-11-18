From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Sun, 18 Nov 2018 12:30:34 +0100
Message-ID: <20181118113034.pguv66idde5idinb@pengutronix.de>
References: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
 <20181116103929.cxfvuc2te7cadhp2@pengutronix.de>
 <20181116125633.4e110125@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181116125633.4e110125@ipc1.ka-ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello Lothar,

On Fri, Nov 16, 2018 at 12:56:33PM +0100, Lothar Waßmann wrote:
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> > On Fri, Nov 16, 2018 at 10:51:24AM +0100, Thierry Reding wrote:
> > > On Thu, Nov 15, 2018 at 09:37:33PM +0100, Uwe Kleine-König wrote:  
> > > > On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:  
> [...]
> > > But why? The backlight doesn't care about the specific pinmuxing of the
> > > PWM pin. All it cares about is the PWM signal. That's the level of
> > > abstraction that the PWM consumer expects, anything lower level belongs
> > > in the PWM driver.  
> > 
> > The backlight driver cares about the PWM pin muxing because if it's
> > wrongly muxed the backlight doesn't work as intended.
>
> With this argumentation you would also have to define the clocks needed
> for the PWM in the backlight (or whatever pwm consumer) driver, because
> if the clocks are not set up correctly the backlight won't work as
> expected...

The reason why I think it is sensible to put the PWM pin into the
consumer's pinctrl is that only after the consumer grabbed the PWM it is
fixed (in software) what the idle level is. So the pwm alone isn't
complete and it's not clear what to do with this pin. High-Z is probably
a good choice for most setups, but this relies on a PU or PD into the
right direction that isn't always present. (I'm currently working with
such a machine, where such a PD/PU is missing. Not entirely sure this is
a problem because maybe the display unit has a pull. Didn't take the
time yet to verify.) Also this needs some care because the PWM might
already running on purpose (e.g. to show a splash screen) then switching
to High-Z should be avoided.

So IMHO it is sensible to delay setting up the pinmux until the boundary
conditions are fixed. This is also the general idea with the involvement
of pinctrl stuff, but given that even without handling pinctrl specially
it already works just fine when the pwm is only muxed as part of the
consumer.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
