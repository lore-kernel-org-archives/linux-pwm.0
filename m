From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Date: Mon, 19 Nov 2018 09:48:22 +0100
Message-ID: <20181119084822.qljinfgxpjtumojk@pengutronix.de>
References: <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
 <20181116103929.cxfvuc2te7cadhp2@pengutronix.de>
 <20181116122445.GA25386@ulmo>
 <20181118200815.a6hkokt3otfm4yl4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181118200815.a6hkokt3otfm4yl4@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Sun, Nov 18, 2018 at 09:08:15PM +0100, Uwe Kleine-König wrote:
> On Fri, Nov 16, 2018 at 01:24:45PM +0100, Thierry Reding wrote:
> > On Fri, Nov 16, 2018 at 11:39:29AM +0100, Uwe Kleine-König wrote:
> > > Also note that you don't include the poor souls where there is no
> > > hardware pullup into the right direction.
> > 
> > The poor souls should speak up and then we can look into finding a good
> > solution for them. I'm pretty sure there must be some equivalent that
> > can be used for other users.
> 
> I think one of the boards that I'm working with has an enabled backlight
> at power on until the bootloader actively drives the related pwm to
> the right level (either using the pwm or the gpio function of the pin).
> I will double check that but assuming that is right, just disabling the
> output won't work here.

I just confirmed this. On the board I have in mind the backlight really
goes on during powerup. One of the first things the bootloader does is
to ensure the backlight goes off again by actively driving the
respective pin.

I fully agree with you this is unfortunate and the hardware team could
have made the situation smoother if there were a pull up. I guess asking
them to go back and fix that won't be accepted[1]. So please whatever
solution you force through, please consider it should work without a
sane pull and also with the imx SoCs before i.MX6 which cannot disable
the output driver via pinmux.

Best regards
Uwe

[1] Additionally this is a bought display+backlight+touch combo, so the
    right place to put the pull would be in this unit, because the board
    designer rightfully says: I won't put a pull up on my board because
    for the next batch we're maybe switching to the similar display
    combo that needs an active high signal for the backlight and I won't
    create another factor 2 for the board variants for stuff that can be
    fixed in software.

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
