From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled state
Date: Mon, 19 Nov 2018 08:44:38 +0100
Message-ID: <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
References: <20181012160854.hmgpokxgsrqdzobx@pengutronix.de>
 <e4289ee5-3fc1-2848-1cae-77d29b5ed93c@ysoft.com> <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
 <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com> <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com> <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com> <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo> <20181114215120.vddykljqyavm64wj@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114215120.vddykljqyavm64wj@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, l.majewski@majess.pl, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 14, 2018 at 10:51 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:
> > On Fri, Nov 09, 2018 at 05:55:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Fri, Nov 09, 2018 at 02:24:42PM +0000, Vok=C3=A1=C4=8D Michal wrot=
e:
> > > > On 8.11.2018 20:18, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Taking your example with the backlight device you specify an "ini=
t" and
> > > > > a "default" pinctrl and only "default" contains the muxing for th=
e PWM
> > > > > pin everything should be as smooth as necessary: The pwm is only =
muxed
> > > > > when the backlight device is successfully bound.
> > > >
> > > > Have you tried that Uwe? The bad news is I tested that before and n=
ow
> > > > again and it does not work like that. We already discussed that ear=
lier.
> > >
> > > The key is that the pinmux setting for the PWM pin should be part of =
the
> > > bl pinctrl, not the pwm pinctrl. Then "default" is only setup when th=
e
> > > bl device is successfully bound which is after the bl's .probe callba=
ck
> > > called pwm_apply().
> >
> > No, that's not at all correct. Pinmux settings should reside with the
> > consumer of the pin. In this case, the PWM is the consumer of the pin,
> > whereas the backlight is the consumer of the *PWM*.
>
> This is news to me. Adding Linus W. to Cc, maybe he can comment?!
>
> Grepping through the arm device trees it really seems common to put the
> pinctrl for the pwm pin into the pwm device. I didn't search in depth,
> but I didn't find a counter example.
>
> For GPIOs it is common that the pinmuxing is included in the GPIO's
> consumer pinctrl. Ditto for mdio busses whose pinctrl is included in the
> ethernet pinctrl.

There is quite a discussion you folks have going on here. I tried to
grasp it but I can't. I can try to answer the above question specifically.

For pin control it is mainly paramount that the state is associated
with *a* consumer. The problem we were facing when fleshing out
the subsystem can be seen in horrific solutions such as in
Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
where you see that pull-ups and pull-downs are set on the
PRODUCER side, which just make everything a complete
mess.

So compared to things like that (that we still have to support
forever) whatever you are doing here you're doing great as long
as it is consumer controlled.

Whether that consumer is the previous driver thingie in the
daisy-chain of consumers or the final end user consumer of
the pin doesn't really matter to pin control, as long as it is a
consumer. I would tend to say it is up to the subsystem,
and the old IETF motto "rough consensus and running code".

It seems in the current discussion the "rough consensus"
part is the problem, and I'm afraid I can't fix that.

Yours,
Linus Walleij
