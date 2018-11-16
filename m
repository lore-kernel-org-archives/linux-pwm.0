From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Fri, 16 Nov 2018 08:34:30 +0100
Message-ID: <20181116083430.7f1d8452@ipc1.ka-ro>
References: <20181107093355.e4n3irrnkybqsjvc@pengutronix.de>
        <eb4e7a42-bd5c-3ae2-ccb7-d1a73d5ae99c@ysoft.com>
        <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
        <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
        <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
        <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
        <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
        <20181114113449.GB2620@ulmo>
        <20181114215120.vddykljqyavm64wj@pengutronix.de>
        <20181115152545.GA8611@ulmo>
        <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello Thierry,
> 
> On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> > On Wed, Nov 14, 2018 at 10:51:20PM +0100, Uwe Kleine-König wrote:  
> > > On Wed, Nov 14, 2018 at 12:34:49PM +0100, Thierry Reding wrote:  
[...]
> > > Also dts writes don't need to lookup the needed GPIO numbers and pinctrl.  
> > 
> > Just to clarify: I don't think that we need to get the GPIO number
> > involved in this case, because we don't have to reconfigure the pin as
> > GPIO to make this work. The only reason that Michal's proposal did that
> > is because that was believed to be necessary. But if the pin can just be
> > configured with a 100k pull-up, that's enough to pull the pin high when
> > we need it.  
> 
> Unless the gpio happens to be configured as output at the wrong value.
> Further I'm not sure if the pwm in disabled state actively pulls to 0
> and if in this state the PU of the pin is good enough to ensure a one
> here. That would need verification first.
> 
No. You can disable the output driver via pinctrl, so that only the
selected pull-up/down is relevant. The pin function and GPIO register
settings don't matter at all in this case.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
