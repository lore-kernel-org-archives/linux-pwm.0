From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Fri, 16 Nov 2018 12:56:33 +0100
Message-ID: <20181116125633.4e110125@ipc1.ka-ro>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
        <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
        <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
        <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
        <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
        <20181114113449.GB2620@ulmo>
        <20181114215120.vddykljqyavm64wj@pengutronix.de>
        <20181115152545.GA8611@ulmo>
        <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
        <20181116095124.GA28631@ulmo>
        <20181116103929.cxfvuc2te7cadhp2@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116103929.cxfvuc2te7cadhp2@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hello Thierry,
> 
> On Fri, Nov 16, 2018 at 10:51:24AM +0100, Thierry Reding wrote:
> > On Thu, Nov 15, 2018 at 09:37:33PM +0100, Uwe Kleine-König wrote:  
> > > On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:  
[...]
> > But why? The backlight doesn't care about the specific pinmuxing of the
> > PWM pin. All it cares about is the PWM signal. That's the level of
> > abstraction that the PWM consumer expects, anything lower level belongs
> > in the PWM driver.  
> 
> The backlight driver cares about the PWM pin muxing because if it's
> wrongly muxed the backlight doesn't work as intended.
> 
With this argumentation you would also have to define the clocks needed
for the PWM in the backlight (or whatever pwm consumer) driver, because
if the clocks are not set up correctly the backlight won't work as
expected...

The PWM driver is driving the pins, so that is where the pinctrls
belong.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
