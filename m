From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in
 disabled state
Date: Tue, 20 Nov 2018 14:46:51 +0530
Message-ID: <20181120091651.cqqqi3tr43q3jnp3@vireshk-i7>
References: <20181107150125.7cpd4v5t7yi2254c@pengutronix.de>
 <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <CACRpkdZAew3bUea=iR4t-a7SVSMf=-CTeWfeU215uT_jQ-o81A@mail.gmail.com>
 <20181119083230.re3dtq4alnrojbnd@pengutronix.de>
 <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYeSTZSvK9URE5ZvwnGTXVCZad=ptCmUBrbDyozoJnfSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Michal.Vokac@ysoft.com, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, linux-pwm@vger.kernel.org, l.majewski@majess.pl, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@karo-electronics.de>, vincent.guittot@gmail.com
List-Id: linux-pwm@vger.kernel.org

On 20-11-18, 09:35, Linus Walleij wrote:
> The whole issue with splash screens and different hardware
> turned over to Linux in running state is a bit imperfect I would
> say, I think Viresh was working on boot constraints to get
> handover of different systems components into some kind
> of shape but maybe that stopped short because of the
> complexities involved.

It got stuck mostly due to lack of use-cases where that can be useful.
All I could find until now is LCD and earlycon stuff.

Though things may change soon after the interconnect subsystem gets
merged, as we will have bootloader requirements for each and every
device in that case which the boot loader enables and passes on to
kernel.

-- 
viresh
