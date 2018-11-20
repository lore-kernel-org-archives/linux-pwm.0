From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled state
Date: Tue, 20 Nov 2018 09:35:47 +0100
Message-ID: <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com> <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com> <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com> <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo> <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com> <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, viresh kumar <viresh.kumar@linaro.org>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, l.majewski@majess.pl, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Mon, Nov 19, 2018 at 9:32 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> To sumarize: When the pwm driver probes it is not yet clear if the idle
> state of the output pin is high or low. Even when the pinctrl device has
> an "init" and a "default" pinctrl, it is not yet fixed when its
> "default" is configured.
>
> The way Thierry wants to fix that is by disabling the output driver
> until the pwm is in use und rely on a pull-up or pull-down in hardware.
>
> The way I want to fix this is to only configure the pwm pin as part of
> the consumer. This is late enough that the consumer already requested
> and configured the pwm such that the idle level is known.
> Thierry's and Lothar's claim was that putting the pin setup of the pwm
> pin into the pwm consumer's pinctrl was forbidden. That's why I asked
> you as pinctrl maintainer if there is a requirement that I don't know
> of.

I think we need to be pragmatic and listen most to whoever has
the hardware and need to get it to work. The system needs
to come up in some reasonable way, preferably so that vendors
doing products with it do not have to apply a fat patch stack
to get that backlight working in an acceptable way. Else the
end result is out-of-tree code to paper over the issue and that
IMO is worse than some minor ugliness in the kernel.

However the whole ordeal points to a problem that is with the
pin control system and Thierry's and Lothar's intuition about this
is right in a way: if the pin control system could read out the
state of the hardware at boot (as we nowadays do with GPIO,
which also has a consumer flag cleverly named GPIOD_ASIS)
the whole thing would be no problem.

The same kind of goes for PWM itself in this case I guess.

The whole issue with splash screens and different hardware
turned over to Linux in running state is a bit imperfect I would
say, I think Viresh was working on boot constraints to get
handover of different systems components into some kind
of shape but maybe that stopped short because of the
complexities involved. Isn't that the real problem here?
https://lkml.org/lkml/2017/8/1/191

Yours,
Linus Walleij
