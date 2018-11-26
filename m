From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Mon, 26 Nov 2018 11:03:38 +0100
Message-ID: <20181126110338.725b144e@ipc1.ka-ro>
References: <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
        <20181116083430.7f1d8452@ipc1.ka-ro>
        <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
        <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
        <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
        <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
        <20181122190321.ktqegs7kpvhcemvi@pengutronix.de>
        <9da8c6d9-d97c-200c-d8e4-2eb9f73eedc5@ysoft.com>
        <20181125205612.aownvgjnpxhqyxed@pengutronix.de>
        <20181126101116.32819842@ipc1.ka-ro>
        <20181126091838.slfra2ncsvewhyqp@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126091838.slfra2ncsvewhyqp@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: =?UTF-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> Hallo Lothar,
> 
> On Mon, Nov 26, 2018 at 10:11:16AM +0100, Lothar Waßmann wrote:
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:  
> > > @Lothar: if Michal did something different than you expected, please
> > > tell us with a few more details.  
> >
> > No, Michal's findings are in sync with what I checked here.  
> 
> so this is a confirmation that the gpio handling cannot be dropped,
> right?
> 
It seems so.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
